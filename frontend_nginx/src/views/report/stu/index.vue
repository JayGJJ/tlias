<script setup>
import { ref, shallowRef, onMounted } from 'vue';
import * as echarts from 'echarts/core';
import { TooltipComponent, LegendComponent } from 'echarts/components';
import { PieChart } from 'echarts/charts';
import { LabelLayout } from 'echarts/features';
import { GridComponent } from 'echarts/components';
import { BarChart } from 'echarts/charts';
import { CanvasRenderer } from 'echarts/renderers';
import { getStudentCountDataApi, getStudentDegreeDataApi } from '@/api/report';
import { ElMessage } from 'element-plus';

echarts.use([GridComponent, BarChart, CanvasRenderer, TooltipComponent,
  LegendComponent,
  PieChart,
  CanvasRenderer,
  LabelLayout]);

// 班级统计图表相关
const clazzChartRef = ref(null);
const clazzChart = shallowRef(null);
const clazzOption = ref({
  xAxis: {
    type: 'category',
    data: ["Java就业100期","Java就业101期","Java就业102期","Java就业103期","Java就业104期"]
  },
  yAxis: {
    type: 'value'
  },
  series: [
    {
      data: [0, 0, 0, 0, 0],
      type: 'bar'
    }
  ]
});

// 学历统计图表相关
const degreeChartRef = ref(null);
const degreeChart = shallowRef(null);
const dgreeOption = ref({
  tooltip: {
    trigger: 'item'
  },
  legend: {
    top: '5%',
    left: 'center'
  },
  series: [
    {
      name: '学员学历比例',
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
        {
      "name": "初中",
      "value": 0
    },
    {
      "name": "高中",
      "value": 0
    },
    {
      "name": "大专",
      "value": 0
    },
    {
      "name": "本科",
      "value": 0
    },
    {
      "name": "硕士",
      "value": 0
    }
      ]
    }
  ]
});

// 获取班级人数数据
const getStudentCountData = async () => {
  const result = await getStudentCountDataApi();
  if (result.code) {
    clazzOption.value.xAxis.data = result.data.clazzList;
    clazzOption.value.series[0].data = result.data.dataList;
  } else {
    ElMessage.error("获取班级人数数据失败");
  }
}

// 获取学员学历数据
const getStudentDegreeData = async () => {
  const result = await getStudentDegreeDataApi();
  if (result.code) {
    dgreeOption.value.series[0].data = result.data;
  } else {
    ElMessage.error("获取学员学历数据失败");
  }
}

// 将初始化逻辑放入 onMounted 钩子中
onMounted(async () => {
  // 确保 DOM 已经挂载
  if (clazzChartRef.value) {
    clazzChart.value = echarts.init(clazzChartRef.value);
    clazzChart.value.setOption(clazzOption.value);
  }
  if (degreeChartRef.value) {
    degreeChart.value = echarts.init(degreeChartRef.value);
    degreeChart.value.setOption(dgreeOption.value);
  }
  await getStudentCountData();
  await getStudentDegreeData();
  if(clazzChart.value) clazzChart.value.setOption(clazzOption.value);
  if(degreeChart.value) degreeChart.value.setOption(dgreeOption.value);
});
</script>

<template>

  <div class="container">
    <div class="innerForm">
    <h1>班级人数统计</h1>
    <div ref="clazzChartRef" style="width: 600px; height: 500px;"></div>
  </div>

  <div class="innerForm">
    <h1>学员学历统计</h1>
    <div ref="degreeChartRef" style="width: 600px; height: 500px;"></div>
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