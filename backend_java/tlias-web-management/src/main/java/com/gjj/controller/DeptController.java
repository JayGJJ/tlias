package com.gjj.controller;

import com.gjj.anno.Log;
import com.gjj.pojo.Dept;
import com.gjj.pojo.Result;
import com.gjj.service.DeptService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequestMapping("/depts")
@RestController
public class DeptController {

    //private static final Logger log = LoggerFactory.getLogger(DeptController.class);

    @Autowired
    private DeptService deptService;

    //method指定请求方式
    //@RequestMapping(value = "/depts",method = RequestMethod.GET)
    @GetMapping
    public Result list(){
        //System.out.println("查询全部部门数据");
        log.info("查询全部部门数据");
        List<Dept> deptList= deptService.findAll();
        return Result.success(deptList);
    }

    /*
    * 省略@RequestParam，前端请求参数名与服务端方法形参名一致
    * */
    @Log
    @DeleteMapping
    public Result deleteById(Integer id){
        //System.out.println("根据id删除部门数据" + id);
        log.info("根据id删除部门数据: {}",id);
        deptService.deleteById(id);
        return Result.success();
    }

    /*
    * 新增部门
    * */
    @Log
    @PostMapping
    public Result Add(@RequestBody Dept dept){
        //System.out.println(dept);
        log.info("新增部门：{}",dept);
        deptService.Add(dept);
        return Result.success();
    }

    /*
    * 根据ID查询部门
    * */
    @GetMapping("/{id}")
    public Result getInfo(@PathVariable Integer id){
        //System.out.println("查询部门的ID为" + id);
        log.info("查询部门的ID为{}" , id);
        Dept dept = deptService.getById(id);
        return Result.success(dept);
    }

    /*
    * 修改部门
    * */
    @Log
    @PutMapping
    public Result update(@RequestBody Dept dept){
//        System.out.println("修改的部门为" + dept);
        log.info("修改的部门为{}" , dept);
        deptService.update(dept);
        return Result.success();
    }


    /*
     * 一旦声明了@RequestParam，参数在请求时必须传递，如果不传递会报错。(默认required为true)
     * */
/*    @DeleteMapping("/depts")
    public Result deleteById(@RequestParam(value = "id",required = false) Integer id){
        System.out.println("根据id删除部门数据" + id);
        deptService.deleteById(id);
        return Result.success();
    }*/

    /*public Result deleteById(HttpServletRequest request){
        String idStr = request.getParameter("id");
        int id = Integer.parseInt(idStr);
        System.out.println("根据id删除部门数据" + id);
        deptService.deleteById(id);
        return Result.success();
    }*/

}
