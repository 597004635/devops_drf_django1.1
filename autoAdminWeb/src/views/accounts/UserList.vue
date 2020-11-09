<template>
  <div class="user-list-container">
    <el-row :gutter="24">
      <el-col :span="12">
        <el-input v-model="search_user_key" placeholder="搜索" @keyup.enter.native="searchClick">
          <el-button slot="append" icon="el-icon-search" @click="searchClick" />
        </el-input>
      </el-col>
      <el-col :span="6" :offset="6" class="text-right">
        <el-button type="primary" @click="addUserClick">添加用户</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="userList" class="table" element-loading-text="拼命加载中" border>
      <el-table-column prop="username" label="用户名" align="center" />
      <el-table-column prop="name" label="姓名" width="90" align="center" />
      <el-table-column prop="phone" label="手机号" width="110" align="center" />
      <el-table-column prop="email" label="邮箱" align="center" />
      <el-table-column prop="is_active" label="登录状态" width="78" align="center">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.is_active" @change="statusChange(scope.row)" />
        </template>
      </el-table-column>
      <el-table-column prop="last_login" label="上次登录时间" width="155" align="center" />
      <el-table-column prop="" label="操作" width="215" align="center">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="checkRoleClick(scope.row)">查看角色</el-button>
          <el-button type="text" size="small" @click="chooceRoleClick(scope.row)">指定角色</el-button>
          <el-button type="text" size="small" @click="changeMobileClick(scope.row)">修改</el-button>
          <!--<el-button type="danger" size="small" icon="el-icon-delete" @click="deleteClick(scope.row)" />-->
          <el-button type="text" size="small" @click="deleteClick(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <div v-show="total_num>=10" class="text-center">
      <el-pagination :current-page.sync="page" :total="total_num" layout="total, prev, pager, next, jumper" background @current-change="paginationChange" />
    </div>

    <el-dialog :visible.sync="addUserFormVisible" title="添加用户">
      <el-form ref="addUserForm" :model="addUserForm" :rules="addUserRule" label-width="70px">
        <el-form-item label="登录名" prop="username">
          <el-input v-model="addUserForm.username" placeholder="请输入登录名" />
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <el-input v-model="addUserForm.name" placeholder="请输入姓名" />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="addUserForm.password" placeholder="请输入密码" />
        </el-form-item>
        <el-form-item label="手机号" prop="phone">
          <el-input v-model="addUserForm.phone" placeholder="请输入手机号" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="addUserFormVisible = false"> 取 消</el-button>
        <el-button type="primary" @click="submitAddClick">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog :visible.sync="checkRoleVisible" title="查看角色">
      <div class="text-center">
        <el-tag v-for="(item, index) in roleTags" :key="index" type="info" style="margin: 0 10px;">{{ item.name }}</el-tag>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="checkRoleVisible = false"> 取 消</el-button>
        <el-button type="primary" @click="checkRoleVisible = false">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog :visible.sync="chooseRoleVisible" title="指定角色">
      <el-form :model="chooseRole" label-width="70px">
        <el-form-item label="登录名">
          <el-input v-model="chooseRole.username" disabled />
        </el-form-item>
        <el-form-item label="角色">
          <el-select v-model="roles" multiple placeholder="请选择角色" style="width: 100%">
            <!--<el-option v-for="(item, index) in roles" :key="index" :label="item.name" :value="item.id" />-->
            <el-option v-for="(item, index) in rolesList" :key="index" :label="item.name" :value="item.id">{{ item.name }}</el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="chooseRoleVisible = false"> 取 消</el-button>
        <el-button type="primary" @click="submitChooseRoleClick">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog :visible.sync="changeMobileFormVisible" title="修改手机号">
      <el-form ref="changeMobileForm" :model="changeMobileForm" :rules="addUserRule" label-width="70px">
        <el-form-item label="登录名">
          <el-input v-model="changeMobileForm.username" placeholder="请输入登录名" disabled />
        </el-form-item>
        <el-form-item label="手机号" prop="phone">
          <el-input v-model="changeMobileForm.phone" placeholder="请输入手机号" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="changeMobileFormVisible = false"> 取 消</el-button>
        <el-button type="primary" @click="submitChangeMobileClick">确 定</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import { getUserList, updateUser, deleteUser, getGroupsList, addUser, getUserGroupsList, updateUserGroupsList } from '@/api/users'

