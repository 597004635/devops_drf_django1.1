from rest_framework.routers import DefaultRouter
from .views import UsersViewset, UserRegViewset, UserInfoViewset, GroupsViewset, UserGroupsViewset, GroupMembersViewset, PermissionsViewset,GroupPermissionsViewset

accounts_router = DefaultRouter()
accounts_router.register(r'userreg', UserRegViewset, base_name='userreg')
accounts_router.register(r'users', UsersViewset, base_name='users')
accounts_router.register(r'userinfo', UserInfoViewset, base_name='userinfo')

accounts_router.register(r'groups', GroupsViewset, base_name="groups")
accounts_router.register(r'usergroups',UserGroupsViewset, base_name="usergroups")
accounts_router.register(r'groupmembers', GroupMembersViewset, base_name="groupmembers")

accounts_router.register(r'permissions', PermissionsViewset, base_name="permissions")
accounts_router.register(r'grouppermissions', GroupPermissionsViewset, base_name="grouppermissions")