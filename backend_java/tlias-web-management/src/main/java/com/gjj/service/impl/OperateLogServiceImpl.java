package com.gjj.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.gjj.mapper.OperateLogMapper;
import com.gjj.pojo.OperateLog;
import com.gjj.pojo.PageResult;
import com.gjj.service.OperateLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OperateLogServiceImpl implements OperateLogService {

    @Autowired
    private OperateLogMapper operateLogMapper;

    @Override
    public PageResult<OperateLog> page(Integer page, Integer pageSize) {
        PageHelper.startPage(page, pageSize);

        Page<OperateLog> result = (Page<OperateLog>) operateLogMapper.select();

        return new PageResult<>(result.getTotal(), result.getResult());
    }

}
