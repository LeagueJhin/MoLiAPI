create schema if not EXISTS api;
use api;
CREATE TABLE IF NOT EXISTS `bing_image`
(
    `id`                 bigint not null auto_increment,
    `start_date`         varchar(30)  default null comment '开始时间',
    `start_date_en`      varchar(30)  default null comment '国际版开始时间',
    `full_start_date`    varchar(30)  default null comment '开始时间完全版',
    `full_start_date_en` varchar(30)  default null comment '国际版开始时间完全版',
    `end_date`           varchar(30)  default null comment '结束时间',
    `end_date_en`        varchar(30)  default null comment '结束时间国际版',
    `url`                varchar(150) default null comment '图片地址',
    `url_en`             varchar(150) default null comment '国际版图片地址',
    `url_base`           varchar(70)  default null comment '图片地址基础不带清晰度',
    `url_base_en`        varchar(70)  default null comment '国际版图片地址基础不带清晰度',
    `copyright`          varchar(200) default null comment '版权信息',
    `copyright_en`       varchar(200) default null comment '国际版版权信息',
    `copyright_link`     varchar(300) default null comment '版权信息链接',
    `copyright_link_en`  varchar(300) default null comment '国际版版权信息链接',
    `headline_en`        varchar(100) default null comment '',
    `create_time`        datetime     default null comment '创建时间',
    `obs_url_cn`         varchar(120) default null comment '中国版obs地址,已废弃',
    `obs_url_en`         varchar(120) default null comment '国际版obs地址,已废弃',
    `url_uhd`            varchar(255) default null comment '原图地址',
    `url_uhd_en`         varchar(255) default null comment '国际版原图地址',
    primary key (`id`)
);

CREATE TABLE IF NOT EXISTS `host`
(
    `id`     int not null auto_increment,
    `ip`     varchar(30) default null comment 'ip',
    `domain` varchar(60) default null comment '域名',
    `source` varchar(30) default null comment '来源',
    primary key (`id`),
    unique key `host_id_uindex` (`id`)
);

CREATE TABLE IF NOT EXISTS `navigation`
(
    `id`     int                          not null auto_increment primary key,
    `title`  varchar(30) comment '标题',
    `des`    varchar(300) comment '详细信息',
    `url`    varchar(1000) comment '网址',
    `icon`   varchar(1000) comment '图标',
    `tenant` varchar(30) default 'public' not null comment '租户'
);

CREATE TABLE IF NOT EXISTS `tag`
(
    `id`         int                   not null auto_increment primary key,
    `tag_name`   varchar(20)           not null comment '标签名称',
    `is_open`    boolean default false not null comment '是否可以打开标签组',
    `is_private` boolean default false not null comment '是否是私有的',
    `pwd`        varchar(50) comment '密码(如果是私有的需要密码)'
);

CREATE TABLE IF NOT EXISTS `navigation_tag`
(
    `id`            int not null auto_increment primary key,
    `tag_id`        int not null comment '标签id',
    `navigation_id` int not null comment '导航id'
);

CREATE TABLE IF NOT EXISTS `shi_ci`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `content`     varchar(100) DEFAULT NULL,
    `origin`      varchar(100) DEFAULT NULL,
    `author`      varchar(10)  DEFAULT NULL,
    `category`    varchar(100) DEFAULT NULL,
    `deleted`     int          DEFAULT 0,
    `create_time` datetime     DEFAULT NULL,
    `update_time` datetime     DEFAULT NULL,
    `version`     int          DEFAULT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `yi_yan`
