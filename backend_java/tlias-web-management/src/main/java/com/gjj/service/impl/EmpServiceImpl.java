package com.gjj.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.gjj.mapper.EmpExprMapper;
import com.gjj.mapper.EmpMapper;
import com.gjj.pojo.*;
import com.gjj.service.EmpLogService;
import com.gjj.service.EmpService;
import com.gjj.utils.JwtUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

@Slf4j
@Service
public class EmpServiceImpl implements EmpService {

    @Autowired
    private EmpMapper empMapper;

    @Autowired
    private EmpExprMapper empExprMapper;

    @Autowired
    private EmpLogService empLogService;


    /*
    * 原始分页查询
    * */
    /*@Override
    public PageResult<Emp> page(Integer page, Integer pageSize) {
        //1. 调用mapper接口，查询总记录数
        Long total = empMapper.count();

        //2. 调用mapper接口，查询结果记录
        Integer start = (page-1)*pageSize;
        List<Emp> rows = empMapper.list(start, pageSize);

        //3. 封装结果 PageResult
        return new PageResult<Emp>(total,rows);
    }*/
    /*
    * 使用PageHelper
    * 1. 定义的SQL语句结尾不能加分号
    * 2.PageHelper仅能对紧跟在其后的第一个查询语句进行分页查询
    *
    * */
    @Override
    public PageResult<Emp> page(EmpQueryParam empQueryParam){
        //设置分页参数
        PageHelper.startPage(empQueryParam.getPage(),empQueryParam.getPageSize());

        //执行查询
        Page<Emp> p = (Page<Emp>)empMapper.list(empQueryParam);

        //解析查询结果，并封装
        //Page<Emp> p = (Page<Emp>) empList;
        return new PageResult<Emp>(p.getTotal(),p.getResult());
    }

    @Override
    public List<Emp> list() {
        return empMapper.list(new EmpQueryParam());
    }

    @Transactional(rollbackFor = {Exception.class}) //事务控制 - 默认出现运行时异常RuntimeException才会回滚
    @Override
    public void save(Emp emp) {
        try {
            //保存员工基本信息
            emp.setCreateTime(LocalDateTime.now());
            emp.setUpdateTime(LocalDateTime.now());
            empMapper.insert(emp);

//            int i = 1/0;
//            System.out.println(i);

            //保存员工工作经历信息
            List<EmpExpr> exprList = emp.getExprList();
            if(!CollectionUtils.isEmpty(exprList)){
                //遍历集合，为empId赋值
                exprList.forEach(empExpr->{
                    empExpr.setEmpId(emp.getId());
                });
                empExprMapper.insertBatch(exprList);
            }
        } finally {
            //记录操作日志
            EmpLog empLog = new EmpLog(null,LocalDateTime.now(),"新增员工：" + emp);
            empLogService.insertLog(empLog);
        }


    }

    @Override
    public Emp getInfo(Integer id) {
        return empMapper.getById(id);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void delete(List<Integer> ids) {
        //1.删除员工基本信息
        empMapper.deleteByIds(ids);

        //2.删除员工工作信息
        empExprMapper.deleteByEmpIds(ids);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void update(Emp emp) {
        //1. 根据id修改员工基本信息
        emp.setUpdateTime(LocalDateTime.now());
        empMapper.updateById(emp);

        //2. 根据id修改员工工作经历信息，先删除再添加
        empExprMapper.deleteByEmpIds(Arrays.asList(emp.getId()));
        List<EmpExpr> exprList = emp.getExprList();
        if(!CollectionUtils.isEmpty(exprList)){
            exprList.forEach(empExpr -> {empExpr.setEmpId(emp.getId());});
            empExprMapper.insertBatch(exprList);
        }
    }

    @Override
    public LoginInfo login(Emp emp) {
        Emp e = empMapper.selectByUsernameAndPassword(emp);
        if(e != null ){
            log.info("用户登录成功: {}", e);
            Map<String, Object> claims = new HashMap<>();
            claims.put("id", e.getId());
            claims.put("username", e.getUsername());
            String token = JwtUtils.generateJwt(claims);
            return new LoginInfo(e.getId(), e.getUsername(), e.getName(),token);
        }
        return null;
    }
}
