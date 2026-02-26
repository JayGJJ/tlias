package com.gjj.pojo;

import lombok.Data;

@Data
public class StdQueryParam {
    private Integer page = 1;
    private Integer pageSize = 10;
    private String name;//学员姓名
    private Integer degree;//学历
    private Integer clazzId;//班级
}
