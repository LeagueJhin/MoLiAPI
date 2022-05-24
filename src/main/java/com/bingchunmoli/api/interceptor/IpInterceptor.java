package com.bingchunmoli.api.interceptor;

import cn.hutool.extra.servlet.ServletUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * @author MoLi
 */
@Slf4j
@Component
@RequiredArgsConstructor
@ConditionalOnBean(RedisTemplate.class)
public class IpInterceptor implements HandlerInterceptor {
    private final RedisTemplate<String, Object> redisTemplate;


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//        ServletContext servletContext = request.getServletContext();
        String requestURI = request.getRequestURI();
        String clientIP = ServletUtil.getClientIP(request);
        StringBuffer stringBuffer = new StringBuffer();
        String key = stringBuffer.append("filter:").append(requestURI).append(":").append(clientIP).append(":").append(request.getRequestedSessionId()).toString();
//        Lock lock = new ReentrantLock();
//        lock.lock();
//        try {
            Integer value = (Integer)redisTemplate.opsForValue().get(key);
            if (value != null && value > 10) {
                response.setStatus(429);
                return false;
            }
            AtomicInteger count = new AtomicInteger();
            if (value == null) {
                count.getAndIncrement();
                if (log.isDebugEnabled()) {
                    log.debug("{}用户首次访问{}", clientIP, requestURI);
                }
            }else {
                count.getAndAdd(value + 1);
            }
            if (log.isDebugEnabled()) {
                log.debug("{}访问{}{}次", clientIP, requestURI, count.get());
            }
            redisTemplate.opsForValue().set(key, count.get(), 60, TimeUnit.SECONDS);
//        }finally {
//            lock.unlock();
//        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
