<template>
  <div class="book-list">
    <el-table :data="value" border stripe style="width: 100%">
      <el-table-column label="ID" prop="id" type="expand"></el-table-column>
      <el-table-column label="书名" prop="name"></el-table-column>

      <el-table-column label="作者" prop="author" type="scope">
        <template slot-scope="scope">
          <div v-for="(item, index) in scope.row.authors" :key="index" :label="item.name" :value="item.id">
            <span style="float: left">{{ item.name }}, </span>
          </div>
        </template>
      </el-table-column>

      <el-table-column label="出版商" prop="publisher" type="scope">
        <template slot-scope="scope">
          <!--{{ scope.row.publisher[0].name }}-->
          {{ scope.row.publisher.name }}
        </template>
      </el-table-column>

      <el-table-column label="出版时间" prop="publication_date"></el-table-column>

      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button type="primary" size="mini" icon="el-icon-edit" @click="handleEdit(scope.row)">编辑</el-button>
          <el-button type="danger" size="mini" icon="el-icon-delete" @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
  export default {
    name: 'book-list',
    props: ['value'],
    methods: {
      // 点击编辑按钮，将子组件的事件传递给父组件
      handleEdit(value) {
        this.$emit('edit', value)
      },

      // 删除
      handleDelete(book) {
        const id = book.id
        const name = book.name
        this.$confirm(`确定删除图书: ${name} ?`, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$emit('delete', id)
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '删除已取消'
          })
        })
      }
    }

  }
</script>

<style lang="scss" scoped>
  .book-list {}
</style>
