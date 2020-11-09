<template>
  <div class="dashboard-container">
    <!--<component :is="currentRole"></component>-->
    dashboard
    <pre>  组件化开发（父->子）步骤  (form.vue   table.vue)</pre>
    1： 定义子组件  <br>
       template：写各种HTML <br>
       script: 定义子组件名name,props接受父的值，定义自己的数据逻辑（如data()method）<br>
       style: 编写样式<br><br>
    2：父组件  index.vue<br>
       template：写各种HTML，包括通过名字调用子组件<br>
       script: <br>
          引用API，引用子组件，注册子组件，定义组件名name,<br>
          data() method定义自己的数据逻辑<br>
       style: 编写样式<br><br>
    3.5.2 子组件 -> 父组件通信<br>
    1：table子组件将当前行数据传给父亲<br>
    2: 父亲将数据稍作处理<br>
    3：父亲将处理好的数据给form组件<br>
    4：form组件拿到数据 渲染处理<br>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
// import adminDashboard from './admin'
// import editorDashboard from './editor'

export default {
  name: 'dashboard',
  // components: { adminDashboard },
  data() {
    return {
      currentRole: 'adminDashboard'
    }
  },
  computed: {
    ...mapGetters([
      'roles'
    ])
  }
  // created() {
  //   if (!this.roles.includes('admin')) {
  //     this.currentRole = 'editorDashboard'
  //   }
  // }
}
</script>


