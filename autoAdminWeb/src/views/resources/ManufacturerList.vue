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
      <el-table-column prop="vendor_name" label="名称" align="center" />
      <el-table-column prop="tel" label="电话" align="center" />
      <el-table-column prop="mail" label="邮箱" align="center" />
      <el-table-column prop="remark" label="备注" align="center" />
      <el-table-column prop="" label="操作" width="215" align="center">
        <template slot-scope="scope">
          <el-button type="info" size="small" icon="el-icon-edit" @click="editClick(scope.row)" />
          <el-button type="danger" size="small" icon="el-icon-delete" @click="deleteClick(scope.row)" />
          <!--<el-button type="text" size="small" @click="deleteClick(scope.row)">删除</el-button>-->
        </template>
      </el-table-column>
    </el-table>

    <div v-show="total_num>=10" class="text-center">
      <el-pagination :current-page.sync="page" :total="total_num" layout="total, prev, pager, next, jumper" background @current-change="paginationChange" />
    </div>
    <!-- 添加制造商开始 -->
    <el-dialog :visible.sync="isFormVisible" title="添加制造商">
      <el-form ref="addForm" :model="addForm" :rules="addRule" label-width="70px">
        <el-form-item label="厂商名称" prop="vendor_name">
          <el-input v-model="addForm.vendor_name" placeholder="请输入厂商名称" />
        </el-form-item>
        <el-form-item label="联系电话" prop="tel">
          <el-input v-model="addForm.tel" maxleng="15" placeholder="请输入联系电话" />
        </el-form-item>
        <el-form-item label="邮箱" prop="mail">
          <el-input v-model="addForm.mail" maxleng="20" placeholder="请输入邮箱" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="addForm.remark" placeholder="请输入备注信息" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="isFormVisible = false"> 取 消</el-button>
        <el-button type="primary" @click="submitForm">确 定</el-button>
      </div>
    </el-dialog>
    <!-- /结束 -->
    <!-- 修改制造商信息开始 -->
    <el-dialog :visible.sync="isEditFormVisible" title="修改制造商">
      <el-form ref="editForm" :model="editForm" :rules="addRule" label-width="70px">
        <el-form-item label="厂商名称" prop="vendor_name">
          <el-input v-model="editForm.vendor_name" placeholder="请输入厂商名称" />
        </el-form-item>
        <el-form-item label="联系电话" prop="tel">
          <el-input v-model="editForm.tel" placeholder="请输入联系电话" />
        </el-form-item>
        <el-form-item label="邮箱" prop="mail">
          <el-input v-model="editForm.mail" maxleng="20" placeholder="请输入邮箱" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="editForm.remark" placeholder="请输入备注信息" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="isEditFormVisible = false"> 取 消</el-button>
        <el-button type="primary" @click="submitEditForm">确 定</el-button>
      </div>
    </el-dialog>
    <!-- /结束 -->
  </div>
</template>

<script>
import { getManufacturerList, addManufacturer, updateManufacturer, deleteManufacturer } from '@/api/resources'

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
        vendor_name: '',
        tel: '',
        mail: '',
        remark: ''
      },
      addRule: {
        vendor_name: [
          { required: true, message: '请输入名称', trigger: 'blur' }
        ],
        tel: [
          { required: true, message: '请输入联系电话', trigger: 'blur' }
        ]
      }
    }
  },
  methods: {
    fetchData() {
      this.loading = true
      getManufacturerList({ page: this.page, vendor_name: this.search_key }).then(res => {
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
        addManufacturer(params).then(res => {
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
      this.$confirm('此操作将删除制造商 【' + row.vendor_name + '】 , 是否继续? ', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteManufacturer(row.id).then(response => {
          this.$message({
            message: '删除 "' + row.vendor_name + '" 成功',
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
      this.isEditFormVisible = true
      this.editForm = row
    },
    submitEditForm() {
      this.$refs['editForm'].validate((valid) => {
        if (!valid) {
          return
        }
        const id = this.editForm.id
        const params = this.editForm
        // delete params.id
        updateManufacturer(id, params).then(res => {
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

