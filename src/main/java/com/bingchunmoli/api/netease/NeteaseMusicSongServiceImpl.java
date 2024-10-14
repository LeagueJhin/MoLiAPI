package com.bingchunmoli.api.netease;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.bingchunmoli.api.netease.bean.NeteaseMusicSong;
import com.bingchunmoli.api.netease.bean.NeteaseMusicSongVO;
import com.bingchunmoli.api.netease.mapper.NeteaseMusicSongMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.aop.framework.AopContext;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
* @author MoLi
*/
@Service
@RequiredArgsConstructor
public class NeteaseMusicSongServiceImpl extends ServiceImpl<NeteaseMusicSongMapper, NeteaseMusicSong> implements NeteaseMusicSongService{
    private final NeteaseMusicUserService neteaseMusicUserService;

    @Override
    public void saveBatchAndChild(List<NeteaseMusicSong> songs) {
        if (songs == null || songs.isEmpty()) {
            return;
        }
        List<NeteaseMusicSong> dbSongs = list(new LambdaQueryWrapper<NeteaseMusicSong>()
                .in(NeteaseMusicSong::getThirdId, songs.stream().map(NeteaseMusicSong::getThirdId).toList()));
        if (dbSongs == null || dbSongs.isEmpty()) {
            ((NeteaseMusicSongService)AopContext.currentProxy()).saveBatch(songs);
            for (NeteaseMusicSong song : songs) {
                List<Integer> userIds = neteaseMusicUserService.getIdBatch(song.getArtists());
                getBaseMapper().saveSongUser(song.getId(), userIds);
            }
        }else {
            ((NeteaseMusicSongService) AopContext.currentProxy()).updateBatchById(songs.stream().filter(v -> v.getId() != null).collect(Collectors.toList()));
            ((NeteaseMusicSongService) AopContext.currentProxy()).saveBatch(songs.stream().filter(v -> v.getId() == null).collect(Collectors.toList()));
            for (NeteaseMusicSong song : songs) {
                List<Integer> userIds = neteaseMusicUserService.getIdBatch(song.getArtists());
                List<Integer> alreadyExistsUserIds = getBaseMapper().getSongUser(song.getId());
                List<Integer> saveUserIds = alreadyExistsUserIds.stream().filter(v -> !userIds.contains(v)).toList();
                if (CollUtil.isNotEmpty(saveUserIds)) {
                    getBaseMapper().saveSongUser(song.getId(), saveUserIds);
                }
            }
        }
    }

    @Override
    public NeteaseMusicSong getRandomSong() {
        return getBaseMapper().selectRandomSong();
    }

    @Override
    public List<NeteaseMusicSongVO> getMusicSongList(String id) {
        return getBaseMapper().getMusicSongList(id);
    }
}
