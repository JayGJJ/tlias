package com.gjj.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.gjj.mapper.StudentMapper;
import com.gjj.pojo.PageResult;
import com.gjj.pojo.StdQueryParam;
import com.gjj.pojo.Student;
import com.gjj.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;

    @Override
    public PageResult<Student> Page(StdQueryParam stdQueryParam) {
        //设置分页参数
        PageHelper.startPage(stdQueryParam.getPage(),stdQueryParam.getPageSize());

        Page<Student> page =(Page<Student>) studentMapper.selectPage(stdQueryParam);

        return new PageResult<>(page.getTotal(),page.getResult());
    }

    @Override
    public void save(Student student) {
        student.setUpdateTime(LocalDateTime.now());
        student.setCreateTime(LocalDateTime.now());
        studentMapper.insert(student);
    }

    @Override
    public Student getInfo(Integer id) {
        return studentMapper.selectById(id);
    }

    @Override
    public void update(Student student) {
        student.setUpdateTime(LocalDateTime.now());
        studentMapper.update(student);
    }

    @Override
    public void delete(List<Integer> ids) {
        studentMapper.deleteBatch(ids);
    }

    @Override
    public void violation(Integer id, Integer score) {
        Student student = studentMapper.selectViolationById(id);
        short violationCount = (short)(student.getViolationCount() + 1);
        short violationScore = (short)(student.getViolationScore() + score);
        student.setViolationCount(violationCount);
        student.setViolationScore(violationScore);
        studentMapper.update(student);
    }
}
