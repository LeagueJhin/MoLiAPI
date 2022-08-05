package com.bingchunmoli.api.controller.advice;

import com.bingchunmoli.api.bean.MailMessage;
import com.bingchunmoli.api.bean.ResultVO;
import com.bingchunmoli.api.bean.enums.CodeEnum;
import com.bingchunmoli.api.even.MailMessageEven;
import com.bingchunmoli.api.exception.ApiException;
import com.bingchunmoli.api.exception.ApiParamException;
import com.bingchunmoli.api.interceptor.RequestTraceIdInterceptor;
import com.bingchunmoli.api.qrcode.exception.FileIsEmptyException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

/**
 * @author 冰彦糖
 * @version 0.0.1-SNAPSHOT
 **/
@Slf4j
@RestControllerAdvice
@RequiredArgsConstructor
public class ExceptionControllerAdvice {
    private final ApplicationEventPublisher applicationEventPublisher;
    @Value("${spring.mail.enable}")
    private boolean mailEnable;
    private final ObjectMapper om;

    @ExceptionHandler
    public ResultVO<String> fileIsEmptyException(FileIsEmptyException e) {
        log.error("traceId: " + MDC.get(RequestTraceIdInterceptor.TRACE_ID) + "; \t文件为空, ", e);
        return new ResultVO<>(CodeEnum.ERROR.getCode(), e.getMessage(), "文件为空,请确认文件是否存在");
    }

    @ExceptionHandler
    public ResultVO<String> httpRequestMethodNotSupportedException(HttpRequestMethodNotSupportedException e) {
        log.error("traceId: " + MDC.get(RequestTraceIdInterceptor.TRACE_ID) + "; \t没有受支持的方法", e);
        return new ResultVO<>(CodeEnum.ERROR, RequestTraceIdInterceptor.TRACE_ID + ": " + MDC.get(RequestTraceIdInterceptor.TRACE_ID) + "; 没有受支持的请求方法，请求方法错误.");
    }

    @ExceptionHandler
    public ResultVO<String> defaultException(Exception e) {
        log.error("traceId: " + MDC.get(RequestTraceIdInterceptor.TRACE_ID) + "; \tdefaultException: {}, msg: {}", e.getMessage(), e);
        e.printStackTrace();
        if (mailEnable) {
            MailMessage errMailMessage = null;
            try {
                errMailMessage = MailMessage.builder().title("出现未分类异常").body("defaultException: " + e.getLocalizedMessage() + " message: " + e.getMessage() + "\n stackTrace: " + om.writeValueAsString(e.getStackTrace())).build();
            } catch (JsonProcessingException ex) {
                log.error("defaultException: JsonProcessingException: ", ex);
            }
            applicationEventPublisher.publishEvent(new MailMessageEven(errMailMessage));
        }
        return new ResultVO<>(CodeEnum.FAILURE, RequestTraceIdInterceptor.TRACE_ID + ": " + MDC.get(RequestTraceIdInterceptor.TRACE_ID) + "; 默认未分类异常");
    }

    @ExceptionHandler
    public ResultVO<String> defaultThrowable(Throwable throwable) {
        log.error("traceId: " + MDC.get(RequestTraceIdInterceptor.TRACE_ID) + "; \t系统错误: ", throwable);
        return new ResultVO<>(CodeEnum.FAILURE, RequestTraceIdInterceptor.TRACE_ID + ": " + MDC.get(RequestTraceIdInterceptor.TRACE_ID) + "; 严重异常");
    }

    @ExceptionHandler
    public ResultVO<String> apiException(ApiException e) {
        log.error("traceId: " + MDC.get(RequestTraceIdInterceptor.TRACE_ID) + "; \tapi顶层异常: ", e);
        return new ResultVO<>(CodeEnum.FAILURE, RequestTraceIdInterceptor.TRACE_ID + ": " + MDC.get(RequestTraceIdInterceptor.TRACE_ID) + "; api异常");
    }

    @ExceptionHandler
    public ResultVO<String> apiParamException(ApiParamException e) {
        log.error("traceId: " + MDC.get(RequestTraceIdInterceptor.TRACE_ID) + "; \t请求参数不正确或不支持: ", e);
        return new ResultVO<>(CodeEnum.ERROR, RequestTraceIdInterceptor.TRACE_ID + ": " + MDC.get(RequestTraceIdInterceptor.TRACE_ID) + "; 请求参数异常");
    }

    @ExceptionHandler
    public ResultVO<String> jsonProcessingException(JsonProcessingException e){
        log.error("traceId: " + MDC.get(RequestTraceIdInterceptor.TRACE_ID) + "; \tJSON转换异常: ", e);
        return new ResultVO<>(CodeEnum.FAILURE, RequestTraceIdInterceptor.TRACE_ID + ": " + MDC.get(RequestTraceIdInterceptor.TRACE_ID) + "; JSON转换异常");
    }

    @ExceptionHandler
    public ResultVO<String> methodArgumentTypeMismatchException(MethodArgumentTypeMismatchException e){
         log.debug("methodArgumentTypeMismatchException: ", e);
        return new ResultVO<>(CodeEnum.FAILURE, RequestTraceIdInterceptor.TRACE_ID + ": " + MDC.get(RequestTraceIdInterceptor.TRACE_ID) + "; 请求参数类型异常");
    }
}