package com.gjj.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.gjj.exception.BusinessException;
import com.gjj.mapper.ClazzMapper;
import com.gjj.mapper.StudentMapper;
import com.gjj.pojo.Clazz;
import com.gjj.pojo.ClazzQueryParam;
import com.gjj.pojo.PageResult;
import com.gjj.service.ClazzService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class ClazzServiceImpl implements ClazzService {

    @Autowired
    private ClazzMapper clazzMapper;

    @Autowired
    private StudentMapper studentMapper;

    @Override
    public PageResult<Clazz> page(ClazzQueryParam clazzQueryParam) {
        //设置分页参数
        PageHelper.startPage(clazzQueryParam.getPage(), clazzQueryParam.getPageSize());
        Page<Clazz> p = (Page<Clazz>)clazzMapper.list(clazzQueryParam);
        p.forEach(clazz -> {
            if(LocalDate.now().isAfter(clazz.getEndDate())){
                clazz.setStatus("已结课");
            }else if(LocalDate.now().isBefore(clazz.getBeginDate())){
                clazz.setStatus("未开班");
            }else{
                clazz.setStatus("在读中");
            }
        });
        return new PageResult<>(p.getTotal(),p.getResult());
    }

    @Override
    public List<Clazz> list() {
        return clazzMapper.selectlist();
    }

    @Override
    public void save(Clazz clazz) {
        clazz.setUpdateTime(LocalDateTime.now());
        clazz.setCreateTime(LocalDateTime.now());
        clazzMapper.insert(clazz);
    }

    @Override
    public Clazz getInfo(Integer id) {
        return clazzMapper.selectById(id);
    }

    @Override
    public void update(Clazz clazz) {
        clazz.setUpdateTime(LocalDateTime.now());
        clazzMapper.update(clazz);
    }

    @Override
    public void delete(Integer id) {
        //根据班级id查询是否有关联的学生和课程，有则不允许删除
        Integer isExist = studentMapper.stdIsExist(id);
        //有相关学生则抛出自定义异常
        if(isExist != null){
            throw new BusinessException("对不起, 该班级下有学生, 不能直接删除");
        }
        //无相关学生则删除
        clazzMapper.delete(id);
    }
}
