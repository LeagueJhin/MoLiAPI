package com.bingchunmoli.api.netease.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.bingchunmoli.api.netease.bean.NeteaseMusicSong;
import com.bingchunmoli.api.netease.bean.NeteaseMusicSongVO;

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

    /**
     * 获取该歌单的用户
     * @param id
     * @return
     */
    List<Integer> getSongUser(Integer id);

    List<NeteaseMusicSongVO> getMusicSongList(String id);

    String getNickname(String userId);
}
