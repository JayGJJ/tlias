package com.gjj.interceptor;

import com.gjj.utils.JwtUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Slf4j
@Component
public class TokenInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

//        String requestURI = request.getRequestURI();
//
//        if(requestURI.contains("/login")){
//            log.info("登录请求，放行");
//            return true;
//        }

        String token = request.getHeader("token");
        if(token==null || token.isEmpty()){
            log.info("请求未携带令牌，拒绝访问");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); //401未授权
            return false;
        }

        try {
            JwtUtils.parseJWT(token);
        } catch (Exception e) {
            log.info("令牌非法，拒绝访问");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); //401未授权
            return false;
        }

        log.info("令牌合法，放行");
        return true;
    }
}
