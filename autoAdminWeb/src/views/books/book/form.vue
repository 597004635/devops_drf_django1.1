<template>
  <div class="book-form">
    <el-form :model="form" :rules="rules" ref="form" label-width="100px" class="demo-form">
      <el-form-item label="书名" prop="name">
        <el-input v-model="form.name" placeholder="请输入书名"></el-input>
      </el-form-item>

      <el-form-item label="作者" prop="authors">
        <el-select v-model="form.authors" multiple filterable style="width: 100%" placeholder="请选择作者">
          <el-option v-for="item in author_list" :key="item.index" :label="item.name" :value="item.id"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="出版社" prop="publisher">
        <el-select v-model="form.publisher" filterable placeholder="请选择出版社">
          <el-option v-for="item in publish_list" :key="item.index" :label="item.name" :value="item.id"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="出版时间" prop="publication_date">
        <el-date-picker v-model="form.publication_date" type="date" value-format="yyyy-MM-dd" placeholder="选取日期"></el-date-picker>
      </el-form-item>

      <el-form-item>
        <div class="btn-wrapper">
          <el-button size="small" @click="cancel">取消</el-button>
          <el-button size="small" type="primary" @click="submitForm">保存</el-button>
        </div>
      </el-form-item>
    </el-form>

  </div>
</template>

<script>
  import { getPublishList } from '@/api/books'
  import { getAuthorList } from '@/api/books'

  export default {
    name: 'book-form',
    props: {
      form: {
        type: Object,
        default() {
          return {
            name: '',
            authors: [],
            publisher: [],
            publication_date: ''
          }
        }
      }
    },
    data() {
      return {
        rules: {
          name: [{ required: true, message: '请输入书名', trigger: 'blur' }],
          authors: [{ required: true, message: '请选择作者', trigger: 'blur' }],
          publisher: [{ required: true, message: '请选择出版商', trigger: 'blur' }],
          publication_date: [{ required: true, message: '请输入出版日期', trigger: 'blur' }]
        },
        author_list: [],
        publish_list: [],
        state: 0
      }
    },
    methods: {
      submitForm() {
        this.$refs.form.validate(valid => {
          if (!valid) {
            console.log('添加错误')
            console.log(valid)
            return
          }
          this.$emit('submit', this.form)
        })
      },
      cancel() {
        this.$emit('cancel')
      }
    },
    created() {
      this.state = 1
    },
    watch: {
      state() {
        getPublishList({ page_size: 100 }).then(res => {
          this.publish_list = res.results
          // console.log(this.publish_list)
        })
        getAuthorList({ page_size: 100 }).then(res => {
          this.author_list = res.results
          // console.log(this.author_list)
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  .book-form {
    position: relative;
    display: block;
    .btn-wrapper{
      text-align: right;
    }
  }
</style>
