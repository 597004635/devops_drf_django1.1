<template>
  <div class="user-list-container">
    <!--<div style="margin-bottom: 20px;font-size: 14px;">{{ '修改权限: ' + name }}</div>-->
    <el-row :gutter="24">
      <el-col :span="12">
        <el-input v-model="search_name" placeholder="搜索" @keyup.enter.native="searchClick">
          <el-button slot="append" icon="el-icon-search" @click="searchClick" />
        </el-input>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="permissionList" class="table" element-loading-text="拼命加载中" border>
      <el-table-column prop="content_type.app_label" label="app" align="center" />
      <el-table-column prop="content_type.model" label="model" align="center" />
      <el-table-column prop="content_type.codename" label="code_name" align="center" />
      <el-table-column prop="name" label="描述" align="center" />
      <el-table-column prop="" label="操作" align="center">
        <template slot-scope="scope">
          <el-switch v-model="scope.row.status" @change="statusChange(scope.row)" />
        </template>
      </el-table-column>
    </el-table>

    <div v-show="total_num>=10" class="text-center">
      <el-pagination :current-page.sync="page" :total="total_num" layout="total, prev, pager, next, jumper" background @current-change="paginationChange" />
    </div>
  </div>
</template>

<script>
import { getGroupPermissionsList, deleteGroupPermissions, updateGroupPermissions } from '@/api/users'
export default {
  data() {
    return {
      permissionList: [],
      permission: [],
      total_num: 0,
      page: 1,
      loading: true,
      search_name: '',
      gid: ''
    }
  },
  created() {
    const query = this.$route.query
    this.name = query.name
    this.gid = query.gid
    this.fetchData()
  },
  methods: {
    fetchData() {
      this.loading = true
      // getGroupPermissionsList(this.gid, { page: this.page, name: this.search_name, modify: true }).then(res => {
      getGroupPermissionsList(this.gid, { page: this.page, name: this.search_name }).then(res => {
        this.permissionList = res.results
        console.log(res.results)
        this.total_num = res.count
        this.loading = false
      })
    },
    searchClick() {
      this.page = 1
      this.fetchData()
    },
    statusChange(row) {
      row.status = !row.status
      if (row.status) {
        deleteGroupPermissions(this.gid, { pid: row.id }).then(res => {
          row.status = !row.status
          this.$message.success('删除权限成功！')
        })
      } else {
        updateGroupPermissions(this.gid, { pid: row.id }).then(res => {
          row.status = !row.status
          this.$message.success('添加权限成功!')
        })
      }
    },
    paginationChange(val) {
      this.page = val
      this.fetchData()
    }
  }
}
</script>
