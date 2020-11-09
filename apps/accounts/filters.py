import django_filters

from django.contrib.auth import get_user_model
from django.contrib.auth.models import Group, Permission
from django.db.models import Q

User = get_user_model()

class UserFilter(django_filters.rest_framework.FilterSet):
    """
    用户过滤类
    """
    username = django_filters.CharFilter(method='search_username')

    def search_username(self, queryset, name, value):
        return queryset.filter(Q(name__icontains=value)|Q(username__icontains=value))

    class Meta:
        model = User
        fields = ['username']


class GroupFilter(django_filters.rest_framework.FilterSet):
    """
    用户组过滤类
    """
    # name = django_filters.CharFilter(name='name',lookup_expr='icontains')
    name = django_filters.CharFilter(lookup_expr='icontains')

    class Meta:
        model = Group
        fields = ['name']

class PermissionFilter(django_filters.rest_framework.FilterSet):
    """
    权限过滤类
    """
    name = django_filters.CharFilter(method='search_permission')

    def search_permission(self, queryset, name, value):
        return queryset.filter(Q(codename__icontains=value)|Q(content_type__app_label__icontains=value)|Q(content_type__model__icontains=value))

    class Meta:
        model = Permission
        fields = ['name']