<script setup>
import { ref, shallowRef, onMounted } from 'vue';
import * as echarts from 'echarts/core';
import { TooltipComponent, LegendComponent } from 'echarts/components';
import { PieChart } from 'echarts/charts';
import { LabelLayout } from 'echarts/features';
import { GridComponent } from 'echarts/components';
import { BarChart } from 'echarts/charts';
import { CanvasRenderer } from 'echarts/renderers';
import { getEmpJobDataApi, getEmpGenderDataApi } from '@/api/report';
import { ElMessage } from 'element-plus';

echarts.use([GridComponent, BarChart, CanvasRenderer, TooltipComponent,
  LegendComponent,
  PieChart,
  CanvasRenderer,
  LabelLayout]);

// 职位统计图表相关
const posChartRef = ref(null);
const posChart = shallowRef(null);
const posOption = ref({
  xAxis: {
    type: 'category',
    data: ["教研主管", "学工主管", "其他", "班主任", "咨询师", "讲师"]
  },
  yAxis: {
    type: 'value'
  },
  series: [
    {
      data: [0, 0, 0, 0, 0, 0],
      type: 'bar'
    }
  ]
});

// 性别统计图表相关
const genChartRef = ref(null);
const genChart = shallowRef(null);
const genOption = ref({
  tooltip: {
    trigger: 'item'
  },
  legend: {
    top: '5%',
    left: 'center'
  },
  series: [
    {
      name: '员工性别比例',
      type: 'pie',
      radius: ['40%', '70%'],
      avoidLabelOverlap: false,
      padAngle: 5,
      itemStyle: {
        borderRadius: 10
      },
      label: {
        show: false,
        position: 'center'
      },
      emphasis: {
        label: {
          show: true,
          fontSize: 30,
          fontWeight: 'bold'
        }
      },
      labelLine: {
        show: false
      },
      data: [
        { value: 0, name: '男性员工' },
        { value: 0, name: '女性员工' }
      ]
    }
  ]
});

// 获取员工职位数据
const getEmpJobData = async () => {
  const result = await getEmpJobDataApi();
  if (result.code) {
    posOption.value.xAxis.data = result.data.jobList;
    posOption.value.series[0].data = result.data.dataList;
  } else {
    ElMessage.error("获取员工职位数据失败");
  }
}

// 获取员工性别数据
const getEmpGenderData = async () => {
  const result = await getEmpGenderDataApi();
  if (result.code) {
    genOption.value.series[0].data = result.data;
  } else {
    ElMessage.error("获取员工性别数据失败");
  }
}

// 将初始化逻辑放入 onMounted 钩子中
onMounted(async () => {
  // 确保 DOM 已经挂载
  if (posChartRef.value) {
    posChart.value = echarts.init(posChartRef.value);
    posChart.value.setOption(posOption.value);
  }
  if (genChartRef.value) {
    genChart.value = echarts.init(genChartRef.value);
    genChart.value.setOption(genOption.value);
  }
  await getEmpJobData();
  await getEmpGenderData();
  if(posChart.value) posChart.value.setOption(posOption.value);
  if(genChart.value) genChart.value.setOption(genOption.value);
});
</script>

<template>

  <div class="container">
    <div class="innerForm">
    <h1>员工职位统计</h1>
    <div ref="posChartRef" style="width: 600px; height: 500px;"></div>
  </div>

  <div class="innerForm">
    <h1>员工性别统计</h1>
    <div ref="genChartRef" style="width: 600px; height: 500px;"></div>
  </div>
  </div>

</template>

<style scoped>

.container {
  margin: 10px 0px;
  display: flex;
  justify-content: space-around;
}

.innerForm {
  display: flex;
  flex-direction: column;
  align-items: center;
} 

</style>