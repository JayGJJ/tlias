package com.gjj.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;

@Slf4j
// @WebFilter("/*")
public class DemoFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        log.info("DemoFilter拦截到了请求...");
        filterChain.doFilter(servletRequest,servletResponse);


    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        log.info("DemoFilter初始化...");
    }

    @Override
    public void destroy() {
        log.info("DemoFilter销毁...");
    }
}
