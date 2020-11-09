from django.contrib.auth import  get_user_model
from django.contrib.auth.models import Group, Permission
from django.db.models import Q
from rest_framework import viewsets, mixins, permissions, status, response
from rest_framework.response import Response
from rest_framework.generics import get_object_or_404
from .serializers import UserSerializer, UserRegSerializer, Groupserializer, PermissionSerializer


from .filters import UserFilter, GroupFilter, PermissionFilter
from accounts.common import get_user_obj, get_permission_obj
from menu.common import get_menu_tree
User = get_user_model()

class UserRegViewset(mixins.CreateModelMixin, mixins.UpdateModelMixin, viewsets.GenericViewSet):
    """
    create:
        创建用户

    update:
        修改密码
    """
    queryset = User.objects.all()
    serializer_class = UserRegSerializer

class UserInfoViewset(viewsets.ViewSet):
    """
    获取当前登陆的用户信息
    """
    permission_classes = (permissions.IsAuthenticated,)
    def list(self, request, *args, **kwargs):
        data = {
            "username": self.request.user.username,
            "name": self.request.user.name,
            "menus": get_menu_tree(self.request.user.get_view_permissions())
        }
        return Response(data)


class UsersViewset(viewsets.ModelViewSet):
    """
    retrieve:
        获取用户信息

    list:
        获取用户列表

    update:
        更新用户信息

    delete:
        删除用户
    """
    queryset = User.objects.all()
    serializer_class = UserSerializer
    filter_class = UserFilter
    filter_fields = ("username",)
    extra_perms_map = {
        "GET": ["users.show_user_list"]
    }

    def get_queryset(self):
        queryset = super(UsersViewset, self).get_queryset()
        queryset = queryset.order_by("id")
        queryset = queryset.exclude(is_superuser=True)
        return queryset


class GroupsViewset(viewsets.ModelViewSet):
    """
    list:
    返回用户组（角色）列表

    destroy:
    删除角色
    """
    queryset = Group.objects.all()
    serializer_class = Groupserializer
    filter_class = GroupFilter
    filter_fields = ("name",)

    def get_queryset(self):
        queryset = super(GroupsViewset, self).get_queryset()
        queryset = queryset.order_by("id")
        return queryset


class UserGroupsViewset(mixins.RetrieveModelMixin, mixins.UpdateModelMixin,viewsets.GenericViewSet):

    """
    retrieve:
    返回指定用户的所有角色

    update:
    修改当前用户的角色
    """
    queryset = User.objects.all()
    serializer_class = Groupserializer

    def retrieve(self, request, *args, **kwargs):
        user_obj = self.get_object()
        queryset = user_obj.groups.all()

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    def update(self, request, *args, **kwargs):
        user_obj = self.get_object()
        gids = request.data.get("gid", [])
        user_obj.groups = Group.objects.filter(id__in=gids)
        return Response(status=status.HTTP_204_NO_CONTENT)

    def get_queryset(self):
        queryset = super(UserGroupsViewset, self).get_queryset()
        return queryset.order_by("id")


class GroupMembersViewset(mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin, viewsets.GenericViewSet):
    """
    角色成员管理

    retrieve:
    返回指定组的成员列表

    update:
    往指定组里添加成员

    destroy:
    从指定组里删除成员
    """
    queryset = Group.objects.all()
    serializer_class = UserSerializer


    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        queryset = instance.user_set.all()
        username=request.GET.get("username", None)
        if username is not None:
            queryset = queryset.filter(Q(name__icontains=username)|Q(username__icontains=username))
        queryset = self.filter_queryset(queryset)
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    def update(self, request, *args, **kwargs):
        ret = {"status":0}
        group_obj = self.get_object()
        userobj = get_user_obj(request.data.get(request.data.get("uid", 0)))
        if userobj is None:
            ret["status"] = 1
            ret["errmsg"] = "用户错误"
        else:
            group_obj.user_set.add(userobj)
        return Response(ret, status=status.HTTP_200_OK)

    def destroy(self, request, *args, **kwargs):
        ret = {"status": 0}
        group_obj = self.get_object()
        userobj = get_user_obj(request.data.get("uid", 0))
        if userobj is None:
            ret["status"] = 1
            ret["errmsg"] = "用户错误"
        else:
            group_obj.user_set.remove(userobj)
        return Response(ret, status=status.HTTP_200_OK)


