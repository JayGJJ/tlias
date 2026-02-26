package com.gjj.service;

import com.gjj.pojo.PageResult;
import com.gjj.pojo.StdQueryParam;
import com.gjj.pojo.Student;

import java.util.List;

public interface StudentService {

    PageResult<Student> Page(StdQueryParam stdQueryParam);

    void save(Student student);

    Student getInfo(Integer id);

    void update(Student student);

    void delete(List<Integer> ids);

    void violation(Integer id, Integer score);
}
