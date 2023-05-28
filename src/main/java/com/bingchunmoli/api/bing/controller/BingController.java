package com.bingchunmoli.api.bing.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.bingchunmoli.api.bean.ResultVO;
import com.bingchunmoli.api.bing.bean.BingImage;
import com.bingchunmoli.api.bing.bean.BingImageVO;
import com.bingchunmoli.api.bing.bean.enums.BingEnum;
import com.bingchunmoli.api.bing.service.BingService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.xml.transform.Result;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

/**
 * bing每日美图
 *
 * @author BingChunMoLi
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("bing")
public class BingController {
    private final BingService bingService;

    /**
     * 每日随机图国内版
     *
     * @return bing图片对象|
     */
    @GetMapping("cn")
    public ResultVO<BingImageVO> cnBingImage() {
        return ResultVO.ok(bingService.getBingImage(BingEnum.CN_BING));
    }

    /**
     * 每日随机图国际版
     *
     * @return bing图片对象|
     */
    @GetMapping("en")
    public ResultVO<BingImageVO> enBingImage() {
        return ResultVO.ok(bingService.getBingImage(BingEnum.EN_BING));
    }

    /**
     * 每日随机图
     *
     * @return bing图片对象|
     */
    @GetMapping("all")
    public ResultVO<BingImage> getAllBingImage() {
        return ResultVO.ok(bingService.getAllBingImage());
    }

    /**
     * 获取随机一张图的url
     *
     * @return 随即Bing图的url
     */
    @GetMapping("random")
    public ResultVO<String> getRandomBingImg() {
        return ResultVO.ok(bingService.getRandomImg());
    }

    /**
     * 获取指定日期的Bing随机图json
     * @param year 年
     * @param month 月
     * @param day 日
     * @return bing图片
     */
    @GetMapping("{year}/{month}/{day}")
    public ResultVO<BingImage> getImageByYearMonthDay(@PathVariable Integer year, @PathVariable Integer month, @PathVariable Integer day){
        return ResultVO.ok(bingService.getBingImageByDate(LocalDate.of(year, month, day)));
    }

    /**
     * 获取指定日期的bing随机图
     * @param date 日期
     * @return BingImage
     */
    @GetMapping("date")
    public ResultVO<BingImage> getBingImageByDate(LocalDate date){
        return ResultVO.ok(bingService.getBingImageByDate(date));
    }
}
