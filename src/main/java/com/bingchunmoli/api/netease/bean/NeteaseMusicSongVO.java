package com.bingchunmoli.api.netease.bean;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

/**
 * @author moli
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class NeteaseMusicSongVO extends NeteaseMusicSong{
    /**
     * 专辑图片
     */
    private String picUrl;

    /**
     * 专辑发布时间
     */
    private LocalDateTime publishTime;

    /**
     * 类型
     */
    private String type;

    /**
     * 艺术家
     */
    private String nickname;
}
