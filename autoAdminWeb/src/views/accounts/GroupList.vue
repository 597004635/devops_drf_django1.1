<template>
  <div class="user-list-container">
    <el-row :gutter="24">
      <el-col :span="12">
        <el-input v-model="search_role" placeholder="搜索" @keyup.enter.native="searchClick">
          <el-button slot="append" icon="el-icon-search" @click="searchClick" />
        </el-input>
      </el-col>
      <el-col :span="6" :offset="6" class="text-right">
        <el-button type="primary" @click="addRoleClick">添加角色</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="groupList" class="table" element-loading-text="拼命加载中" border>
      <el-table-column prop="name" label="角色名" align="center" />
      <el-table-column label="成员管理" align="center">
        <template slot-scope="scope">
          <el-button size="small" type="text" @click.native.prevent="groupMemberClick(scope.row.id)">{{ '成员列表 （' +scope.row.member+ '）人' }}</el-button>
        </template>
      </el-table-column>

      <el-table-column prop="" label="api接口权限" align="center">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="checkPermissionClick(scope.row.id)">查看</el-button>
          <el-button type="text" size="small" @click="changePermissionClick(scope.row)">修改</el-button>
        </template>
      </el-table-column>

      <el-table-column prop="" label="前端权限" align="center">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="showGroupMenus(scope.row.id)">查看</el-button>
          <el-button type="text" size="small" @click="changeGroupMenus(scope.row.id)">修改</el-button>
        </template>
      </el-table-column>

      <el-table-column prop="" label="操作" align="center">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="deleteGroupClick(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <div v-show="total_num>=10" class="text-center">
      <el-pagination :total="total_num" :current-page.sync="page" layout="total, prev, pager, next, jumper" background @current-change="paginationChange" />
    </div>

    <el-dialog :visible.sync="addRoleVisible" title="添加角色">
      <el-form ref="addRoleForm" :model="addRoleForm" :rules="addRoleRule" label-width="70px">
        <el-form-item label="角色名" rop="name">
          <el-input v-model="addRoleForm.name" placeholder="请输入角色名" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="addRoleVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitAddRoleClick">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog :visible.sync="groupMemberListVisible" title="成员列表">
      <el-row :gutter="24">
        <el-col :span="12" >
          <el-input v-model="groupMemberSearchKey" placeholder="搜索" @keyup.enter.native="groupMemberSearchClick">
            <el-button slot="append" icon="el-icon-search" @click="groupMemberSearchClick" />
          </el-input>
        </el-col>
      </el-row>
      <el-table
        v-loading="groupMemberLoading"
        :data="groupMemberListData"
        element-loading-text="拼命加载中"
        border
        class="table">
        <el-table-column prop="username" label="用户名" align="center" />
        <el-table-column prop="name" label="姓名" align="center" />
        <el-table-column prop="email" label="邮箱" align="center" />
        <el-table-column prop="ncfgroupuser.title" label="上次登录时间" align="center" />
        <el-table-column prop="" label="操作" align="center">
          <template slot-scope="scope">
            <el-button size="small" type="text" @click="groupMemberDeleteClick(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div v-show="groupMemberTotal>=10" class="text-center">
        <el-pagination
          :total="groupMemberTotal"
          :current-page.sync="groupMemberPage"
          layout="total, prev, pager, next, jumper"
          background
          @current-change="groupMemberPaginationChange"
        />
      </div>
    </el-dialog>
    <el-dialog :visible.sync="checkPermissionVisible" title="查看权限">
      <el-table
        v-loading="permissionloading"
        :data="permissionList"
        element-loading-text="拼命加载中"
        border
        height="300">
        <el-table-column type="index" width="50" label="序号" align="center" />
        <el-table-column label="权限名" align="center">
          <template slot-scope="scope">
            {{ scope.row.content_type.app_label + '.' + scope.row.codename }}
          </template>
        </el-table-column>
        <el-table-column prop="name" label="描述" align="center" />
      </el-table>
    </el-dialog>
    <el-dialog :visible.sync="modifyGroupPermissionVisible" title="修改权限" width="1000px">
      <el-row :gutter="24">
        <el-col :span="12" >
          <el-input v-model="modifyGroupPermissionSearchKey" placeholder="搜索" @keyup.enter.native="modifyGroupPermissionSearchClick">
            <el-button slot="append" icon="el-icon-search" @click="modifyGroupPermissionSearchClick" />
          </el-input>
        </el-col>
      </el-row>
      <el-table
        v-loading="modifyGroupPermissionLoading"
        :data="modifyGroupPermissionData"
        element-loading-text="拼命加载中"
        border
        class="table">
        <el-table-column prop="content_type.app_label" label="app" align="center" />
        <el-table-column prop="content_type.model" label="model" align="center" />
        <el-table-column prop="codename" label="code name" align="center" />
        <el-table-column prop="name" label="描述" align="center" />
        <el-table-column prop="" label="操作" align="center">
          <template slot-scope="scope">
            <el-switch v-model="scope.row.status" @change="modifyGroupPermissionChangeStatus(scope.row)">status</el-switch>
          </template>
        </el-table-column>
      </el-table>
      <!--<div v-show="total_num>=10" class="text-center">-->
      <div v-show="modifyGroupPermissionTotal>=10" class="text-center">
        <el-pagination
          :total="modifyGroupPermissionTotal"
          :current-page.sync="modifyGroupPermissionPage"
          page-size="6"
          layout="total, prev, pager, next, jumper"
          background
          @current-change="modifyGroupPermissionPaginationChange"
        />
      </div>
    </el-dialog>
    <el-dialog :visible.sync="groupMenuVisible" title="查看前端菜单" width="400px">
      <el-tree
        ref="tree"
        :data="menuData"
        :show-checkbox="menuFlag"
        :render-content="renderContent"
        :default-checked-keys="defaultCheckedKeys"
        node-key="id"
        default-expand-all
        highlight-current
      >tree
      </el-tree>
      <span slot="footer" class="dialog-footer">
        <el-button @click="groupMenuVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitGroupMenus">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { getGroupsList, addRole, getGroupPermissionsList, deleteGroup, getGroupMenuList, updateGroupMenu, getGroupMembers, deleteGroupMember, deleteGroupPermissions, updateGroupPermissions } from '@/api/users'

