package com.bingchunmoli.api.netease;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.bingchunmoli.api.config.ApiConfig;
import com.bingchunmoli.api.netease.bean.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpHost;
import org.apache.http.HttpRequest;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Slf4j
@Service
@RequiredArgsConstructor
public class MusicService {
    private final ObjectMapper om;
    private final ApiConfig apiConfig;
    private final NeteaseMusicPlaylistService playlistService;
    private final NeteaseMusicAlbumServiceImpl albumService;
    private final NeteaseMusicSongService songService;
    private final NeteaseMusicUserService userService;
    private final String urlHost = "https://music.163.com";
    private final HttpHost baseHost = HttpHost.create(urlHost);

    /**
     * 根据id获取歌单
     * @param id 歌单id
     * @param cookie cookie
     * @return 歌单实体
     */
    public PlayListBO getPlayListInfo(@Valid @NotBlank String id, String cookie){
        Collection<BasicHeader> defaultHeader = List.of(new BasicHeader("cookie", cookie),
                new BasicHeader("referer", "https://music.163.com/"),
                new BasicHeader("accept", "*/*"),
                new BasicHeader("accept-language", "zh,zh-US;q=0.9,zh-SG;q=0.8,en-SG;q=0.7,en;q=0.6,zh-CN;q=0.5"),
                new BasicHeader("pragma", "no-cache"),
                new BasicHeader("sec-fetch-dest", "script"),
                new BasicHeader("sec-fetch-mode", "no-cors"),
                new BasicHeader("sec-fetch-site", "same-site"),
                new BasicHeader("sec-ch-ua", "\n" +
                        "\"Google Chrome\";v=\"129\", \"Not=A?Brand\";v=\"8\", \"Chromium\";v=\"129\""),
                new BasicHeader("sec-ch-ua-platform", "\"windows\""),
                new BasicHeader("origin", "https://music.163.com/"),
                new BasicHeader("sec-ch-ua-mobile", "?0"));
        try (CloseableHttpClient httpClient = HttpClientBuilder.create()
                .setDefaultHeaders(defaultHeader)
                .setUserAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36")
                .build()){
            HttpRequest request = new HttpGet( "/api/playlist/detail?id=" + id);
            return httpClient.execute(baseHost, request, res -> {
                String string = EntityUtils.toString(res.getEntity());
                return om.readValue(string, PlayListBO.class);
            });
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 保存歌单到数据库
     */
    @Scheduled(cron = "0 0 0 * * ?")
    public void savePlayList() {
        if (apiConfig.getPlayListId() == null || apiConfig.getPlayListId().isEmpty()) {
            log.info("playListId is empty ignore");
            return;
        }
        PlayListBO playListInfo = getPlayListInfo(apiConfig.getPlayListId(), apiConfig.getCookies());
        if (playListInfo.getCode() != 200) {
            log.info("playList get err");
            return;
        }
        PlayListBO.ResultDTO playList = playListInfo.getResult();
        PlayListBO.ResultDTO.CreatorDTO creator = playList.getCreator();
        NeteaseMusicUser playListUser = NeteaseMusicUser.builder()
                .thirdId(creator.getUserId().longValue())
                .avatarUrl(creator.getAvatarUrl())
                .city(creator.getCity())
                .birthday(creator.getBirthday())
                .nickname(creator.getNickname())
                .backgroundImg(creator.getBackgroundUrl()).build();
        Integer playUserId = userService.saveOrUpdateByThirdId(playListUser);
        NeteaseMusicPlaylist musicPlaylist = NeteaseMusicPlaylist.builder()
                .thirdId(playList.getId())
                .userId(String.valueOf(playUserId))
                .name(playList.getName())
                .description(String.valueOf(playList.getDescription()))
                .createTime(LocalDateTime.ofInstant(Instant.ofEpochMilli(playList.getCreateTime()), ZoneId.systemDefault()))
                .updateTime(LocalDateTime.ofInstant(Instant.ofEpochMilli(playList.getUpdateTime()), ZoneId.systemDefault())).build();
        playlistService.saveIsExist(musicPlaylist);
        List<PlayListBO.ResultDTO.TracksDTO> tracks = playList.getTracks();
        if (tracks == null || tracks.isEmpty()) {
            return;
        }
        Integer trackCount = playList.getTrackCount();
        log.info("test, trackCount: {}, tracksSize: {}", trackCount, tracks.size());
        List<NeteaseMusicSong> songs = new ArrayList<>(tracks.size());
        for (PlayListBO.ResultDTO.TracksDTO track : tracks) {
            PlayListBO.ResultDTO.TracksDTO.AlbumDTO album = track.getAlbum();
            NeteaseMusicAlbum musicAlbum = NeteaseMusicAlbum.builder()
                    .thirdId(album.getId().longValue())
                    .name(album.getName())
                    .picUrl(album.getPicUrl())
                    .type(album.getType())
                    .userId(album.getArtist().getId())
                    .publishTime(LocalDateTime.ofInstant(Instant.ofEpochMilli(album.getPublishTime()), ZoneId.systemDefault())).build();
            NeteaseMusicAlbum dbAlbum = albumService.getOne(new LambdaQueryWrapper<NeteaseMusicAlbum>()
                    .eq(NeteaseMusicAlbum::getThirdId, musicAlbum.getThirdId()));
            if (dbAlbum == null) {
                albumService.save(musicAlbum);
            }else {
                musicAlbum.setId(dbAlbum.getId());
                albumService.updateById(musicAlbum);
            }
            List<PlayListBO.ResultDTO.TracksDTO.ArtistsDTO> artists = track.getArtists();
            List<NeteaseMusicUser> musicUserList = new ArrayList<>(artists.size());
            for (PlayListBO.ResultDTO.TracksDTO.ArtistsDTO artist : artists) {
                NeteaseMusicUser musicUser = NeteaseMusicUser.builder()
                        .thirdId(artist.getId().longValue())
                        .nickname(artist.getName())
                        .backgroundImg(artist.getPicUrl())
                        .build();
                musicUserList.add(musicUser);
            }
            NeteaseMusicSong song = NeteaseMusicSong.builder()
                    .name(track.getName())
                    .thirdId(Long.valueOf(track.getId()))
                    .albumId(musicAlbum.getId())
                    .artists(musicUserList)
                    .playlistId(musicPlaylist.getId())
                    .build();
            songs.add(song);
        }
        songService.saveBatchAndChild(songs);
        try {
            TimeUnit.MINUTES.sleep(5);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    public String getRandomMusicId() {
        return String.valueOf(songService.getRandomSong().getThirdId());
    }

    public List<NeteaseMusicSongVO> getMusicSongList(String id) {
        return songService.getMusicSongList(id);
    }
}
