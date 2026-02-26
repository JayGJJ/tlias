package com.gjj.pojo;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Data
public class ClazzQueryParam {
    private Integer page = 1; //页码
    private Integer pageSize = 10; //每页记录数
    private String name;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate begin;//结课开始时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate end;//结课结束时间
}
