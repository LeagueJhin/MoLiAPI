package com.bingchunmoli.api.netease.bean;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

/**
 * 歌曲
 */

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@TableName(value ="netease_music_song")
public class NeteaseMusicSong implements Serializable {
    /**
     *
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     *
     */
    @TableField(value = "name")
    private String name;

    /**
     * 第三方平台Id
     */
    @TableField(value = "third_id")
    private Long thirdId;

    /**
     * 专辑id
     */
    @TableField(value = "album_id")
    private Integer albumId;

    /**
     * 歌单id
     */
    @TableField("playlist_id")
    private Integer playlistId;

    @TableField(exist = false)
    private List<NeteaseMusicUser> artists;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
