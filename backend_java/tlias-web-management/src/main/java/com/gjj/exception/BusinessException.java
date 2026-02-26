package com.gjj.exception;

public class BusinessException extends RuntimeException {
    //自定义异常
    public BusinessException(String message) {
        super(message);
    }

}
