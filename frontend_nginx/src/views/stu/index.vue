<script setup>
import { queryPageApi, addApi, queryByIdApi, updateApi, violationApi, deleteApi } from '@/api/stu'
import { queryPageApi as queryAllClazzApi } from '@/api/clazz'
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'

// ----------数据区----------

const searchStu = ref({ name: '', degree: '', clazzId: '' }) // 搜索表单对象
const stuList = ref([]) // 学员列表数据
const degrees = ref([ // 学历选项列表
  { name: '初中', value: 1 },
  { name: '高中', value: 2 },
  { name: '大专', value: 3 },
  { name: '本科', value: 4 },
  { name: '硕士', value: 5 },
  { name: '博士', value: 6 }
])
const clazzs = ref([]) // 班级选项列表
const genders = ref([ // 性别选项列表
  { name: '男', value: 1 },
  { name: '女', value: 2 }
])
const maxClazzSize = ref(1000) // 查询班级最大数量

// 分页相关数据
const currentPage = ref(1); // 页码
const pageSize = ref(10); // 每页展示记录数
const background = ref(true) // 背景色
const total = ref(0); // 总记录数

const selectedIds = ref([]); // 选中的记录ID列表

const dialogVisible = ref(false); // 对话框显示状态
const dialogTitle = ref(''); // 对话框标题

const deductionScore = ref(); // 违纪扣分
const violationId = ref(); // 违纪处理的学员ID
const violationFormVisible = ref(false); // 违纪处理对话框显示状态
const violationFormTitle = ref('学员违纪处理'); // 违纪处理对话框标题

// 表单引用
const stuFormRef = ref();

//表单校验规则
const rules = ref({
  name: [
    { required: true, message: '请输入姓名', trigger: 'blur' },
    { min: 2, max: 10, message: '姓名长度应在2到10个字符之间', trigger: 'blur' }
  ],
  no: [
    { required: true, message: '请输入学号', trigger: 'blur' },
    { pattern: /^\d{10}$/, message: '学号应为10位数字', trigger: 'blur' }
  ],
  gender: [
    { required: true, message: '请选择性别', trigger: 'change' }
  ],
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入有效的手机号', trigger: 'blur' }
  ],
  idCard: [
    { required: true, message: '请输入身份证号', trigger: 'blur' },
    { pattern: /^\d{15}$|^\d{18}$|^\d{17}(\d|X|x)$/, message: '请输入有效的身份证号', trigger: 'blur' }
  ],
  isCollege: [
    { required: true, message: '请选择是否院校学院', trigger: 'change' }
  ],
  address: [
    { max: 100, message: '联系地址长度不能超过100个字符', trigger: 'blur' }
  ]
});

//新增/修改表单对象
const stu = ref({
  name: '',
  no: '',
  gender: '',
  phone: '',
  idCard: '',
  isCollege: '',
  address: '',
  degree: '',
  graduationDate: '',
  clazzId: ''
})

// ----------数据区----------


// ----------方法区----------

// 钩子函数
onMounted(() => {
  search();
  getClazzs();
})

const getClazzs = async () => {
  const result = await queryAllClazzApi('', '', '', 1, maxClazzSize.value);
  if (result.code) {
    clazzs.value = result.data.rows.map(c => ({ name: c.name, value: c.id }));
  } else {
    ElMessage.error(result.msg);
  }
}

const search = async () => {
  const result = await queryPageApi(searchStu.value.name, searchStu.value.degree, searchStu.value.clazzId, currentPage.value, pageSize.value);
  if (result.code) {
    stuList.value = result.data.rows;
    total.value = result.data.total;
  } else {
    ElMessage.error(result.msg);
  }
}

const clear = () => {
  searchStu.value = { name: '', degree: '', clazzId: '' };
  search();
}

// 每页展示记录数变化时触发
const handleSizeChange = (val) => {
  search();
}

// 页码变化时触发
const handleCurrentChange = (val) => {
  search();
}

const addStu = () => {
  dialogVisible.value = true;
  dialogTitle.value = '添加学员';
  stu.value = {
    name: '',
    no: '',
    gender: '',
    phone: '',
    idCard: '',
    isCollege: '',
    address: '',
    degree: '',
    graduationDate: '',
    clazzId: ''
  }

  // 重置表单验证状态
  if (stuFormRef.value) {
    stuFormRef.value.resetFields();
  }
}

