from rest_framework import viewsets, response, status, mixins, permissions
from .filter import IdcFilter, CabinetFilter, ManufacturerFilter, ProductModelFilter, ProductFilter, ServerFilter, NetworkDeviceFilter, IpFilter
from .serializers import IdcSerializer, CabinetSerializer, ManufacturerSerializer, ProductModelSerializer, ProductSerializer, ServerSerializer, NetworkDeviceSerializer, IPSerializer, AutoReportSerializer
from .models import Idc, Cabinet, Manufacturer, ProductModel, Product, Server, NetworkDevice, IP

class IdcViewset(viewsets.ModelViewSet):
    """
    list:
      返回idc列表
    create:
      创建idc
    retrieve:
      返回idc记录
    destroy:
      删除idc记录
    update：
      更新idc记录
    """
    queryset = Idc.objects.all()
    serializer_class = IdcSerializer
    filter_class = IdcFilter
    filter_fields = ("name",)

    def destroy(self, request, *args, **kwargs):
        ret = {"status": 0}
        instance = self.get_object()
        if Cabinet.objects.filter(idc_id__exact=instance.id).count() != 0:
            ret["status"] = 1
            ret["errmsg"] = "该IDC还有机房记录，不能删除"
            return response.Response(ret, status=status.HTTP_200_OK)

        self.perform_destroy(instance)
        return response.Response(ret, status=status.HTTP_200_OK)


class CabinetViewset(viewsets.ModelViewSet):
    """
    list:
      返回机柜列表
    create:
      创建机柜记录
    retrieve:
      返回机柜记录
    destroy:
      删除删除记录
    update：
      更新机柜记录
    """
    queryset = Cabinet.objects.all()
    serializer_class = CabinetSerializer
    filter_class = CabinetFilter
    filter_fields = ("name", "idc")


class ManufacturerViewset(viewsets.ModelViewSet):
    """
    retrieve:
        返回指定制造商信息
    list:
        返回制造商列表
    update:
        更新制造商信息
    destroy:
        删除制造商记录
    create:
        创建制造商资源
    partial_update:
        更新部分字段

    """
    queryset = Manufacturer.objects.all()
    serializer_class = ManufacturerSerializer
    filter_class = ManufacturerFilter
    filter_fields = ("vendor_name",)

    def destroy(self, request, *args, **kwargs):
        ret = {"status": 0}
        instance = self.get_object()

        if ProductModel.objects.filter(vendor_id__exact=instance.id).count() != 0:
            ret["status"] = 1
            ret["errmsg"] = "该制造商还有产品型号记录，不能删除"
            return response.Response(ret, status=status.HTTP_200_OK)

        self.perform_destroy(instance)
        return response.Response(ret, status=status.HTTP_200_OK)


class ProductModelViewset(viewsets.ModelViewSet):
    """
    retrieve:
        返回指定产品型号信息
    list:
        返回产品型号列表
    update:
        更新产品型号信息
    destroy:
        删除产品型号记录
    create:
        创建产品型号资源
    partial_update:
        更新部分字段
    """
    queryset = ProductModel.objects.all()
    serializer_class = ProductModelSerializer
    filter_class = ProductModelFilter
    filter_fields = ("model_name",)


class ProductViewset(viewsets.ModelViewSet):
    """
    retrieve:
        返回指定业务线信息
    list:
        返回业务线列表
    update:
        更新业务线信息
    destroy:
        删除业务线记录
    create:
        创建业务线资源
    partial_update:
        更新部分字段
    """
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    extra_perms_map = {
        "GET": ["products.view_product"]
    }
    filter_class = ProductFilter
    filter_fields = ("pid",)

    def destroy(self, request, *args, **kwargs):
        ret = {"status": 0}
        instance = self.get_object()
        if instance.pid == 0:
            # 顶级业务线
            # 查找二级级业务线
            if Product.objects.filter(pid__exact=instance.id).count() != 0:
                ret["status"] = 1
                ret["errmsg"] = "该业务下还有二级业务线"
                return response.Response(ret, status=status.HTTP_200_OK)
        else:
            # 二级业务线
            if Server.objects.filter(server_purpose__id__exact=instance.id).count() != 0:
                ret["status"] = 1
                ret["errmsg"] = "该分组下还有产品线，不能删除"
                return response.Response(ret, status=status.HTTP_200_OK)

        self.perform_destroy(instance)
        return response.Response(ret, status=status.HTTP_200_OK)


class ProductManageViewSet(mixins.ListModelMixin,viewsets.GenericViewSet):
    """
    list:
        业务线管理
    """
    queryset = Product.objects.all()

    def list(self, request, *args, **kwargs):
        data = self.get_products()
        return response.Response(data)

    def get_products(self):
        ret = []
        for obj in self.queryset.filter(pid=0):
            node = self.get_node(obj)
            node["children"] = self.get_children(obj.id)
            ret.append(node)
        return ret

    def get_children(self, pid):
        ret = []
        for obj in self.queryset.filter(pid=pid):
            ret.append(self.get_node(obj))
        return ret

    def get_node(self, product_obj):
        node = {}
        node["id"] = product_obj.id
        node["label"] = product_obj.service_name
        node["pid"] = product_obj.pid
        return node


# class ServerViewset(viewsets.ReadOnlyModelViewSet, mixins.UpdateModelMixin):
class ServerViewset(viewsets.ModelViewSet):
    """
    list:
        获取服务器列表
    create:
        创建服务器
    retrieve:
        获取指定服务器记录
    update:
        修改服务器记录
    """
    queryset = Server.objects.all()
    serializer_class = ServerSerializer
    #extra_perms_map = {
    #    "GET": ["products.view_product"]
    #}
    filter_class = ServerFilter
    filter_fields = ('hostname', 'idc', 'cabinet', "service", "server_purpose", "server_type")

    def get_queryset(self):
        queryset = super(ServerViewset, self).get_queryset()
        queryset = queryset.order_by("id")
        return queryset


# class NetwokDeviceViewset(viewsets.ReadOnlyModelViewSet):
class NetwokDeviceViewset(viewsets.ModelViewSet):
    """
    list:
        获取网卡列表
    retrieve:
        获取指定网卡记录
    """
    queryset = NetworkDevice.objects.all()
    serializer_class = NetworkDeviceSerializer
    filter_class = NetworkDeviceFilter
    filter_fields = ("name",)


# class IPViewset(viewsets.ReadOnlyModelViewSet):
class IPViewset(viewsets.ModelViewSet):
    """
    list:
        获取网卡IP列表
    retrieve:
        获取指定网卡IP记录
    """
    queryset = IP.objects.all()
    serializer_class = IPSerializer
    filter_class = IpFilter
    filter_fields = ("ip_addr",)


class ServerAutoReportViewset(mixins.CreateModelMixin, viewsets.GenericViewSet):
    """
    agent采集的信息入库
    """
    queryset = Server.objects.all()
    serializer_class = AutoReportSerializer
    permission_classes = (permissions.AllowAny,)


class ServerCountViewset(viewsets.ViewSet,mixins.ListModelMixin):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = Server.objects.all()

    def list(self, request, *args, **kwargs):
        data = self.get_server_nums()
        return response.Response(data)

    def get_server_nums(self):
        ret = {
            "count": self.queryset.count(),
            "vm_host_num": self.queryset.filter(server_type__exact=0).count(),
            "phy_host_num": self.queryset.filter(server_type__exact=1).count(),
            "master_host_num": self.queryset.filter(server_type__exact=2).count()
        }
        return ret
