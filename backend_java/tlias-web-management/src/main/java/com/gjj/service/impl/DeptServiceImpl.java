package com.gjj.service.impl;

import com.gjj.exception.BusinessException;
import com.gjj.mapper.DeptMapper;
import com.gjj.mapper.EmpMapper;
import com.gjj.pojo.Dept;
import com.gjj.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class DeptServiceImpl implements DeptService {

    @Autowired
    private DeptMapper deptMapper;

    @Autowired
    private EmpMapper empMapper;

    @Override
    public List<Dept> findAll() {
        return deptMapper.findAll();
    }

    @Override
    public void deleteById(Integer id) {
        //查询该部门下是否有员工
        Integer isExist = empMapper.selectIsExistByDeptId(id);
        //有员工则不能删除，抛出异常
        if(isExist!=null){
            throw new BusinessException("对不起，当前部门下有员工，不能直接删除！");
        }
        //无员工则可以删除
        deptMapper.deleteById(id);
    }

    @Override
    public void Add(Dept dept) {
        dept.setCreateTime(LocalDateTime.now());
        dept.setUpdateTime(LocalDateTime.now());
        deptMapper.Insert(dept);
    }

    @Override
    public Dept getById(Integer id) {
        return deptMapper.getById(id);
    }

    @Override
    public void update(Dept dept) {
        dept.setUpdateTime(LocalDateTime.now());
        deptMapper.update(dept);
    }
}
