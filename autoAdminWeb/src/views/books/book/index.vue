<template>
    <div class="book">
      <div>
        <!--搜索-->
        <el-col :span="8">
          <el-input placeholder="搜索" v-model="params.search" @keyup.enter.native="searchClick">
            <el-button slot="append" icon="el-icon-search" @click="searchClick"></el-button>
          </el-input>
        </el-col>

        <!--添加按钮-->
        <el-col :span="6" :offset="8" style="text-align: right">
          <el-button type="primary" @click="handleAddBtn">添加图书</el-button>
        </el-col>
      </div>

      <!--表格-->
      <book-list :value="book" @edit="handleEdit" @delete="handleDelete"></book-list>

    <!--模块窗添加表单-->
      <!-- 添加时不需要传值给子组件-->
      <el-dialog title="添加" :visible.sync="dialogVisibleForAdd" width="50%">
        <book-form ref="bookForm" @submit="handleSubmitAdd" @cancel="handleCancelAdd"></book-form>
      </el-dialog>

      <!--模块窗更新表单-->
      <!-- 更新时子父组件有通信-->
      <el-dialog title="更新" :visible.sync="dialogVisibleForEdit" width="50%">
        <book-form ref="BookForm" :form="currentValue" @submit="handleSubmitEdit" @cancel="handleCancelEdit"></book-form>
      </el-dialog>

      <!--分页-->
      <center>
        <el-pagination background
                       layout="total, prev, pager, next, jumper"
                       :page-size="pagesize"
                       :total="totalNum"
                       @current-change="handleCurrentChange">
        </el-pagination>
      </center>

    </div>

</template>

<script>
  import { getBookList, createBook, updateBook, deleteBook } from '@/api/books'
  // 导入组件，命名支持驼峰法
  import BookList from './table'
  import BookForm from './form'

  export default {
    name: 'book',
    components: {
      BookList,
      BookForm
    },
    data() {
      return {
        dialogVisibleForAdd: false,
        dialogVisibleForEdit: false,
        currentValue: {},
        book: [],
        totalNum: 0,
        pagesize: 10,
        params: {
          page: 1,
          search: ''
        }
      }
    },
    created() {
      this.fetchData()
    },
    methods: {
      fetchData() {
        getBookList(this.params).then(res => {
          this.book = res.results
          this.totalNum = res.count
        })
      },
      handleCurrentChange(val) {
        this.params.page = val
        this.fetchData()
        // console.log(this.params.page)
      },
      searchClick() { this.fetchData() },
      // 添加出版商，弹出模态框，提交数据，取消
      handleAddBtn() { this.dialogVisibleForAdd = true },
      handleSubmitAdd(value) {
        createBook(value).then(res => {
          this.$message({
            message: '创建图书成功',
            type: 'success'
          })
          this.handleCancelAdd()
          this.fetchData()
        })
      },
      handleCancelAdd() {
        this.dialogVisibleForAdd = false
        // 清除子组件表单的数据
        this.$refs.bookForm.$refs.form.resetFields()
      },

      // 更新出版商，弹出模态框，提交数据，取消
      handleEdit(value) {
        // 将子组件传来的值给父组件的变量，然后渲染表单
        this.dialogVisibleForEdit = true
        this.currentValue = { ...value }
        this.currentValue['authors'] = this.currentValue['authors'].map(it => it.id)
        // this.currentValue['publisher'] = this.currentValue['publisher'][0].id
        this.currentValue['publisher'] = this.currentValue['publisher'].id
      },
      handleSubmitEdit(value) {
        // 把表单的值拆解成自己想要的样子
        const { id, ...params } = value
        updateBook(id, params).then(res => {
          this.$message({
            message: '更新图书成功',
            type: 'success'
          })
          this.handleCancelEdit()
          this.fetchData()
        })
      },
      handleCancelEdit() {
        this.dialogVisibleForEdit = false
        this.$refs.bookForm.$refs.form.resetFields()
        // this.$refs.bookForm.resetFields()
      },

      // 删除
      handleDelete(id) {
        deleteBook(id).then(res => {
          this.$message({
            message: '删除图书成功',
            type: 'success'
          })
          this.params.page = 1
          this.fetchData()
        },
        err => { console.log(err.message) }
        )
      }
    }
  }
</script>

<style lang="scss" scoped>
  .book {
    padding: 10px;
  }
</style>
