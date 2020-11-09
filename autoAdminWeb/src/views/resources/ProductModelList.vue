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
    <!--添加机器型号开始-->
    <el-dialog :visible.sync="isFormVisible" title="添加机器型号">
      <el-form ref="addForm" :model="addForm" :rules="addRule" label-width="70px">
        <el-form-item label="型号名称" prop="model_name">
          <el-input v-model="addForm.model_name" placeholder="请输入型号名称" />
        </el-form-item>
        <el-form-item label="所属于厂商" prop="vendor">
          <el-select class="select" v-model="addForm.vendor" filterable placeholder="选择厂商">
            <el-option v-for="(item, index) in ManuList" :key="index" :label="item.vendor_name" :value="item.id" />
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="isFormVisible = false"> 取 消</el-button>
        <el-button type="primary" @click="submitForm">确 定</el-button>
      </div>
    </el-dialog>
    <!--结束-->
    <!--修改机器型号开始-->
    <el-dialog :visible.sync="isEditFormVisible" title="修改机器型号">
      <el-form ref="editForm" :model="editForm" :rules="addRule" label-width="70px">
        <el-form-item label="型号名称" prop="model_name">
          <el-input v-model="editForm.model_name" placeholder="请输入型号名称" />
        </el-form-item>
        <el-form-item label="所属于厂商" prop="vendor">
          <el-select class="select" v-model="editForm.vendor" filterable placeholder="选择厂商">
            <el-option v-for="(item, index) in ManuList" :key="index" :label="item.vendor_name" :value="item.id" />
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="isEditFormVisible = false"> 取 消</el-button>
        <el-button type="primary" @click="submitEditForm">确 定</el-button>
      </div>
    </el-dialog>
    <!--结束-->
    <el-table v-loading="loading" :data="manufacturerList" class="table" element-loading-text="拼命加载中" border>
      <el-table-column prop="model_name" label="型号名称" align="center" />
      <el-table-column prop="vendor.name" label="所属于厂商" align="center" />
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
  </div>
</template>

<script>
import { getProductModelList, addProductModel, updateProductModel, deleteProductModel, getManufacturerList } from '@/api/resources'

export default {
  data() {
    return {
      loading: false,
      manufacturerList: [],
      total_num: 0,
      page: 1,
      state: 0,
      search_key: '',
      isFormVisible: false,
      isEditFormVisible: false,
      editForm: {},
      addForm: {
        model_name: '',
        vendor: ''
      },
      addRule: {
        model_name: [
          { required: true, message: '请输入型号名称', trigger: 'blur' }
        ],
        vendor: [
          { required: true, message: '请选择所属厂商', trigger: 'blur' }
        ]
      },
      ManuList: []
    }
  },
  methods: {
    fetchData() {
      this.loading = true
      console.log(this.search_key)
      getProductModelList({ page: this.page, model_name: this.search_key }).then(res => {
        this.manufacturerList = res.results
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
        addProductModel(params).then(res => {
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
      this.$confirm('此操作将删除型号 【' + row.model_name + '】 , 是否继续? ', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteProductModel(row.id).then(response => {
          this.$message({
            message: '删除 "' + row.model_name + '" 成功',
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
      const { id, model_name } = row
      const { vendor } = { vendor: row.vendor.id }
      this.editForm = { id, model_name, vendor }
      this.isEditFormVisible = true
    },
    submitEditForm() {
      this.$refs['editForm'].validate((valid) => {
        if (!valid) {
          return
        }
        const id = this.editForm.id
        const params = this.editForm
        delete params.id
        updateProductModel(id, params).then(res => {
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
      getManufacturerList({ page_size: 0 }).then(res => {
        this.ManuList = res
      })
    }
  }
}
</script>

