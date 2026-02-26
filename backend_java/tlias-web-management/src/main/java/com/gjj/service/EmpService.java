package com.gjj.service;

import com.gjj.pojo.Emp;
import com.gjj.pojo.EmpQueryParam;
import com.gjj.pojo.LoginInfo;
import com.gjj.pojo.PageResult;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.util.List;

public interface EmpService {

    /*
    * 分页查询
    * */
    PageResult<Emp> page(EmpQueryParam empQueryParam);


    /*
    * 新增员工信息
    * */
    void save(Emp emp);

    /*
    * 批量删除员工信息
    * */
    void delete(List<Integer> ids);

    /*
    * 根据id查询员工信息
    * */
    Emp getInfo(Integer id);

    /*
    * 修改员工
    * */
    void update(Emp emp);

    /*
    * 查询全部员工信息
    * */
    List<Emp> list();

    LoginInfo login(Emp emp);
}
