package com.gjj.service.impl;

import com.gjj.mapper.EmpMapper;
import com.gjj.mapper.StudentMapper;
import com.gjj.pojo.ClazzOption;
import com.gjj.pojo.JobOption;
import com.gjj.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ReportServiceImpl implements ReportService {
    @Autowired
    private EmpMapper empMapper;

    @Autowired
    private StudentMapper studentMapper;

    @Override
    public JobOption getEmpJobData() {
        // 调用mapper接口获取统计数据
        List<Map<String, Object>> list = empMapper.countEmpJobData(); //map:pos = 教研主管，num=1

        // 组装结果并返回
        List<Object> jobList = list.stream().map(dataMap -> dataMap.get("pos")).toList();
        List<Object> dataList = list.stream().map(dataMap -> dataMap.get("num")).toList();
        return new JobOption(jobList,dataList);
    }

    @Override
    public List<Map<String, Object>> getEmpGenderData() {
        return empMapper.countEmpGenderData();
    }

    @Override
    public ClazzOption getStudentCountData() {
        List<Map<String,Object>> list = studentMapper.selectCountByClazz();
        List<Object>  clazzList = list.stream().map(dataMap-> dataMap.get("clazz")).toList();
        List<Object>  dataList = list.stream().map(dataMap-> dataMap.get("num")).toList();
        return new ClazzOption(clazzList,dataList);
    }

    @Override
    public List<Map<String, Object>> getStudentDegreeData() {
        return studentMapper.selectCountByDegree();
    }
}
