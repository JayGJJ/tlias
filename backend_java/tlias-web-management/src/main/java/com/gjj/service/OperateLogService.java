package com.gjj.service;

import com.gjj.pojo.OperateLog;
import com.gjj.pojo.PageResult;

public interface OperateLogService {

    /*
    * 日志分页查询
    * */
    PageResult<OperateLog> page(Integer page, Integer pageSize);

}