(
    `id`          int NOT NULL AUTO_INCREMENT,
    `uuid`        varchar(80)  DEFAULT NULL,
    `hitokoto`    varchar(200) DEFAULT NULL,
    `type`        varchar(5)   DEFAULT NULL,
    `from`        varchar(50)  DEFAULT NULL,
    `from_who`    varchar(20)  DEFAULT NULL,
    `creator`     varchar(20)  DEFAULT NULL,
    `creator_uid` int          DEFAULT NULL,
    `reviewer`    int          DEFAULT NULL,
    `commit_from` varchar(20)  DEFAULT NULL,
    `created_at`  varchar(20)  DEFAULT NULL,
    `length`      int          DEFAULT NULL,
    `deleted`     int          DEFAULT 0,
    `create_time` datetime     DEFAULT NULL,
    `update_time` datetime     DEFAULT NULL,
    `version`     int          DEFAULT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS weather_sub
(
    id       int auto_increment primary key,
    location varchar(10) not null comment '订阅的城市',
    email    varchar(30) not null comment '邮箱'
) comment '天气订阅表';

CREATE TABLE IF NOT EXISTS daily_log
(
    id          BIGINT auto_increment      NOT NULL,
    url         varchar(700)               NOT NULL COMMENT '签到的url',
    tenant      TINYINT UNSIGNED DEFAULT 0 NOT NULL COMMENT '租户 1, moli',
    create_time DATETIME                   NOT NULL COMMENT '创建时间',
    `type`      TINYINT UNSIGNED           NOT NULL COMMENT '类型 1 网址 2 other',
    CONSTRAINT daily_log_PK PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS device
(
    id         int auto_increment
        primary key,
    token      varchar(300) null,
    name       varchar(10)  null comment '设备名称',
    model      varchar(30)  null comment '设备型号',
    android_id varchar(60)  null comment '安卓Id'
);

CREATE TABLE IF NOT EXISTS push_log
(
    id          int auto_increment,
    type        int                not null comment '1 mail,2 app,3 server',
    title       varchar(100)       not null,
    body        varchar(3000)      null,
    receive     varchar(300)       not null comment 'device token or topic or toEmail',
    status      tinyint  default 0 not null comment '0 初始化，1已推送， 2失败',
    create_time datetime           null,
    update_time datetime default null,
    constraint push_log_pk
        primary key (id)
) comment '推送日志记录表';

CREATE TABLE IF NOT EXISTS netease_music_song
(
    id       int auto_increment NOT NULL,
    third_id bigint             null,
    name     varchar(50)        NOT NULL,
    album_id int                null comment '专辑Id',
    playlist_id int          null comment '歌单id',
    CONSTRAINT netease_music_music_PK PRIMARY KEY (id)
) COMMENT ='歌曲';

CREATE TABLE IF NOT EXISTS netease_music_playlist
(
    id          int auto_increment NOT NULL,
    third_id    bigint,
    name        varchar(100)       NOT NULL COMMENT '名称',
    user_id     varchar(100)       NOT NULL COMMENT '用户Id',
    description varchar(500)       NOT NULL,
    create_time TIMESTAMP          NULL,
    update_time TIMESTAMP          NULL,
    CONSTRAINT netease_music_playlist_PK PRIMARY KEY (id)
) COMMENT ='歌单';

CREATE TABLE if not exists netease_music_user
(
    id             int auto_increment NOT NULL,
    third_id       bigint             NULL,
    avatar_url     varchar(500)       NULL,
    city           int                NULL,
    birthday       bigint             NULL,
    nickname       varchar(100)       NULL,
    background_img varchar(500)       NULL,
    CONSTRAINT netease_music_user_PK PRIMARY KEY (id)
);

CREATE TABLE if not exists netease_music_song_user
(
    id      int auto_increment NOT NULL,
    user_id int                NULL,
    song_id int                NULL,
    CONSTRAINT netease_music_song_user_PK PRIMARY KEY (id)
);


create table if not exists netease_music_album
(
    id           int auto_increment,
    third_id     bigint       null comment '第三方平台id',
    name         varchar(200) null comment '专辑名称',
    pic_url      varchar(500) null comment '专辑图片',
    type         varchar(20)  null comment '类型',
    publish_time timestamp    null comment '发布时间',
    user_id      int          null,
    constraint netease_music_album_pk
        primary key (id)
) comment '专辑';

create table if not exists api_user
(
    id          int auto_increment,
    name        varchar(30) null,
    password    varchar(60) null,
    create_time timestamp   null,
    update_time timestamp   null,
    constraint user_pk
        primary key (id)
);

create table if not exists bili_fav
(
    id          int                      not null
        primary key,
    fid         int                      not null,
    mid         int                      not null comment '用户',
    title       varchar(20)              null comment '收藏夹名称',
    type        int                      null comment '类型',
    media_count int                      null comment '个数',
    cover       varchar(500)             null comment '封面图',
    intro       varchar(3000)            null comment '简介',
    ctime       int                      null comment '创建时间',
    mtime       int                      null,
    only_audio  int unsigned default '0' not null,
    constraint bili_fav_fid_uindex
        unique (fid),
    constraint bili_fav_fid_uindex_2
        unique (fid),
    constraint bili_fav_id_uindex
        unique (id)
)
    comment
        '收藏夹' row_format = DYNAMIC;

create table if not exists bili_media
(
    id              bigint                      not null
        primary key,
    type            int                      null,
    title           varchar(150)             null comment '标题',
    cover           varchar(500)             null comment '封面图',
    intro           varchar(3000)            null comment '简介',
    page            int                      null comment '分P数',
    mid             int                      null comment '用户',
    ctime           int                      null comment '创建时间',
    pubtime         int                      null comment '发布时间',
    fav_time        int                      null comment '收藏时间',
    bv_id           varchar(12)              null,
    down            int          default 0   not null,
    upload          int          default 0   not null,
    invalid_push    int          default 0   not null,
    onedrive_upload int          default 0   not null,
    only_audio      int unsigned default '0' not null,
    fav_id          int                      null,
    constraint bili_media_bv_id_uindex
        unique (bv_id),
    constraint bili_media_id_uindex
        unique (id)
) row_format = DYNAMIC;

create table if not exists bili_user
(
    id   int         not null
        primary key,
    name varchar(30) null comment '昵称',
    face varchar(80) null,
    constraint bili_user_id_uindex
        unique (id)
) row_format = DYNAMIC;

CREATE TABLE if not exists `config`
(
    id            INT auto_increment not null,
    `key`         varchar(100)       NOT NULL COMMENT '配置的key',
    `value`       varchar(500) COMMENT '配置的值',
    `create_time` datetime           NOT NULL COMMENT '创建时间',
    `update_time` datetime           NOT NULL COMMENT '更新时间',
    primary key (`id`),
    constraint config_uindex
        unique (`key`)
);