// 编辑
const edit = async (id) => {
  const result = await queryByIdApi(id);
  if (result.code) {
    stu.value = result.data;
    dialogVisible.value = true;
    dialogTitle.value = '编辑学员';

    // 重置表单验证状态
    if (stuFormRef.value) {
      stuFormRef.value.resetFields();
    }
  } else {
    ElMessage.error(result.msg);
  }
}

// 保存/修改班级
const save = () => {
  if (!stuFormRef.value) return;
  stuFormRef.value.validate(async (valid) => {
    if (valid) {
      let result;
      if (stu.value && stu.value.id) {
        result = await updateApi(stu.value);
      } else {
        result = await addApi(stu.value);
      }
      if (result.code) {
        ElMessage.success('保存成功');
        dialogVisible.value = false;
        search();
      } else {
        ElMessage.error(result.msg);
      }
    } else {
      ElMessage.error('请完善表单信息');
    }
  });
}

// 违纪按钮
const violation = (id) => {
  violationFormVisible.value = true;
  violationId.value = id;
  deductionScore.value = '';
}

// 确定违纪扣分
const confirm = async () => {
  if (!deductionScore.value || deductionScore.value <= 0) {
    ElMessage.warning('请输入有效的扣分值');
    return;
  }
  const result = await violationApi(violationId.value, deductionScore.value);
  if (result.code) {
    ElMessage.success('违纪扣分成功');
    violationFormVisible.value = false;
    search();
  } else {
    ElMessage.error(result.msg);
  }
}

