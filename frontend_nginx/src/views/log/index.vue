<script setup>
import { ref, onMounted } from 'vue';
import { queryPageApi } from "@/api/log";
import { ElMessage } from 'element-plus';

// ----------------- 数据区 -----------------

// 班级列表数据
const logList = ref([
  {
    "operateEmpId": '',
    "operateTime": '',
    "className": '',
    "methodName": '',
    "methodParams": '',
    "returnValue": '',
    "costTime": '',
    "operateEmpName": ''
  }
])

// 分页相关数据
const currentPage = ref(1); // 页码
const pageSize = ref(10); // 每页展示记录数
const background = ref(true) // 背景色
const total = ref(0); // 总记录数

// ----------------- 数据区 -----------------

// ----------------- 方法区 -----------------

const handleSizeChange = (val) => {// 每页展示记录数变化
  search();
}
const handleCurrentChange = (val) => {// 页码变化时触发
  search();
}

// 钩子函数
onMounted(() => {
  search();
})

const search = async () => {
  const result = await queryPageApi(currentPage.value, pageSize.value);
  if (result.code) {
    logList.value = result.data.rows;
    total.value = result.data.total;
  } else {
    ElMessage.error(result.msg);
  }
}

// ----------------- 方法区 -----------------
</script>

<template>
  <h1>日志管理</h1>

  <!-- 数据展示表格 -->
  <div class="container">
    <el-table :data="logList" border style="width: 100%">
      <el-table-column type="index" label="序号" width="60" align="center" />
      <el-table-column prop="operateEmpId" label="操作员工ID" width="100" align="center" />
      <el-table-column prop="operateTime" label="操作时间" width="190" align="center" show-overflow-tooltip/>
      <el-table-column prop="className" label="类名" width="240" align="center" show-overflow-tooltip/>
      <el-table-column prop="methodName" label="方法名" width="120"  align="center" show-overflow-tooltip/>
      <el-table-column prop="methodParams" label="方法参数" width="220" align="center" show-overflow-tooltip/>
      <el-table-column prop="returnValue" label="返回值" width="120" align="center" show-overflow-tooltip/>
      <el-table-column prop="costTime" label="耗时(ms)" width="120" align="center" />
      <el-table-column prop="operateEmpName" label="操作员工" align="center" />
    </el-table>
  </div>

  <!-- 分页条 -->
  <div class="container">
    <el-pagination v-model:current-page="currentPage" v-model:page-size="pageSize"
      :page-sizes="[5, 10, 20, 30, 50, 75, 100]" :background="background"
      layout="total, sizes, prev, pager, next, jumper" :total="total" @size-change="handleSizeChange"
      @current-change="handleCurrentChange" />
  </div>

</template>

<style scoped>
.container {
  margin: 10px 0px;
}
</style>