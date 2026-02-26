package com.gjj.service;

import com.gjj.pojo.Clazz;
import com.gjj.pojo.ClazzQueryParam;
import com.gjj.pojo.PageResult;

import java.util.List;

public interface ClazzService {
    /*
    * 分页查询班级
    * */
    PageResult<Clazz> page(ClazzQueryParam clazzQueryParam);

    /*
    * 新增班级
    * */
    void save(Clazz clazz);

    Clazz getInfo(Integer id);

    /*
    * 修改班级
    * */
    void update(Clazz clazz);

    /*
    * 删除班级
    * */
    void delete(Integer id);

    List<Clazz> list();
}
