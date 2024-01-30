package com.bingchunmoli.api.bing.controller;

import com.baomidou.mybatisplus.test.autoconfigure.AutoConfigureMybatisPlus;
import com.bingchunmoli.api.app.DeviceService;
import com.bingchunmoli.api.app.mapper.DeviceMapper;
import com.bingchunmoli.api.bing.bean.BingImage;
import com.bingchunmoli.api.bing.bean.BingImageVO;
import com.bingchunmoli.api.bing.bean.enums.BingEnum;
import com.bingchunmoli.api.bing.mapper.BingImageMapper;
import com.bingchunmoli.api.bing.service.BingService;
import com.bingchunmoli.api.utils.RedisUtil;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Slf4j
@AutoConfigureMybatisPlus
@WebMvcTest(BingController.class)
public class BingControllerTest {

    @Autowired
    private MockMvc mockMvc;
    @MockBean
    private BingService bingService;
    @MockBean
    private BingImageMapper bingMapper;
    @MockBean
    private DeviceService deviceService;
    @MockBean
    private DeviceMapper deviceMapper;
    @MockBean
    private RedisUtil redisUtil;

    @Test
    void cnBingImage() throws Exception {
        Mockito.when(bingService.getBingImage(BingEnum.CN_BING)).thenReturn(new BingImageVO());
        mockMvc.perform(MockMvcRequestBuilders.get("/bing/cn"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON));
        Mockito.verify(bingService, Mockito.times(1)).getBingImage(BingEnum.CN_BING);
    }

    @Test
    void enBingImage() throws Exception {
        Mockito.when(bingService.getBingImage(BingEnum.EN_BING)).thenReturn(new BingImageVO());
        mockMvc.perform(MockMvcRequestBuilders.get("/bing/en"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON));
        Mockito.verify(bingService, Mockito.times(1)).getBingImage(BingEnum.EN_BING);
    }

    @Test
    void getAllBingImage() throws Exception {
        Mockito.when(bingService.getAllBingImage()).thenReturn(new BingImage());
        mockMvc.perform(MockMvcRequestBuilders.get("/bing/all"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON));
        Mockito.verify(bingService, Mockito.times(1)).getAllBingImage();
    }

    @Test
    void getRandomBingImg() throws Exception {
        Mockito.when(bingService.getRandomImg()).thenReturn("");
        mockMvc.perform(MockMvcRequestBuilders.get("/bing/random"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON));
        Mockito.verify(bingService, Mockito.times(1)).getRandomImg();
    }

    @Test
    void getImageByYearMonthDay() throws Exception {
        LocalDate now = LocalDate.now();
        int year = now.getYear();
        int month = now.getMonth().getValue();
        int day = now.getDayOfMonth();
        Mockito.when(bingService.getBingImageByDate(now)).thenReturn(new BingImage());
        mockMvc.perform(MockMvcRequestBuilders.get("""
                /bing/{year}/{month}/{day}
                """.strip(), year, month, day))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON));
        Mockito.verify(bingService, Mockito.times(1)).getBingImageByDate(now);
    }

    @Test
    void getBingImageByDate() throws Exception {
        LocalDate now = LocalDate.now();
        Mockito.when(bingService.getBingImageByDate(now)).thenReturn(new BingImage());
        mockMvc.perform(MockMvcRequestBuilders.get("/bing/date?date=" + now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON));
        Mockito.verify(bingService, Mockito.times(1)).getBingImageByDate(now);
    }
}
