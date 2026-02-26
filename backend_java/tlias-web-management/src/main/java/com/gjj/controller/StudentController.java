package com.gjj.controller;

import com.gjj.anno.Log;
import com.gjj.pojo.PageResult;
import com.gjj.pojo.Result;
import com.gjj.pojo.StdQueryParam;
import com.gjj.pojo.Student;
import com.gjj.service.StudentService;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequestMapping("/students")
@RestController
public class StudentController {

    @Autowired
    private StudentService studentService;

    @GetMapping
    public Result Page(StdQueryParam stdQueryParam){
        log.info("学生分页查询: {}",stdQueryParam);
        PageResult<Student> pageResult = studentService.Page(stdQueryParam);
        return Result.success(pageResult);
    }

    @Log
    @PostMapping
    public Result save(@RequestBody Student student){
        log.info("学生信息保存；{}",student);
        studentService.save(student);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result getInfo(@PathVariable Integer id){
        log.info("学生信息查询: {}",id);
        Student student = studentService.getInfo(id);
        return Result.success(student);
    }

    @Log
    @PutMapping
    public Result update(@RequestBody Student student){
        log.info("学生信息修改: {}",student);
        studentService.update(student);
        return Result.success();
    }

    @Log
    @DeleteMapping("/{ids}")
    public Result delete(@PathVariable List<Integer> ids){
        log.info("学生信息删除: {}",ids);
        studentService.delete(ids);
        return Result.success();
    }

    @Log
    @PutMapping("/violation/{id}/{score}")
    public Result violation(@PathVariable Integer id, @PathVariable Integer score){
        log.info("学生违纪扣分: {},{}",id,score);
        studentService.violation(id, score);
        return Result.success();
    }

}
