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
      <el-table-column prop="name" label="IDC名称" align="center" />
      <el-table-column prop="letter" label="字母简称" align="center" />
      <el-table-column prop="tel" label="联系电话" align="center" />
      <el-table-column prop="mail" label="邮箱" align="center" />
      <el-table-column prop="address" label="地址" align="center" />
      <el-table-column prop="remark" label="备注" align="center" />
      <el-table-column prop="" label="操作" width="215" align="center">
        <template slot-scope="scope">
          <el-button type="primary" size="small" icon="el-icon-edit" @click="editClick(scope.row)">编辑</el-button>
          <el-button type="danger" size="small" icon="el-icon-delete" @click="deleteClick(scope.row)">删除</el-button>
          <!--<el-button type="text" size="small" @click="deleteClick(scope.row)">删除</el-button>-->
        </template>
      </el-table-column>
    </el-table>

    <div v-show="total_num>=10" class="text-center">
      <el-pagination :current-page.sync="page" :total="total_num" layout="total, prev, pager, next, jumper" background @current-change="paginationChange" />
    </div>

    <el-dialog :visible.sync="isFormVisible" title="添加IDC">
      <el-form ref="addForm" :model="addForm" :rules="addRule" label-width="80px">
        <el-form-item label="IDC名称" prop="name">
          <el-input v-model="addForm.name" maxleng="15" placeholder="请输入IDC名称" />
        </el-form-item>
        <el-form-item label="字母简称" prop="letter">
          <el-input v-model="addForm.letter" maxleng="10" placeholder="请输入字母简称" />
        </el-form-item>
        <el-form-item label="联系电话" prop="tel">
          <el-input v-model="addForm.tel" maxleng="15" placeholder="请输入联系电话" />
        </el-form-item>
        <el-form-item label="邮箱" prop="mail">
          <el-input v-model="addForm.mail" maxleng="20" placeholder="请输入邮箱" />
        </el-form-item>
        <el-form-item label="地址" prop="address">
          <el-input v-model="addForm.address" maxleng="30" placeholder="请输入地址" />
        </el-form-item>
        <el-form-item label="备注" prop="remark" maxleng="50">
          <el-input v-model="addForm.remark" placeholder="备注" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="isFormVisible = false"> 取 消</el-button>
        <el-button type="primary" @click="submitForm">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog :visible.sync="isEditFormVisible" title="修改IDC">
      <el-form ref="editForm" :model="editForm" :rules="addRule" label-width="80px">
        <el-form-item label="IDC名称" prop="name">
          <!--<el-input v-model="editForm.name" placeholder="请输入登录名" disabled />-->
          <el-input v-model="editForm.name" maxleng="15" placeholder="请输入IDC名称" />
        </el-form-item>
        <el-form-item label="字母简称" prop="letter">
          <el-input v-model="editForm.letter" maxleng="10" placeholder="请输入字母简称" />
        </el-form-item>
        <el-form-item label="联系电话" prop="tel">
          <el-input v-model="editForm.tel" maxleng="15" placeholder="请输入联系电话" />
        </el-form-item>
        <el-form-item label="邮箱" prop="mail">
          <el-input v-model="editForm.mail" maxleng="20" placeholder="请输入邮箱" />
        </el-form-item>
        <el-form-item label="地址" prop="address">
          <el-input v-model="editForm.address" maxleng="30" placeholder="请输入地址" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="editForm.remark" maxleng="50" placeholder="备注" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="isEditFormVisible = false"> 取 消</el-button>
        <el-button type="primary" @click="submitEditForm">确 定</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import { getIdcsList, addIdc, updateIdc, deleteIdc } from '@/api/resources'

export default {
  data() {
    return {
      // listLoading: true,
      loading: false,
      dataList: [],
      total_num: 0,
      page: 1,
      state: 0,
      search_key: '',
      isFormVisible: false,
      isEditFormVisible: false,
      editForm: {},
      addForm: {
        name: '',
        letter: '',
        mail: '',
        tel: '',
        address: '',
        remark: ''
      },
      addRule: {
        name: [
          { required: true, message: '请输入IDC名称', trigger: 'blur' }
        ],
        letter: [
          { required: true, message: '请输入字母简称', trigger: 'blur' }
        ]
      }
    }
  },
  methods: {
    fetchData() {
      this.loading = true
      getIdcsList({ page: this.page, name: this.search_key }).then(res => {
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
        addIdc(params).then(res => {
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
      this.$confirm('此操作将删除IDC 【' + row.name + '】 , 是否继续? ', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteIdc(row.id).then(response => {
          this.$message({
            message: '删除IDC "' + row.name + '" 成功',
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
      const { id, name, letter, tel, mail, address, remark } = row
      this.editForm = { id, name, letter, tel, mail, address, remark }
      this.isEditFormVisible = true
    },
    submitEditForm() {
      this.$refs['editForm'].validate((valid) => {
        if (!valid) {
          return
        }
        updateIdc(this.editForm.id, this.editForm).then(res => {
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
    }
  }
}
</script>

<style scoped>
.line{
  text-align: center;
}
</style>