export default {
  data() {
    const checkYNMobile = (rule, value, callback) => {
      if (!value || value.length === 11) {
        callback()
      } else {
        callback(new Error('请确保这个字段至少包含 11 个字符'))
      }
    }
    const validatePass = (rule, value, callback) => {
      if (value.length < 5) {
        callback(new Error('密码不能小于5位'))
      } else {
        callback()
      }
    }
    return {
      name: '',
      userList: [],
      total_num: 0,
      page: 1,
      listLoading: true,
      loading: true,
      search_user_key: '',
      userGroupList: [],
      addUserForm: {
        username: '',
        name: '',
        password: '',
        phone: ''
      },
      addUserRule: {
        username: [
          { required: true, message: '请输入登录名', trigger: 'blur' }
        ],
        name: [
          { required: true, message: '请输入姓名', trigger: 'blur' }
        ],
        password: [
          { required: true, trigger: 'blur', validator: validatePass }
        ],
        phone: [
          { required: false, validator: checkYNMobile, trigger: 'blur' }
        ]
      },
      rolesList: [], // 角色列表
      addUserFormVisible: false, // 增加用户弹框
      chooseRoleVisible: false, // 指定角色弹框
      chooseRole: {},
      roles: [],
      changeMobileFormVisible: false,
      changeMobileForm: {},
      checkRoleVisible: false,
      roleTags: []
    }
  },
  created() {
    this.fetchData()
    // 获取所有角色列表
    getGroupsList({ page_size: 0 }).then(res => {
      this.rolesList = res
    })
  },
  methods: {
    fetchData() {
      this.loading = true
      getUserList({ page: this.page, username: this.search_user_key }).then(res => {
        this.userList = res.results
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
      this.fetchData()
    },
    addUserClick() {
      this.addUserFormVisible = true
      if (this.$refs['addUserForm'] !== undefined) {
        this.$refs['addUserForm'].resetFields()
      }
    },
    submitAddClick() {
      this.$refs['addUserForm'].validate((valid) => {
        if (!valid) {
          return
        }
        const params = Object.assign({}, this.addUserForm)
        addUser(params).then(res => {
          this.addUserFormVisible = false
          this.fetchData()
          this.$message({
            message: '操作成功',
            type: 'success'
          })
        })
      })
    },
    statusChange(row) {
      updateUser(row.id, { is_active: row.is_active }).then(() => {
        this.fetchData()
        this.$message({
          message: '操作成功',
          type: 'success'
        })
      })
    },
    deleteClick(row) {
      this.$confirm('此操作将删除用户 【' + row.name + '】 , 是否继续? ', '提示', {
        confirmButtonText: '确定',
        cancelButtonClass: '取消',
        type: 'warning'
      }).then(() => {
        deleteUser(row.id).then(response => {
          this.$message({
            message: '删除用户 "' + row.name + '" 成功',
            type: 'success'
          })
          this.fetchData()
        })
      }).catch(() => {
        this.$message({
          message: '操作失败',
          type: 'error'
        })
      })
    },
    checkRoleClick(row) {
      this.roleTags = []
      getUserGroupsList(row.id, { page_size: 0 }).then(res => {
        this.roleTags = res
        if (this.roleTags.length > 0) {
          this.checkRoleVisible = true
        }
      })
    },
    chooceRoleClick(row) {
      this.roles = []
      this.chooseRoleVisible = true
      this.chooseRole = Object.assign({}, row)
      // 获取指定用户角色列表
      getUserGroupsList(row.id, { page_size: 0 }).then(res => {
        this.roles = res.map(item => {
          return item.id
        })
      })
    },
    submitChooseRoleClick() {
      if (!this.roles.length) {
        this.$message.error('请选择角色')
        return
      }
      updateUserGroupsList(this.chooseRole.id, { gid: this.roles }).then(res => {
        this.chooseRoleVisible = false
        this.$message({
          message: '操作成功',
          type: 'success'
        })
      })
    },
    changeMobileClick(row) {
      this.changeMobileFormVisible = true
      this.changeMobileForm = row
    },
    submitChangeMobileClick() {
      this.$refs['changeMobileForm'].validate((valid) => {
        if (!valid) {
          return
        }
        updateUser(this.changeMobileForm.id, { phone: this.changeMobileForm.phone }).then(() => {
          this.changeMobileFormVisible = false
          this.fetchData()
          this.$message({
            message: '操作成功',
            type: 'success'
          })
        })
      })
    }
  }
}
</script>

<style scoped>
.line{
  text-align: center;
}
</style>