export default {
  data() {
    return {
      groupList: [],
      total_num: 0,
      page: 1,
      loading: false,
      search_role: '',
      checkPermissionVisible: false,
      permissionloading: false,
      permissionList: [],
      addRoleVisible: false,
      addRoleForm: {
        name: ''
      },
      addRoleRule: {
        name: [
          { required: true, message: '请输入角色名', trigger: 'blur' }
        ]
      },
      groupMemberListVisible: false,
      groupMemberListData: [],
      groupMemberPage: 1,
      groupMemberLoading: false,
      groupMemberGID: 0,
      groupMemberSearchKey: '',
      groupMemberTotal: 0,
      modifyGroupPermissionVisible: false,
      modifyGroupPermissionSearchKey: '',
      modifyGroupPermissionPage: 1,
      modifyGroupPermissionLoading: false,
      modifyGroupPermissionGID: 0,
      modifyGroupPermissionData: [],
      modifyGroupPermissionTotal: 0,
      menuFlag: false,
      groupMenuVisible: false,
      menuData: [],
      defaultCheckedKeys: [],
      menuModifyData: {
        gid: 0, // 当前修改的组id
        mid: [] //
      }
    }
  },
  created() {
    this.fetchData()
    // this.fetchGroupData()
  },
  methods: {
    fetchData() {
      this.loading = true
      getGroupsList({ page: this.page, name: this.search_role }).then(res => {
        this.groupList = res.results
        this.total_num = res.count
        this.loading = false
      })
    },
    searchClick() {
      this.page = 1
      this.fetchData()
    },
    paginationChange(val) {
      this.page = val
      console.log(val)
      this.fetchData()
    },
    checkPermissionClick(id) {
      this.checkPermissionVisible = true
      this.permissionloading = true
      this.permissionList = []
      getGroupPermissionsList(id, { page_size: 0 }).then(res => {
        this.permissionList = res
        this.permissionloading = false
      })
    },
    changePermissionClick(row) {
      this.modifyGroupPermissionGID = row.id
      this.modifyGroupPermissionVisible = true
      this.modifyGroupPermissionData = []
      this.modifyGroupPermissionTotal = 0
      this.fetchModifyGroupPermissionData()
    },
    addRoleClick() {
      this.addRoleVisible = true
      if (this.$refs['addRoleForm'] !== undefined) {
        this.$refs['addRoleForm'].resetFields()
      }
    },
    submitAddRoleClick() {
      this.$refs['addRoleForm'].validate((valid) => {
        if (!valid) {
          return
        }
        addRole({ name: this.addRoleForm.name }).then(res => {
          this.addRoleVisible = false
          this.fetchData()
        })
      })
    },
    deleteGroupClick(row) {
      this.$confirm('此操作将删除用户组 【' + row.name + '】 , 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteGroup(row.id).then(res => {
          this.$message({
            message: '删除用户 “' + row.name + '” 成功',
            type: 'success'
          })
          this.fetchData()
        })
      }).catch(() => { })
    },
    groupMemberClick(gid) {
      this.groupMemberGID = gid
      this.groupMemberListVisible = true
      this.fetchGroupMemberList()
    },
    renderContent(h, { node, data, store }) {
      // 用于格式化tree
      return (
        <span style='flex: 1; display: flex; align-items: center; justify-content: space-between; font-size: 14px; padding-right: 8px;'>
          <span>
            <span>{node.label}</span>
          </span>
          <span>
            { data.show ? '显示' : '隐藏' }
          </span>
        </span>
      )
    },
    showGroupMenus(gid) {
      this.menuData = []
      this.menuFlag = false
      this.groupMenuVisible = true
      getGroupMenuList(gid).then(res => {
        this.menuData = res
      })
    },
    changeGroupMenus(gid) {
      this.menuData = []
      this.menuFlag = true
      this.groupMenuVisible = true
      this.menuModifyData.gid = gid
      this.defaultCheckedKeys = []
      getGroupMenuList(gid, { modify: true }).then(res => {
        this.menuData = res.data
        this.defaultCheckedKeys = res.permissions
      })
    },
    submitGroupMenus() {
      if (!this.menuFlag) {
        this.groupMenuVisible = false
        return
      }
      console.log(this.$refs.tree.getCheckedKeys())
      updateGroupMenu(this.menuModifyData.gid, { mid: this.$refs.tree.getCheckedKeys() }).then(res => {
        this.groupMenuVisible = false
        this.$message({
          message: '操作成功',
          type: 'success'
        })
      })
    },
    fetchGroupMemberList() {
      this.groupMemberLoading = true
      getGroupMembers(this.groupMemberGID, { page: this.groupMemberPage, username: this.groupMemberSearchKey }).then(res => {
        this.groupMemberListData = res.results
        this.groupMemberTotal = res.count
        this.groupMemberLoading = false
      })
    },
    groupMemberSearchClick() {
      this.groupMemberPage = 1
      this.fetchGroupMemberList()
    },
    groupMemberPaginationChange(val) {
      this.groupMemberPage = val
      this.fetchGroupMemberList()
    },
    groupMemberDeleteClick(row) {
      this.$confirm('此操作将删除组成员 【' + row.name + '】 , 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteGroupMember(this.groupMemberGID, { uid: row.id }).then(res => {
          this.$message({
            message: '删除组成员 “' + row.name + '” 成功',
            type: 'success'
          })
          this.fetchGroupMemberList()
          this.fetchData()
        })
      }).catch(() => { })
    },
    fetchModifyGroupPermissionData() {
      this.modifyGroupPermissionLoading = true
      getGroupPermissionsList(this.modifyGroupPermissionGID, { page: this.modifyGroupPermissionPage, page_size: 6, name: this.modifyGroupPermissionSearchKey, modify: true }).then(res => {
        this.modifyGroupPermissionData = res.results
        this.modifyGroupPermissionTotal = res.count
        this.modifyGroupPermissionLoading = false
      })
    },
    modifyGroupPermissionSearchClick() {
      this.modifyGroupPermissionPage = 1
      this.fetchModifyGroupPermissionData()
    },
    modifyGroupPermissionChangeStatus(row) {
      row.status = !row.status
      if (row.status) {
        deleteGroupPermissions(this.modifyGroupPermissionGID, { pid: row.id }).then(res => {
          row.status = !row.status
          this.$message.success('删除权限成功！')
        })
      } else {
        updateGroupPermissions(this.modifyGroupPermissionGID, { pid: row.id }).then(res => {
          row.status = !row.status
          this.$message.success('添加权限成功！')
        })
      }
    },
    modifyGroupPermissionPaginationChange(val) {
      this.modifyGroupPermissionPage = val
      this.fetchModifyGroupPermissionData()
    }
  }
}
</script>
