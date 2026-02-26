package com.gjj.controller;


import com.gjj.anno.Log;
import com.gjj.pojo.Emp;
import com.gjj.pojo.EmpQueryParam;
import com.gjj.pojo.PageResult;
import com.gjj.pojo.Result;
import com.gjj.service.EmpService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;


/*
 * 员工管理Controller
 * */
@Slf4j
@RequestMapping("/emps")
@RestController
public class EmpController {

    @Autowired
    private EmpService empService;

    /*
     * 分页查询
     * */
    @GetMapping
    public Result page(EmpQueryParam empQueryParam){
        log.info("分页查询:{}", empQueryParam);
        PageResult<Emp> pageResult = empService.page(empQueryParam);

        return Result.success(pageResult);
    }

    /*
     * 查询全部员工信息
     * */
    @GetMapping("/list")
    public Result list(){
        log.info("查询全部员工信息");
        List<Emp> empList = empService.list();
        return Result.success(empList);
    }


    /*
     * 新增员工
     * */
    @Log
    @PostMapping
    public Result save(@RequestBody Emp emp){
        log.info("新增员工：{}",emp);
        empService.save(emp);
        return Result.success();
    }

    @Log
    @DeleteMapping
    public Result delete(@RequestParam List<Integer> ids){
        log.info("删除员工：{}", ids);
        empService.delete(ids);
        return Result.success();
    }

    /*
     * 根据id查询员工信息
     * */
    @GetMapping("/{id}")
    public Result getInfo(@PathVariable Integer id){
        log.info("根据id查询员工信息:{}",id);
        Emp emp = empService.getInfo(id);
        return Result.success(emp);
    }

    /*
     * 修改员工
     * */
    @Log
    @PutMapping
    public Result update(@RequestBody Emp emp){
        log.info("修改员工：{}", emp);
        empService.update(emp);
        return Result.success();
    }

    /*
     * 删除员工 - 接收
     * */
//    @DeleteMapping
//    public Result delete(Integer[] ids){
//        log.info("删除员工：{}", Arrays.toString(ids));
//
//        return Result.success();
//    }
}