// 删除学员
const deleteById = (id) => {
  ElMessageBox.confirm('确定要删除吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(async () => {
    const result = await deleteApi(id);
    if (result.code) {
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

// 复选框勾选发生变化时触发 selection: 当前选中的记录 (数组)
const handleSelectionChange = (selection) => {
  selectedIds.value = selection.map(item => item.id);
}

// 批量删除学员
const deleteByIds = async () => {
  // 弹出确认框
  ElMessageBox.confirm(
    '您确认删除吗?', '提示',
    {
      confirmButtonText: '确认',
      cancelButtonText: '取消',
      type: 'warning',
    }
  )
    .then(async () => { // 确认
      if (selectedIds.value && selectedIds.value.length > 0) {
        const result = await deleteApi(selectedIds.value);
        if (result.code) {
          ElMessage.success('删除成功');
          search();
        } else {
          ElMessage.error(result.msg);
        }
      } else {
        ElMessage.info('请至少选择一条记录进行删除');
      }
    })
    .catch(() => { // 取消
      ElMessage.info('您已取消删除');
    })
}

// ----------方法区----------
</script>
<template>
  <h1>学员管理</h1>
  <!-- 搜索栏 -->
  <div class="container">
    <el-form :inline="true" :model="searchStu" class="demo-form-inline">
      <el-form-item label="姓名">
        <el-input v-model="searchStu.name" placeholder="请输入学员姓名" />
      </el-form-item>
      <el-form-item label="最高学历">
        <el-select v-model="searchStu.degree" placeholder="请选择">
          <el-option v-for="d in degrees" :key="d.value" :label="d.name" :value="d.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="所属班级">
        <el-select v-model="searchStu.clazzId" placeholder="请选择">
          <el-option v-for="c in clazzs" :key="c.value" :label="c.name" :value="c.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="search">查询</el-button>
        <el-button type="info" @click="clear">清空</el-button>
      </el-form-item>
    </el-form>
  </div>

  <!-- 功能按钮 -->
  <div class="container">
    <el-button type="primary" @click="addStu"> + 新增学员</el-button>
    <el-button type="primary" @click="deleteByIds"> - 批量删除</el-button>
  </div>

  <!-- 数据展示表格 -->
  <div class="container">
    <el-table :data="stuList" border style="width: 100%" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column prop="name" label="姓名" width="80" align="center" />
      <el-table-column prop="no" label="学号" width="110" align="center" />
      <el-table-column prop="clazzName" label="班级" width="140" align="center" />
      <el-table-column label="性别" width="60" align="center">
        <template #default="scope">
          {{ scope.row.gender == 1 ? '男' : '女' }}
        </template>
      </el-table-column>
      <el-table-column prop="phone" label="手机号" width="120" align="center" />
      <el-table-column prop="degree" label="最高学历" width="90" align="center">
        <template #default="scope">
          <span v-if="scope.row.degree == 1">初中</span>
          <span v-else-if="scope.row.degree == 2">高中</span>
          <span v-else-if="scope.row.degree == 3">大专</span>
          <span v-else-if="scope.row.degree == 4">本科</span>
          <span v-else-if="scope.row.degree == 5">硕士</span>
          <span v-else-if="scope.row.degree == 6">博士</span>
          <span v-else>其他</span>
        </template>
      </el-table-column>
      <el-table-column prop="violationCount" label="违纪次数" width="90" align="center" />
      <el-table-column prop="violationScore" label="违纪扣分" width="90" align="center" />
      <el-table-column prop="updateTime" label="最后操作时间" width="170" align="center" />
      <el-table-column label="操作" align="center">
        <template #default="scope">
          <el-button type="primary" size="small" @click="edit(scope.row.id)"> <el-icon>
              <Edit />
            </el-icon>编辑</el-button>
          <el-button type="warning" size="small" @click="violation(scope.row.id)"> <el-icon>
              <Warning />
            </el-icon>违纪</el-button>
          <el-button type="danger" size="small" @click="deleteById(scope.row.id)"> <el-icon>
              <Delete />
            </el-icon>删除</el-button>
        </template>
      </el-table-column>
    </el-table>

  </div>

  <!-- 分页条 -->
  <div class="container">
    <el-pagination v-model:current-page="currentPage" v-model:page-size="pageSize"
      :page-sizes="[5, 10, 20, 30, 50, 75, 100]" :background="background"
      layout="total, sizes, prev, pager, next, jumper" :total="total" @size-change="handleSizeChange"
      @current-change="handleCurrentChange" />
  </div>

  <!-- 新增/修改员工的对话框 -->
  <el-dialog v-model="dialogVisible" :title="dialogTitle">
    <el-form ref="stuFormRef" :rules="rules" :model="stu" label-width="80px">
      <!-- 第一行 -->
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="姓名" prop="name">
            <el-input v-model="stu.name" placeholder="请输入学员姓名"></el-input>
          </el-form-item>
        </el-col>

        <el-col :span="12">
          <el-form-item label="学号" prop="no">
            <el-input v-model="stu.no" placeholder="请输入学员学号"></el-input>
          </el-form-item>
        </el-col>
      </el-row>

      <!-- 第二行 -->
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="性别" prop="gender">
            <el-select v-model="stu.gender" placeholder="请选择性别" style="width: 100%;">
              <el-option v-for="g in genders" :key="g.value" :label="g.name" :value="g.value"></el-option>
            </el-select>
          </el-form-item>
        </el-col>

        <el-col :span="12">
          <el-form-item label="手机号" prop="phone">
            <el-input v-model="stu.phone" placeholder="请输入学员手机号"></el-input>
          </el-form-item>
        </el-col>
      </el-row>

      <!-- 第三行 -->
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="身份证号" prop="idCard">
            <el-input v-model="stu.idCard" placeholder="请输入身份证号"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="院校学员" prop="isCollege">
            <el-select v-model="stu.isCollege" placeholder="请选择" style="width: 100%;">
              <el-option label="是" :value="1" />
              <el-option label="否" :value="0" />
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>

      <!-- 第四行 -->
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="联系地址" prop="address">
            <el-input v-model="stu.address" placeholder="请输入联系地址"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="最高学历">
            <el-select v-model="stu.degree" placeholder="请选择" style="width: 100%;">
              <el-option v-for="d in degrees" :key="d.value" :label="d.name" :value="d.value"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>

      <!-- 第五行 -->
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="毕业时间">
            <el-date-picker v-model="stu.graduationDate" type="date" style="width: 100%;" placeholder="请选择毕业时间"
              format="YYYY-MM-DD" value-format="YYYY-MM-DD"></el-date-picker>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="所属班级">
            <el-select v-model="stu.clazzId" placeholder="请选择" style="width: 100%;">
              <el-option v-for="c in clazzs" :key="c.value" :label="c.name" :value="c.value"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>

    <!-- 底部按钮 -->
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="save">保存</el-button>
      </span>
    </template>

  </el-dialog>

<!-- 违纪处理的对话框 -->
  <el-dialog v-model="violationFormVisible" :title="violationFormTitle" width="500">
    <el-form>
      <el-form-item label="违纪扣分" label-width="80px" >
        <el-input v-model="deductionScore" style="width: 90%;"/>
      </el-form-item>
    </el-form>
    <template #footer>
      <div class="dialog-footer">
        <el-button @click="violationFormVisible = false">取消</el-button>
        <el-button type="primary" @click="confirm">确定</el-button>
      </div>
    </template>
  </el-dialog>

</template>

<style scoped>
.container {
  margin: 10px 0px;
}

.avatar {
  height: 40px;
}
</style>