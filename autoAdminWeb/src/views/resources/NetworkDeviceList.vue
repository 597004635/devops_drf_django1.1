<template>
  <div class="user-list-container">
    <el-row :gutter="24">
      <el-col :span="12">
        <el-input v-model="search_key" placeholder="搜索" @keyup.enter.native="searchClick">
          <el-button slot="append" icon="el-icon-search" @click="searchClick" />
        </el-input>
      </el-col>
      <el-col :span="6" :offset="6" class="text-right">
        <el-button type="primary" @click="addClick">添加</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="dataList" class="table" element-loading-text="拼命加载中" border>
      <el-table-column prop="name" label="网卡名称" align="center" />
      <el-table-column prop="mac" label="MAC地址" align="center" />
      <el-table-column prop="host.hostname" label="所在主机" align="center" />
      <el-table-column prop="remark" label="备注" align="center" />
      <el-table-column prop="" label="操作" width="215" align="center">
        <template slot-scope="scope">
          <!--<el-button type="info" size="small" icon="el-icon-edit" @click="editClick(scope.row)" />-->
          <el-button type="text" size="small" @click="editClick(scope.row)">修改</el-button>
          <!--<el-button type="danger" size="small" icon="el-icon-delete" @click="deleteClick(scope.row)" />-->
          <el-button type="text" size="small" @click="deleteClick(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <div v-show="total_num>=10" class="text-center">
      <el-pagination :current-page.sync="page" :total="total_num" layout="total, prev, pager, next, jumper" background @current-change="paginationChange" />
    </div>
    <!--添加网卡 开始-->
    <el-dialog :visible.sync="isFormVisible" title="添加网卡">
      <el-form ref="addForm" :model="addForm" :rules="addRule" label-width="70px">
        <el-form-item label="网卡名称" prop="name">
          <el-input v-model="addForm.name" maxleng="15" placeholder="请输入名称" />
        </el-form-item>
        <el-form-item label="MAC地址" prop="mac">
          <el-input v-model="addForm.mac" maxleng="15" placeholder="请输入MAC地址" />
        </el-form-item>
        <el-form-item label="所在服务器" prop="host">
          <el-select class="select" v-model="addForm.host" filterable maxleng="15" placeholder="所在服务器">
            <el-option v-for="(item, index) in hostList" :key="index" :label="item.hostname" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="addForm.remark" placeholder="备注" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="isFormVisible = false"> 取 消</el-button>
        <el-button type="primary" @click="submitForm">确 定</el-button>
      </div>
    </el-dialog>
    <!--结束-->
    <!--修改网卡 开始-->
    <el-dialog :visible.sync="isEditFormVisible" title="修改网卡">
      <el-form ref="editForm" :model="editForm" :rules="addRule" label-width="70px">
        <el-form-item label="网卡名称" prop="name">
          <!--<el-input v-model="editForm.name" placeholder="请输入登录名" disabled />-->
          <el-input v-model="editForm.name" placeholder="请输入名称" />
        </el-form-item>
        <el-form-item label="MAC地址" prop="mac">
          <el-input v-model="editForm.mac" placeholder="请输入MAC地址" />
        </el-form-item>
        <el-form-item label="所在服务器" prop="host">
          <el-select class="select" v-model="editForm.host" filterable placeholder="所在服务器">
            <el-option v-for="(item, index) in hostList" :key="index" :label="item.hostname" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="editForm.remark" placeholder="备注" />
        </el-form-item>
      </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="isEditFormVisible = false"> 取 消</el-button>
          <el-button type="primary" @click="submitEditForm">确 定</el-button>
        </div>
    </el-dialog>
    <!--结束-->
  </div>
</template>

<script>
import { getNetworkDeviceList, addNetworkDevice, updateNetworkDevice, deleteNetworkDevice, getServerList } from '@/api/resources'

export default {
  data() {
    return {
      loading: false,
      dataList: [],
      idcList: [],
      hostList: [],
      total_num: 0,
      page: 1,
      state: 0,
      search_key: '',
      isFormVisible: false,
      isEditFormVisible: false,
      editForm: {},
      addForm: {
        name: '',
        mac: '',
        host: ''
      },
      addRule: {
        name: [
          { required: true, message: '请输入名称', trigger: 'blur' }
        ],
        mac: [
          { required: true, message: '请输入电源功率', trigger: 'blur' }
        ],
        host: [
          { required: true, message: '请选择所在服务器', trigger: 'blur' }
        ]
      }
    }
  },
  methods: {
    fetchData() {
      this.loading = true
      getNetworkDeviceList({ page: this.page, name: this.search_key }).then(res => {
        this.dataList = res.results
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
    addClick() {
      this.isFormVisible = true
      if (this.$refs['addForm'] !== undefined) {
        this.$refs['addForm'].resetFields()
      }
    },
    submitForm() {
      this.$refs['addForm'].validate((valid) => {
        if (!valid) {
          return
        }
        const params = Object.assign({}, this.addForm)
        addNetworkDevice(params).then(res => {
          this.isFormVisible = false
          this.fetchData()
          this.$message({
            message: '操作成功',
            type: 'success'
          })
        })
      })
    },
    deleteClick(row) {
      this.$confirm('此操作将删除网卡 【' + row.name + '】 , 是否继续? ', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteNetworkDevice(row.id).then(response => {
          this.$message({
            message: '删除网卡 "' + row.name + '" 成功',
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
    editClick(row) {
      if (this.$refs['editForm'] !== undefined) {
        this.$refs['editForm'].resetFields()
      }
      const { id, name, mac, remark } = row
      const { host } = { host: row.host.id }
      this.editForm = { id, name, mac, host, remark }
      this.isEditFormVisible = true
    },
    submitEditForm() {
      this.$refs['editForm'].validate((valid) => {
        if (!valid) {
          return
        }
        const id = this.editForm.id
        const params = this.editForm
        updateNetworkDevice(id, params).then(res => {
          this.isEditFormVisible = false
          this.fetchData()
          this.$message({
            message: '操作成功',
            type: 'success'
          })
        })
      })
    }
  },
  created() {
    this.state = 1
  },
  watch: {
    state() {
      this.fetchData()
      getServerList({ page_size: 0 }).then(res => {
        this.hostList = res
        console.log(res)
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

