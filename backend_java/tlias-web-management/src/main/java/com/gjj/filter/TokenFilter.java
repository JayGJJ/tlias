package com.gjj.filter;


import com.gjj.utils.CurrentHolder;
import com.gjj.utils.JwtUtils;
import io.jsonwebtoken.Claims;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;

@Slf4j
@WebFilter("/*")
public class TokenFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String requestURI = request.getRequestURI(); //获取请求的URI

        //是否是登录请求
        if(requestURI.contains("/login")){
            log.info("登录请求，放行");
            filterChain.doFilter(request,response);
            return;
        }
        //获取令牌
        String token = request.getHeader("token");
        if(token==null || token.isEmpty()){
            log.info("请求未携带令牌，拒绝访问");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); //401未授权
            return;
        }

        try {
            Claims claims = JwtUtils.parseJWT(token);
            Integer empId = Integer.valueOf(claims.get("id").toString());
            CurrentHolder.setCurrentId(empId);
            log.info("当前登录员工ID: {}, 将其存入ThreadLocal", empId);
        } catch (Exception e) {
            log.info("令牌非法，拒绝访问");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); //401未授权
            return;
        }

        log.info("令牌合法，放行");
        filterChain.doFilter(request,response);

        // 删除ThreadLocal中的数据
        CurrentHolder.remove();
    }
}
