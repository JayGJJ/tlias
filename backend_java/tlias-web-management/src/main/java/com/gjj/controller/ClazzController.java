package com.gjj.controller;

import com.gjj.anno.Log;
import com.gjj.pojo.Clazz;
import com.gjj.pojo.ClazzQueryParam;
import com.gjj.pojo.PageResult;
import com.gjj.pojo.Result;
import com.gjj.service.ClazzService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequestMapping("/clazzs")
@RestController
public class ClazzController {

    @Autowired
    private ClazzService clazzService;

    /*
    * 班级分页查询
    * */
    @GetMapping
    public Result page(ClazzQueryParam clazzQueryParam){
        log.info("班级分页查询：{}",clazzQueryParam);
        PageResult<Clazz> pageResult = clazzService.page(clazzQueryParam);
        return Result.success(pageResult);
    }

    @GetMapping("/list")
    public Result list(){
        log.info("班级列表查询");
        List<Clazz> clazzList = clazzService.list();
        return Result.success(clazzList);
    }

    @Log
    @PostMapping
    public Result save(@RequestBody Clazz clazz){
        log.info("新增班级：{}",clazz);
        clazzService.save(clazz);
        return Result.success();
    }

    @GetMapping("/{id}")
    public Result getInfo(@PathVariable Integer id){
        log.info("根据id获取班级信息：{}",id);
        Clazz clazz = clazzService.getInfo(id);
        return Result.success(clazz);
    }

    @Log
    @PutMapping
    public Result update(@RequestBody Clazz clazz){
        log.info("更新班级信息：{}",clazz);
        clazzService.update(clazz);
        return Result.success();
    }

    @Log
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id){
        log.info("删除班级信息：{}",id);
        clazzService.delete(id);
        return Result.success();
    }

}
