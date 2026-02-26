<script setup>
import { ref, onMounted, watch } from 'vue';
import { queryPageApi, addClazzApi, queryByIdApi, updateClazzApi,deleteClazzApi } from '@/api/clazz';
import { queryPageApi as queryAllEmpApi } from '@/api/emp';
import { ElMessage, ElMessageBox } from 'element-plus'

// ----------------- 数据区 -----------------

// 搜索表单对象
const searchClazz = ref({name: '', date: [], begin: '', end: ''}) 
watch(() => searchClazz.value.date, (newVal) => {// 监听日期范围变化，更新begin和end字段
  if(newVal && newVal.length > 0){
    searchClazz.value.begin = newVal[0];
    searchClazz.value.end = newVal[1];
  }
})

// 班级列表数据
const clazzList = ref([])

// 分页相关数据
const currentPage = ref(1); // 页码
const pageSize = ref(10); // 每页展示记录数
const empsMaxSize = ref(1000); // 班主任选项最大记录数
const background = ref(true) // 背景色
const total = ref(0); // 总记录数

const handleSizeChange = (val) => {// 每页展示记录数变化
  search(); 
}
const handleCurrentChange = (val) => {// 页码变化时触发
  search();
}

// 对话框相关数据
const dialogFormVisible = ref(false); // 对话框显示状态
const formtitle = ref(''); // 对话框标题
const clazzFormRef = ref(null); // 表单引用
const clazz = ref({name: '', room: '', beginDate: '', endDate: '',masterId: '', subject: ''}); // 班级对象
const emps = ref([]) // 班主任选项数据
const subjects = ref([ // 学科选项数据
  {name: 'Java', value: 1},
  {name: '前端', value: 2},
  {name: '大数据', value: 3},
  {name: '嵌入式', value: 4},
  {name: 'Python', value: 5},
  {name: 'Go', value: 6}
])


//表单校验规则
const rules = ref({
  name: [
    { required: true, message: '请输入班级名称', trigger: 'blur' },
    { min: 4, max: 30, message: '班级名称长度应在4到30个字符之间', trigger: 'blur' }
  ],
  room: [
    { message: '请输入班级教室', trigger: 'blur' },
    { min: 1, max: 20, message: '班级教室长度应在1到20个字符之间', trigger: 'blur' }
  ],
  beginDate: [
    { required: true, message: '请选择开课时间', trigger: 'change' }
  ],
  endDate: [
    { required: true, message: '请选择结课时间', trigger: 'change' }
  ],
  masterId: [],
  subject: [
    { required: true, message: '请选择学科', trigger: 'change' }
  ]
});

// ----------------- 数据区 -----------------

// ----------------- 方法区 -----------------

// 钩子函数
onMounted(() => {
  search();
  queryAllEmps();
})

const search = async () => {
  const result = await queryPageApi(searchClazz.value.name, searchClazz.value.begin, searchClazz.value.end, currentPage.value, pageSize.value);
  clazzList.value = result.data.rows;
  total.value = result.data.total;
}

const clear = async () => {
  searchClazz.value = {name: '', date: [], begin: '', end: ''};
  search();
}

const addClazz = () => {
  dialogFormVisible.value = true;
  formtitle.value = '新增班级';
  clazz.value = {name: '', room: '', beginDate: '', endDate: '',masterId: '', subject: ''};
  // 重置表单的校验规则-提示信息
  if(clazzFormRef.value){
    clazzFormRef.value.resetFields();
  }
}

//查询所有部门数据
const queryAllEmps = async () => {
  const result = await queryAllEmpApi('','','','',1,empsMaxSize.value);
  if(result.code){
    emps.value = result.data.rows;
  }
}

// 保存/修改班级
const save = () => {
  if(!clazzFormRef.value)return;
  clazzFormRef.value.validate(async (valid) => {
    if(valid){
      let result;
      if(clazz.value && clazz.value.id){
        // 修改班级的接口调用
        result = await updateClazzApi(clazz.value);
      } else {
        // 新增班级的接口调用
        result = await addClazzApi(clazz.value);
      }
      if(result.code){
        ElMessage.success('保存成功');
        dialogFormVisible.value = false;
        search();
      } else {
        ElMessage.error(result.msg);
      }
    } else {
      ElMessage.error('请检查输入项是否正确');
    }
  })
}

// 编辑按钮
const edit = async (id) => {
  const result = await queryByIdApi(id);
  if(result.code){
    clazz.value = result.data;
    dialogFormVisible.value = true;
    formtitle.value = '修改班级';
    // 重置表单的校验规则-提示信息
    if(clazzFormRef.value){
      clazzFormRef.value.resetFields();
    }
  }
}

