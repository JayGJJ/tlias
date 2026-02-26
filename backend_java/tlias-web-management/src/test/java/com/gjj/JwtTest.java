package com.gjj;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.junit.jupiter.api.Test;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class JwtTest {

    /*
    * 生成JWT令牌
    * */
    @Test
    public void testGenerateJwt() {
        Map<String,Object> dataMap = new HashMap<>();
        dataMap.put("id", 1);
        dataMap.put("username", "gjj");
        String jwt = Jwts.builder().signWith(SignatureAlgorithm.HS256,"Z2pq")//指定加密算法和密钥
                .addClaims(dataMap) //添加载荷信息
                .setExpiration(new Date(System.currentTimeMillis() + 3600*1000)) //设置过期时间1小时;
                .compact(); //生成JWT令牌
        System.out.println("生成的JWT令牌: " + jwt);
    }

    /*
    * 解析Jwt令牌
    * */
    @Test
    public void testParseJwt() {
        String token = "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJnamoiLCJleHAiOjE3Njk5NDA3Mjh9.y5_zUXfk1OkhdPVp7NgOYYOLfh2aVSbezbOc7AjYt6s";

        Claims claims = Jwts.parser().setSigningKey("Z2pq").parseClaimsJws(token).getBody();

        System.out.println(claims);
    }
}
