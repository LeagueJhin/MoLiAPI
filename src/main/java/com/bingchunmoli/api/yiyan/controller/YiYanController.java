package com.bingchunmoli.api.yiyan.controller;

import com.bingchunmoli.api.yiyan.service.IYiYanService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * 一言
 * @author BingChunMoLi
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("yiyan")
public class YiYanController {
    private final IYiYanService yiYanService;

    /**
     * 根据ID获取一言
     * @param id id|1
     * @return 一言数据
     */
    @GetMapping("{id}")
    public Object getYiYan(@PathVariable Integer id) {
        return yiYanService.getYiYan(id);
    }

    /**
     * 查询随机一条一言数据
     *
     * @return 一条一言
     */
    @GetMapping("random")
    @CrossOrigin
    public Object getRandomYiYan() {
        return yiYanService.findRandomYiYan();
    }
}