// 删除按钮
const delById = async (id) => {
  ElMessageBox.confirm('确定要删除吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(async () => {
    const result = await deleteClazzApi(id);
    if(result.code){
      ElMessage.success('删除成功');
      search();
    } else {
      ElMessage.error(result.msg);
    }
  }).catch(() => {
    // 取消删除
    ElMessage.info('已取消删除');
  });
}

// ----------------- 方法区 -----------------
</script>

<template>
  <h1>班级管理</h1>

  <!-- 搜索栏 -->
 <div class="container">
    <el-form :inline="true" :model="searchClazz" class="demo-form-inline">
      <el-form-item label="班级名称">
        <el-input v-model="searchClazz.name" placeholder="请输入班级名称" />
      </el-form-item>
      <el-form-item label="结课时间">
        <el-date-picker v-model="searchClazz.date" type="daterange" range-separator="至" start-placeholder="开始时间"
          end-placeholder="结束时间" value-format="YYYY-MM-DD" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="search">查询</el-button>
        <el-button type="info" @click="clear">清空</el-button>
      </el-form-item>
    </el-form>
  </div>

  <!-- 功能按钮 -->
  <div class="container">
    <el-button type="primary" @click="addClazz"> + 新增班级</el-button>
  </div>

  <!-- 数据展示表格 -->
  <div class="container">
    <el-table :data="clazzList" border style="width: 100%">
      <el-table-column type="index" label="序号" width="80" align="center" />
      <el-table-column prop="name" label="班级名称" width="160" align="center" />
      <el-table-column prop="room" label="班级教室" width="120" align="center" />
      <el-table-column prop="masterName" label="班主任" width="120" align="center" />
      <el-table-column prop="beginDate" label="开课时间" width="120" align="center" />
      <el-table-column prop="endDate" label="结课时间" width="120" align="center" />
      <el-table-column prop="status" label="状态" width="120" align="center" />
      <el-table-column prop="updateTime" label="最后操作时间" width="200" align="center" />
      <el-table-column label="操作" align="center">
        <template #default="scope">
            <el-button type="primary" size="small" @click="edit(scope.row.id)"> <el-icon><Edit /></el-icon>编辑</el-button>
            <el-button type="danger" size="small" @click="delById(scope.row.id)"> <el-icon><Delete /></el-icon>删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>

    <!-- 分页条 -->
  <div class="container">
    <el-pagination
      v-model:current-page="currentPage"
      v-model:page-size="pageSize"
      :page-sizes="[5, 10, 20, 30, 50, 75, 100]"
      :background="background"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total"
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
    />
  </div>

<!-- Dialog对话框 -->
  <el-dialog v-model="dialogFormVisible" :title="formtitle" width="500">
    <el-form :model="clazz" :rules="rules" ref="clazzFormRef">
      <el-form-item label="班级名称" label-width="80px" prop="name">
        <el-input v-model="clazz.name" style="width: 90%;"/>
      </el-form-item>
      <el-form-item label="班级教室" label-width="80px" prop="room">
        <el-input v-model="clazz.room" style="width: 90%;"/>
      </el-form-item>
      <el-form-item label="开课时间" label-width="80px" prop="beginDate">
        <el-date-picker v-model="clazz.beginDate" type="date" value-format="YYYY-MM-DD" style="width: 90%;"/>
      </el-form-item>
      <el-form-item label="结课时间" label-width="80px" prop="endDate" >
        <el-date-picker v-model="clazz.endDate" type="date" value-format="YYYY-MM-DD" style="width: 90%;"/>
      </el-form-item>
      <el-form-item label="班主任" label-width="80px" prop="masterId">
        <el-select v-model="clazz.masterId" placeholder="请选择班主任" style="width: 90%;">
          <el-option v-for="e in emps" :key="e.id" :label="e.name" :value="e.id"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="学科" label-width="80px" prop="subject">
        <el-select v-model="clazz.subject" placeholder="请选择学科" style="width: 90%;">
          <el-option v-for="s in subjects" :key="s.value" :label="s.name" :value="s.value"></el-option>
        </el-select>
      </el-form-item>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取消</el-button>
        <el-button type="primary" @click="save">
          确定
        </el-button>
      </div>
    </template>
  </el-dialog>
  
</template>

<style scoped>
.container {
  margin: 10px 0px;
}
</style>