class PermissionsViewset(viewsets.ReadOnlyModelViewSet):
    """
    权限列表 视图类

    list:
      返回permission列表
    """
    queryset = Permission.objects.all()
    serializer_class = PermissionSerializer
    filter_class = PermissionFilter
    filter_fields = ("name",)

    def get_queryset(self):
        queryset = super(PermissionsViewset, self).get_queryset()
        queryset = queryset.order_by("content_type__id")
        return queryset

class GroupPermissionsViewset(viewsets.ReadOnlyModelViewSet, mixins.UpdateModelMixin, mixins.DestroyModelMixin):
    """
    用户组权限

    retrieve:
      返回用户组的权限列表
    update:
      给指定用户组增加权限，参数pid: permission id
    destroy:
      删除指定组下的权限，参数pid: permission id
    """
    queryset = Permission.objects.all()
    serializer_class = PermissionSerializer
    filter_class = PermissionFilter
    filter_fields = ("name",)

    def process_permission(self, group_permission_queryset, data):
        for record in data:
            try:
                group_permission_queryset.get(pk=record.get("id", None))
                record["status"] = True
            except:
                pass
        return data

    def get_group_permissions(self):
        groupobj = self.get_object()
        queryset = groupobj.permissions.all()
        queryset = self.filter_queryset(queryset)
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return response.Response(serializer.data)

    def get_modify_permissions(self):
        groupobj = self.get_object()
        group_permission_queryset = groupobj.permissions.all()
        queryset = Permission.objects.all()
        queryset = self.filter_queryset(queryset)
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(self.process_permission(group_permission_queryset, serializer.data))

        serializer = self.get_serializer(queryset, many=True)
        return response.Response(self.process_permission(group_permission_queryset, serializer.data))

    def retrieve(self, request, *args, **kwargs):
        modify = request.GET.get("modify", None)
        if modify is not None:
            return self.get_modify_permissions()
        else:
            return self.get_group_permissions()

    def get_object(self):
        queryset = Group.objects.all()
        lookup_url_kwarg = self.lookup_url_kwarg or self.lookup_field

        assert lookup_url_kwarg in self.kwargs, (
            'Expected view %s to be called with a URL keyword argument '
            'named "%s". Fix your URL conf, or set the `.lookup_field` '
            'attribute on the view correctly.' %
            (self.__class__.__name__, lookup_url_kwarg)
        )

        filter_kwargs = {self.lookup_field: self.kwargs[lookup_url_kwarg]}
        obj = get_object_or_404(queryset, **filter_kwargs)

        # May raise a permission denied
        self.check_object_permissions(self.request, obj)
        return obj

    def update(self, request, *args, **kwargs):
        ret = {"status": 0}
        groupobj = self.get_object()
        permission_obj = get_permission_obj(request.data.get("pid", ""))
        if permission_obj is None:
            ret["status"] = 1
            ret["errmsg"] = "permission 不存在"
        else:
            groupobj.permissions.add(permission_obj)
        return response.Response(ret, status=status.HTTP_200_OK)

    def destroy(self, request, *args, **kwargs):
        ret = {"status": 0}
        groupobj = self.get_object()
        permission_obj = get_permission_obj(request.data.get("pid", ""))
        if permission_obj is None:
            ret["status"] = 1
            ret["errmsg"] = "permission 不存在"
        else:
            groupobj.permissions.remove(permission_obj)
        return response.Response(ret, status=status.HTTP_200_OK)

