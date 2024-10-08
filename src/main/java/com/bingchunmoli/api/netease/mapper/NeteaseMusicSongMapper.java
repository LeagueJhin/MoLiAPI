package com.bingchunmoli.api.netease.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.bingchunmoli.api.netease.bean.NeteaseMusicSong;

import java.util.List;

/**
* @author MoLi
*/
public interface NeteaseMusicSongMapper extends BaseMapper<NeteaseMusicSong> {

    void saveSongUser(Integer songId, List<Integer> userIds);

    /**
     * 随机一首歌
     * @return 歌曲信息
     */
    NeteaseMusicSong selectRandomSong();
}
