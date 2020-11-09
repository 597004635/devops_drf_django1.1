<template>
  <div class="author-list">
    <el-table :data="value" border stripe style="width: 100%">
      <el-table-column label="ID" prop="id" type="expand"></el-table-column>
      <el-table-column label="姓名" prop="name"></el-table-column>
      <el-table-column label="邮箱" prop="email"></el-table-column>
      <el-table-column label="电话" prop="phone"></el-table-column>
      <el-table-column label="地址" prop="address"></el-table-column>
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
    name: 'author-list',
    props: ['value'],
    methods: {
      // 点击编辑按钮，将子组件的事件传递给父组件
      handleEdit(value) {
        this.$emit('edit', value)
      },

      // 删除
      handleDelete(author) {
        const id = author.id
        const name = author.name
        this.$confirm(`确定删除作者: ${name} ?`, '提示', {
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
  .author-list {}
</style>
