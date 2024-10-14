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
    `end_date_en` varchar(30) default null comment '结束时间国际版',
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
    id       int not null auto_increment primary key,
    location varchar(10) not null comment '订阅的城市',
    email    varchar(30) not null comment '邮箱'
)
    comment '天气订阅表';

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
)
    comment '推送日志记录表';

CREATE TABLE IF NOT EXISTS netease_music_song
(
    id   int auto_increment NOT NULL,
    third_id bigint null,
    name varchar(50)        NOT NULL,
    album_id int    null comment '专辑Id',
    playlist_id int          null comment '歌单id',
    CONSTRAINT netease_music_music_PK PRIMARY KEY (id)
) COMMENT ='歌曲';

CREATE TABLE IF NOT EXISTS netease_music_playlist
(
    id          int auto_increment NOT NULL,
    third_id bigint,
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
)
    comment '专辑';

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
    comment '收藏夹' row_format = DYNAMIC;

create table if not exists bili_media
(
    id              bigint                      not null
        primary key,
    type            int                      null,
    title varchar(150) null comment '标题',
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
)
    row_format = DYNAMIC;

create table if not exists bili_user
(
    id int not null
        primary key,
    name varchar(30) null comment '昵称',
    face varchar(80) null,
    constraint bili_user_id_uindex
        unique (id)
)
    row_format = DYNAMIC;

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

INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (1, '9818ecda-9cbf-4f2a-9af8-8136ef39cfcd', '与众不同的生活方式很累人呢，因为找不到借口。', 'a', '幸运星', null, '跳舞的果果', 0, 0, 'web', '1468605909', 22, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (2, '4e71bc61-9f2e-49e1-a62f-d4b8ad9716c6', '面对就好，去经历就好。', 'a', '花伞菌', null, 'umbrella', 0, 0, 'web', '1468605909', 11, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (3, '8ea19537-2bae-4f64-8296-b8f1eed8006a', '将愿望倾入不愿忘却的回忆中……', 'a', 'ef-a tale of memories', null, 'lqsasa', 0, 0, 'web', '1468605909', 15, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (4, 'a2a6645b-a631-4a7c-a5c3-d835e4775c17', '美好的人眼里映出的世界也是美好的。', 'a', 'ARIA', null, 'misaki', 0, 0, 'web', '1468605909', 17, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (5, '1905d15f-9ade-454f-8478-3b169c8dee61', '看似美好的东西，往往藏着陷阱。', 'a', '只有神知道的世界', null, '紫月岚', 0, 0, 'web', '1468605909', 15, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (7, 'f0ae41d9-25ab-4960-9506-22171dcd1504', '恋ではなく、爱でもなく、もっとずっと 深く重い。', 'a', 'sweet   pool', null, '占星术杀人魔法', 0, 0, 'web', '1468605909', 24, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (8, '3b2e6049-5dca-4cfe-9b4a-f16b6db17c38', '花开花落，再灿烂的星光也会消失。', 'a', '圣斗士星矢', null, '水幻之音', 0, 0, 'web', '1468605909', 16, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (10, 'aa833615-6333-439c-8ca3-1a067e884d58', '我是一个经常笑的人，可我不是经常开心的人。', 'a', '未闻花名', null, 'Sai', 0, 0, 'web', '1468605909', 21, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (11, '27f3fd8b-53c6-4976-b6ad-1d56653d9a03', '努力是不会背叛自己的，虽然梦想有时会背叛自己。', 'a', '我的青春恋爱物语果然有问题', null, '百花残', 0, 0, 'web', '1468605909', 23, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (12, '21876029-7f74-4d10-86d8-70c724248f5d', '人经历风浪是会变得更强，可是船不同，日积月累的只有伤痛。', 'a', '海贼王', null, 'Jonse', 0, 0, 'web', '1468605909', 28, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (13, '1c496696-7d7c-4dde-b8be-3a71cea020ab', '真相只有一个！', 'a', '柯南', null, 'freejishu', 1, 0, 'web', '1468605909', 7, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (14, 'd862941f-5404-45c8-84fa-aa97eb9db92d', '用你的笑容去改变这个世界，别让这个世界改变了你的笑容。', 'a', '网络', null, '酱七', 0, 0, 'web', '1468605909', 27, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (15, 'a4c37812-1fff-4d66-98c1-1b5ecf687e1e', '我有在反省，但我不后悔。', 'a', '物语系列', null, 'billykingzero', 0, 0, 'web', '1468605909', 12, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (16, '489cf466-ef41-4ea3-b26f-bf454a02efbb', '我没有梦想，但是我能保护！', 'a', '假面骑士555', null, '魅影陌客', 0, 0, 'web', '1468605909', 13, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (17, 'c893e847-d381-4d3e-93ae-60292fab099a', '或许只需一滴露水，便能守护这绽放的花朵。', 'a', '反叛的鲁鲁修', null, '夜夜天天', 0, 0, 'web', '1468605909', 20, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (18, '5632f221-4e22-43c0-a90a-ef8581b8e27b', '我不会让任何人看到我软弱的一面。', 'a', '桔梗', null, '星之彼岸', 0, 0, 'web', '1468605909', 16, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (19, '48fd5061-dc77-419c-8beb-b96d71f930ff', '当你想做一件事，却无能为力的时候，是最痛苦的。', 'a', '高达SEED', null, '矢野加奈', 0, 0, 'web', '1468605909', 23, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (20, 'd05ae153-c17d-4546-8ccb-347bead06b0a', '我的腿让我停下，可是心却不允许我那么做。', 'a', '钢之炼金术师', null, 'Sakamoto', 0, 0, 'web', '1468605909', 20, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (23, '3e9dd0cc-09ee-4e63-b124-1f39d2d25a23', '像平常的你一样引发奇迹吧-', 'a', '魔法少女小圆', null, 'ludk60', 0, 0, 'web', '1468605909', 13, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (26, '1ef0d1da-caec-4ac8-9c26-77f746768a9d', '所谓的言语，只有当对方听进去了才开始有意义啊。', 'a', '少年同盟', null, 'alwaysandforever', 0, 0, 'web', '1468605909', 23, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (28, '93b00707-8bb0-4195-8734-56d11f5d055e', '世界上没有一个人能代替另一个人。', 'a', '人型电脑天使心', null, '夏红莲', 0, 0, 'web', '1468605909', 16, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (29, 'e25a1053-e704-4e1b-ac94-f35455137986', '其实，恋爱这种东西，当你看上人家的那一刹那就已经失败了。', 'a', '秋之回忆', null, 'LT2142', 0, 0, 'web', '1468605909', 28, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (30, '567f12b2-7bf6-4fb1-8fdd-c62e7e06b575', '隐约雷鸣，阴霾天空，即使天无雨，我亦留此地。', 'a', '言叶之庭', null, '_____丶X。', 0, 0, 'web', '1468605909', 22, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (31, '655acf6f-0b90-4284-a288-d197fb2f8a0f', '就是因为你不好，才要留在你身边，给你幸福。', 'a', '哈尔的移动城堡', null, '空城”旧梦', 0, 0, 'web', '1468605909', 21, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (33, '4bbcb914-700e-4d3c-97d9-f8d69ad7bd96', '少罗嗦，你还不如虫子呢！', 'a', '迷糊餐厅', null, '萌朧意識', 0, 0, 'web', '1468605909', 12, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (34, '5fba6915-a24a-4161-bc64-4913bc06079e', '别人恋爱不成功，你连暗恋都不成功！', 'a', '灌篮高手', null, 'Sai', 0, 0, 'web', '1468605909', 17, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (35, 'b74864ef-0e60-406b-acd9-303481ae2b03', '就算只有六十亿分之一的机会，我们还是会邂逅。', 'a', 'Angel Beats!', null, '灼思', 0, 0, 'web', '1468605909', 22, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (36, '37520fbc-6e95-4e8e-9ed1-9c73dcf003ad', '魔装少女就是本少爷！', 'a', '这是僵尸吗？', null, '零之幻想', 0, 0, 'web', '1468605909', 10, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (38, 'c1f4c762-e670-4f3e-8da9-ce93e9438cc8', '勇气，就是即便害怕也会去做。', 'a', '原创', null, '岛音。', 0, 0, 'web', '1468605909', 14, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (39, '75f3383f-b59c-4ce8-a11f-ef07fbf0933f', '如果我不会飞，那我就只是一只普通的猪。', 'a', '红猪', null, 'anythink', 0, 0, 'web', '1468605909', 19, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (40, '518bdda0-764a-46e4-91ee-12e9613f422b', '要相信同伴，拯救同伴。', 'a', '绯弹的亚里亚', null, '星野望', 0, 0, 'web', '1468605909', 11, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (42, 'cc752734-613e-4793-8ce2-133995bded8b', '男人许下的诺言就一定要遵守。', 'a', '海贼王', null, '南瓜酱', 0, 0, 'web', '1468605909', 14, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (43, 'b19aef69-c816-47db-9f61-136b3a42f800', '那是，未满45秒的邂逅。', 'a', 'EF', null, 'Mion', 0, 0, 'web', '1468605909', 12, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (44, '2056fc13-c2e4-471e-afbe-63e009179f65', '只要有想见面的人，自己就不再是孤单一人。', 'a', '夏目友人帐', null, '夜雨寒', 2638, 0, 'web', '1468605909', 20, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (46, '7ade5f7b-a3a6-40af-9121-fbd614ee1617', '廉价的自尊、粗劣的傲气，无论哪个后生小辈都很重视这些东西。', 'a', '狼与香辛料', null, '立花纹', 0, 0, 'web', '1468605909', 29, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (48, '74298760-a2d5-40d7-872e-c6ed33d7e869', '一个人吃饭，太寂寞了。', 'a', '无头骑士异闻录', null, '世风', 0, 0, 'web', '1468605909', 11, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (49, '61fa23b3-20bb-4d05-96e7-5329ae79ee59', '欺骗世界，欺骗最初的你。', 'a', 'Steins;Gate', null, '南都夜夜', 0, 0, 'web', '1468605909', 12, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (50, '2c7c30dc-64ff-4f4f-a7db-96b0b7391524', '(」・ω・)」うー！(／・ω・)／にゃー！', 'a', '潜行吧奈亚子', null, '繋がれた愚者', 0, 0, 'web', '1468605909', 21, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (51, '4a91c264-b984-406d-a0b7-f4543230f566', '世界上没有偶然，有的只是必然。', 'a', 'XXXHolic', null, '279120482', 0, 0, 'web', '1468605909', 15, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (52, 'd13432b7-c963-4c27-86be-26d8e6b2168d', '从小好女色的男人的想像力比不上狗。', 'a', '寒蝉鸣泣之时', null, 'Sai', 0, 0, 'web', '1468605909', 17, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (53, 'f5cd3ad0-cadb-4d69-8863-cae3f9c62dc7', '你愿意陪我走到地狱的底端吗？', 'a', '魔法禁书目录', null, 'icecai123', 0, 0, 'web', '1468605909', 14, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (54, 'ebeb01ab-2c58-4422-b302-3755c484ebb8', '错的不是我， 错的是世界。', 'a', 'School Day', null, '雪丶风', 0, 0, 'web', '1468605909', 13, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (56, '69a12c25-31f4-4fea-a196-3dac120253b0', '即使如此，我也有我想保护的世界！', 'a', '高达seed', null, '幻、天使', 0, 0, 'web', '1468605909', 16, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (57, '675b1acd-4616-44d8-b209-fa58eba7423c', '我很好奇！', 'a', '冰菓', null, '久野原', 0, 0, 'web', '1468605909', 5, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (59, '3c967e49-a7f4-4fca-98e6-f7a40c717650', '我是要成为海贼王的男人！', 'a', '海贼王', null, 'Sai', 0, 0, 'web', '1468605909', 12, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (61, '06707ada-c168-43c6-a728-1b348c2e6598', '忘记本身就是一件不可能的事。', 'a', '我们的存在', null, 'Sai', 0, 0, 'web', '1468605909', 14, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (62, 'ae378708-b121-4434-8a04-4209f487615a', '我们的夏天仍未结束。', 'a', '王牌投手', null, '新月', 0, 0, 'web', '1468605909', 10, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (63, '19d576ea-b602-43a1-ae78-72341c5770d9', '雨，何时停？', 'a', '秋之回忆', null, 'LT2142', 0, 0, 'web', '1468605909', 6, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (64, '6d0c9f38-ec2c-4ce9-9c74-6f92c172ece5', '在走廊上跌倒会流鼻血，在人生中跌倒会流眼泪。', 'a', '龙虎斗', null, '雪白封印', 0, 0, 'web', '1468605909', 22, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (65, '34d77457-a762-415b-8c33-0dd8a177f65c', '有被杀的觉悟，才有资格开枪。', 'a', '反叛的鲁路修', null, 'SweatHeart', 0, 0, 'web', '1468605909', 14, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (66, 'a11fa441-7869-4172-b919-8fb2938e6b17', '已经无法回到过去了。也不知道将来会是什么模样。', 'a', '文学少女', null, '万至阳', 0, 0, 'web', '1468605909', 23, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (67, '5bc511f9-df6a-4705-b40d-880a015eacde', '不要哀求，学会争取；若是如此，终有所获。', 'a', '交响诗篇', null, '空色の风琴', 0, 0, 'web', '1468605909', 20, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (68, '64d0aab9-5fe4-4534-8055-452d64530fa6', 'リア充死ね！', 'a', '我的朋友很少', null, 'ryo', 1482, 0, 'web', '1468605909', 6, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (69, '62853b17-cb51-4fc5-baf6-811c97469b45', '拿着刀并且可以让人们变得幸福的只有料理人。', 'a', '假面骑士kabuto', null, 'アリス', 0, 0, 'web', '1468605909', 21, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (71, 'fffc59c6-f5d4-482d-9c2f-7dc5a330209b', '越是试着忘记，越是记得深刻。', 'a', '天空之城', null, 'anythink', 0, 0, 'web', '1468605909', 14, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (72, 'ad0639fb-d48c-49df-be24-a5d41dfa241c', '喜欢上你，爱上你，真是太好了，谢谢。', 'a', '龙虎斗', null, 'xiaozhusirs', 0, 0, 'web', '1468605909', 18, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (75, 'f9ac75d1-85b3-44b6-bf35-d93cf60f40c7', '若隐若现才是艺术！', 'a', '问题儿童来自异世界', null, '言叶', 0, 0, 'web', '1468605909', 9, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (76, 'f6c46ab8-602c-4fe8-ab8c-e6306605c3ed', '我想要握紧的并不是匕首或是什么，只不过是他的掌心而已。', 'a', '空之境界', null, '万事屋神乐酱', 0, 0, 'web', '1468605909', 27, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (77, '9ba7fda0-1912-4d67-8d49-331893b81ac3', '下一次重逢，将是何年何月？天空必将见证。', 'a', 'SOLA', null, '掌中tiger', 0, 0, 'web', '1468605909', 20, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (78, '3e3995d7-2c4a-4104-8744-76031d252d25', '就连一直都无容身之地的我……也不是可以任意舍弃的生命。', 'a', '夏目友人帐', null, 'Sai', 0, 0, 'web', '1468605909', 27, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (79, 'f6aa4116-5a0f-4ab0-807a-bf3838a5fd23', '所以，他们的祭典还没结束。', 'a', '我的青春恋爱物语果然有问题', null, '阿布碳。', 0, 0, 'web', '1468605909', 13, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (80, '64723500-dd8b-4d66-abd0-b12f4ec94e30', '比自己，比梦想更重要的东西永远都存在着...', 'a', '钢之炼金术师', null, 'hccs', 0, 0, 'web', '1468605909', 22, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (82, '2ed6c1f4-8b58-498a-aac6-fadf41bcd5d6', '煩い！煩い！煩い！', 'a', '灼眼的夏娜', null, 'yeyifangg', 0, 0, 'web', '1468605909', 9, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (83, 'bc57394d-172d-453b-a96f-00fce7b53d5e', '重要的是无论我们选择哪条路，都要担负起选择的责任。', 'a', '蜂蜜与四叶草', null, 'funkyholic', 0, 0, 'web', '1468605909', 25, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (84, '43a0bbc2-3b94-48bb-9c7f-76a8a84b1f0f', '因为无法再见面，所以要笑着说再见。', 'a', 'AIR', null, 'Sai', 0, 0, 'web', '1468605909', 17, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (85, 'ad660068-57eb-4c10-9c95-c067107829f2', '无论乌云有多浓厚，星星也一定还在，只是暂时看不到了而已。', 'a', '电波女与青春男', null, '电波吧L君', 0, 0, 'web', '1468605909', 28, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (88, 'a682339d-b791-4e9f-b8d9-e0cdb964122a', '你不会死的，因为我会保护你.', 'a', 'EVA', null, '绤谷少年。', 0, 0, 'web', '1468605909', 14, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (92, '79b0ca81-d5ef-4825-b4d6-64dd2dac6345', '胜而不灭，霸而不辱，这才是真正的征服。', 'a', 'fate zero', null, '以风之名', 0, 0, 'web', '1468605909', 19, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (93, '7f8f2c32-22c0-4fb3-91e0-eb0cf4a5100a', '我相信十年后的八月，我们还能再相遇。', 'a', 'secret base ～君がくれたもの～', null, 'ツ绯/D誓言↙', 0, 0, 'web', '1468605909', 18, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (94, 'c6a6e894-1c98-4f36-b241-5076b6d124ba', '相信十年后的八月，我们还会相遇。', 'a', '未闻花名', null, 'Sai', 0, 0, 'web', '1468605909', 16, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (95, 'fcae356a-9ac1-477a-b523-3d528bb3beea', '你的心可以属于耶稣，但你的屁股永远属于陆战队！', 'a', '魔法少女陆战队', null, 'jordan2004a', 0, 0, 'web', '1468605909', 23, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (97, '4fee5af0-2e54-496c-9399-75cc0cbe70d1', '我们走过风走过雨，就是没能走进彼此的内心。', 'a', '自分', null, '漠伦', 0, 0, 'web', '1468605909', 21, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (98, 'a8808f16-1688-44df-9841-102ce9775f8d', '烦恼这东西，是只有活着的人，才有的特权哦。', 'a', '我们的存在', null, '伊达樱', 0, 0, 'web', '1468605909', 21, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (99, '155654de-02dd-48fb-b39b-ca016cdf3934', '当朋友是不需要什么资格的。', 'a', '全职猎人', null, '绤谷少年。', 0, 0, 'web', '1468605909', 13, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (100, '3ad880e4-995e-4972-aa78-ceb0369ed1dc', '年华无多时，恋爱吧男子！', 'a', '源君物语', null, '当希望破灭时__', 0, 0, 'web', '1468605909', 12, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (101, 'b213f024-fcff-4a7d-b57b-4fdb4fc23b77', '求你，保护那孩子，消除灾厄，抹除祸事。哪怕⋯⋯那是我自己……', 'a', '食灵', null, '游啊游の猪', 0, 0, 'web', '1468605909', 30, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (102, '4eaa7e07-0004-425b-9c5c-95bd4a417e3f', '如果你不能击败你的敌人，那么就加入他们。', 'a', '加菲猫', null, 'xi4oh4o', 0, 0, 'web', '1468605909', 20, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (104, '10b2e013-ff7b-4934-9979-ffdc3e847886', '我们所过的每个平凡的日常，也许就是连续发生的奇迹。', 'a', '日常', null, '桜花幻影', 0, 0, 'web', '1468605909', 25, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (106, '54bc6f77-2f80-4209-8f44-292d07533bc3', '倘若只是为了驱赶心中的寂寞，找谁都可以的。', 'a', '秒速5厘米', null, 'ggdog', 0, 0, 'web', '1468605909', 21, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (107, '00ae6650-3ae8-401f-927b-651a39564fb6', '即使从梦中醒来，还会有回忆留下。', 'a', 'AIR', null, 'Sai', 0, 0, 'web', '1468605909', 16, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (108, '5248f4e5-6e01-4750-9685-525951a68d94', '能够原谅女人的，才是男人。', 'a', '海贼王', null, '798750776', 0, 0, 'web', '1468605909', 13, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (109, '4ef69bfc-11b6-4541-bfa2-d800e47e3a47', '我会继续等着你，就算是一万二千年。', 'a', '创圣的大天使EVOL', null, '19920214', 0, 0, 'web', '1468605909', 17, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (111, '08f25fd6-d7e0-4a19-a0e6-98c89ceca1b6', '悲伤教会了我喜悦。', 'a', '秋之回忆', null, 'LT2142', 0, 0, 'web', '1468605909', 9, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (112, 'cdd89906-d679-4ba7-b848-f5540f552078', '我到底要以怎么样的速度生活才能与你再次相遇？', 'a', '秒速五厘米', null, '跳舞的果果', 0, 0, 'web', '1468605909', 22, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (113, 'd0e49a51-476b-4586-a4de-b88f99bb61ed', '我的船上没有手下，只有伙伴。', 'a', '海贼王', null, '明雪嫣', 0, 0, 'web', '1468605910', 14, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (114, '36235319-d821-49fe-ac5a-7d2048939e31', '就是因为抱有不现实的理想，所以才总是做出如此极端的事情！', 'a', '逆袭的夏亚', null, '言靈', 0, 0, 'web', '1468605910', 28, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (115, '69eec9df-5096-4b83-b9b7-51fc41267592', '要是因为烦恼很痛苦，就选择了轻松的选项，将来一定会后悔。', 'a', '樱花庄的宠物女孩', null, '青熊兽真烦人', 0, 0, 'web', '1468605910', 28, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (116, 'f9865621-6f35-4be2-a7d0-5b869fcaedc2', '呐，知道么，樱花飘落的速度，是每秒五厘米哦~', 'a', '秒速五厘米', null, '烤飞鱼的土豆', 0, 0, 'web', '1468605910', 22, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (117, '9432be2c-cbb4-4d38-8a26-06cdd542f72d', '知道活着的痛苦处的人就能对人温柔，这和软弱是不一样的。', 'a', 'eva', null, '林志广', 0, 0, 'web', '1468605910', 27, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (118, '8ada268b-6e37-47f7-9216-53dd8d84b864', '比起悲伤来说，无法分享快乐这件事，要更加的寂寞吧。', 'a', 'AIR', null, '林志广', 0, 0, 'web', '1468605910', 25, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (119, 'a9463f29-790d-42c5-8832-1691eef1ab74', '如果你执意追寻着我的幻影，总有一天会被真正的我打败。', 'a', '棋魂', null, '炎羽', 0, 0, 'web', '1468605910', 26, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (121, '9b834943-8908-40c8-9557-086496eac2cc', '你的那双手呢，是为了紧紧抓住什么而存在的哦。', 'a', '仰望半月的夜空', null, 'shijiongyuan', 0, 0, 'web', '1468605910', 22, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (122, '59e823b9-718d-4017-9311-c79255d9c9dc', '去死两次！', 'a', '迷途猫', null, 'Sai', 0, 0, 'web', '1468605910', 5, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (123, 'b5ea47f4-a332-410f-97d4-5609452f93dc', '世界は恋に落ちている。', 'a', '青春之旅OP（我的世界已坠入爱河）', null, '咖啡少年不加糖', 0, 0, 'web', '1468605910', 11, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (124, '29819f1c-c51d-4d8c-8c91-45069434356f', '自身不先改变的话，一切都不会改变。', 'a', '银魂', null, 'misora', 0, 0, 'web', '1468605910', 17, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (126, '346880cc-a317-4e2a-af37-cef2bb634910', '人生最糟糕的事，一个是饿肚子，一个是孤独。', 'a', '夏日大作战', null, '空城”旧梦', 0, 0, 'web', '1468605910', 21, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (127, '9d09511a-4bb5-4351-bb29-32e57494e3c4', '我不是萝莉控，是妹控啊！', 'a', '我的妹妹不可能那么可爱第二季', null, '梁钲恒', 0, 0, 'web', '1468605910', 12, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (128, 'bf8cd453-e6f9-4dc4-af2f-24b60f74f29a', '呐，我们好像是，被宇宙和地球拆散的恋人似的。', 'a', '星之声', null, 'yeyifangg', 0, 0, 'web', '1468605910', 22, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (129, '86e6245a-2559-4dda-8602-d4c2b3b1d8f0', '一天吐槽太多次的话，梗也是会用完的。', 'a', '我的脑内恋爱选项', null, 'hsk', 0, 0, 'web', '1468605910', 18, 0, null, null, null) ;
INSERT INTO yi_yan (id, uuid, hitokoto, type, `from`, from_who, creator, creator_uid, reviewer, commit_from, created_at, length, deleted, create_time, update_time, version) VALUES (131, '0e7926fc-f73f-44b8-ad09-0430a8f47764', '心，可是很重的。', 'a', '哈尔的移动城堡', null, 'fujiyta', 0, 0, 'web', '1468605910', 8, 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (1, '天阶夜色凉如水，卧看牵牛织女星。', '秋夕', '杜牧', '古诗文-天气-星星', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (2, '乃知兵者是凶器，圣人不得已而用之。', '战城南', '李白', '古诗文-人生-战争', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (3, '冬夜夜寒觉夜长，沉吟久坐坐北堂。', '夜坐吟', '李白', '古诗文-四季-冬天', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (4, '欲寻芳草去，惜与故人违。', '留别王侍御维 / 留别王维', '孟浩然', '古诗文-抒情-友情', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (5, '半夜呼儿趁晓耕，羸牛无力渐艰行。', '农家', '颜仁郁', '古诗文-人物-儿童', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (6, '自闻颖师弹，起坐在一旁。', '听颖师弹琴', '韩愈', '古诗文-人物-老师', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (7, '鹭窥芦箔水，鸟啄纸钱风。', '寒食郊行书事', '范成大', '古诗文-动物-写鸟', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (8, '昨梦西湖，老扁舟身世。', '拜星月慢·林钟羽姜石帚以盆莲数十置中庭宴客其中', '吴文英', '古诗文-山水-西湖', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (9, '啼莺舞燕，小桥流水飞红。', '天净沙·春', '白朴', '古诗文-生活-写桥', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (10, '两岸荔枝红，万家烟雨中。', '菩萨蛮·子规啼破城楼月', '李师中', '古诗文-食物-荔枝', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (11, '最是一年春好处，绝胜烟柳满皇都。', '早春呈水部张十八员外 / 初春小雨 / 早春', '韩愈', '古诗文-四季-春天', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (12, '儿童急走追黄蝶，飞入菜花无处寻。', '宿新市徐公店', '杨万里', '古诗文-人物-儿童', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (13, '可怜九月初三夜，露似真珠月似弓。', '暮江吟', '白居易', '古诗文-天气-月亮', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (14, '偶应非熊兆，尊为帝者师。', '题太公钓渭图', '刘基', '古诗文-人物-老师', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (15, '野火烧不尽，春风吹又生。', '草 / 赋得古原草送别', '白居易', '古诗文-天气-写风', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (16, '唤起封姨清晚景，更将荔子荐新圆。', '浣溪沙·中秋坐上十八客', '张孝祥', '古诗文-食物-荔枝', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (17, '记取西湖西畔，正暮山好处，空翠烟霏。', '八声甘州·寄参寥子', '苏轼', '古诗文-山水-西湖', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (18, '北风吹雪四更初，嘉瑞天教及岁除。', '除夜雪', '陆游', '古诗文-节日-春节', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (19, '惟有今宵，皓彩皆同普。', '醉落魄·丙寅中秋', '郭应祥', '古诗文-节日-中秋节', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (20, '别来半岁音书绝，一寸离肠千万结。', '应天长·别来半岁音书绝', '韦庄', '古诗文-抒情-爱情', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (21, '黯与山僧别，低头礼白云。', '秋浦歌十七首', '李白', '古诗文-抒情-离别', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (22, '人间万事，毫发常重泰山轻。', '水调歌头·壬子三山被召陈端仁给事饮饯席上作', '辛弃疾', '古诗文-山水-泰山', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (23, '出师未捷身先死，长使英雄泪满襟。', '蜀相', '杜甫', '古诗文-抒情-伤感', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (24, '窗间梅熟落蒂，墙下笋成出林。', '喜晴', '范成大', '古诗文-植物-梅花', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (25, '哀哀父母，生我劳瘁。', '蓼莪', '佚名', '古诗文-人物-父亲', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (26, '昨夜星辰昨夜风，画楼西畔桂堂东。', '无题·昨夜星辰昨夜风', '李商隐', '古诗文-天气-星星', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (27, '山际见来烟，竹中窥落日。', '山中杂诗', '吴均', '古诗文-天气-太阳', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (28, '蛾眉淡了教谁画？瘦岩岩羞戴石榴花。', '大德歌·夏', '关汉卿', '古诗文-四季-夏天', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (29, '故乡今夜思千里，霜鬓明朝又一年。', '除夜作', '高适', '古诗文-抒情-思乡', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (30, '岱宗夫如何？齐鲁青未了。', '望岳', '杜甫', '古诗文-山水-泰山', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (31, '三年遇寒食，尽在洛阳城。', '洛桥寒食日作十韵', '白居易', '古诗文-节日-寒食节', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (32, '昨夜江边春水生，艨艟巨舰一毛轻。', '活水亭观书有感二首·其二', '朱熹', '古诗文-四季-春天', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (33, '春还草阁梅先动，月满虚庭雪未消。', '元夕二首', '王守仁', '古诗文-植物-梅花', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (34, '是无猫邪，是不会蓄猫也。', '世无良猫', '乐钧', '古诗文-动物-写猫', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (35, '少妇今春意，良人昨夜情。', '杂诗三首·其三', '沈佺期', '古诗文-人物-女子', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (36, '无情最是台城柳，依旧烟笼十里堤。', '台城', '韦庄', '古诗文-抒情-怀古', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (37, '痴儿不知父子礼，叫怒索饭啼门东。', '百忧集行', '杜甫', '古诗文-人物-父亲', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (38, '黄鹤一去不复返，白云千载空悠悠。', '黄鹤楼 / 登黄鹤楼', '崔颢', '古诗文-天气-写云', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (39, '初惊河汉落，半洒云天里。', '望庐山瀑布水二首', '李白', '古诗文-山水-瀑布', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (40, '细草微风岸，危樯独夜舟。', '旅夜书怀', '杜甫', '古诗文-抒情-孤独', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (41, '夫死战场子在腹，妾身虽存如昼烛。', '征妇怨', '张籍', '古诗文-抒情-伤感', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (42, '小溪清水平如镜，一叶飞来浪细生。', '秋行', '徐玑', '古诗文-植物-叶子', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (43, '白下有山皆绕郭，清明无客不思家。', '清明呈馆中诸公', '高启', '古诗文-节日-清明节', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (44, '惆怅南朝事，长江独至今。', '秋日登吴公台上寺远眺', '刘长卿', '古诗文-山水-长江', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (45, '但愿人长久，千里共婵娟。', '水调歌头·丙辰中秋', '苏轼', '古诗文-节日-中秋节', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (46, '台高不尽看枫叶，院净何须坐菊花。', '九日登高台寺', '沈辂', '古诗文-植物-菊花', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (47, '莫嫌举世无知己，未有庸人不忌才。', '三闾祠', '查慎行', '古诗文-人生-励志', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (48, '今夜送归灯火冷，河塘，堕泪羊公却姓杨。', '南乡子·和杨元素时移守密州', '苏轼', '古诗文-抒情-离别', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (49, '借问酒家何处有？牧童遥指杏花村。', '清明', '杜牧', '古诗文-节日-清明节', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (50, '儿童散学归来早，忙趁东风放纸鸢。', '村居', '高鼎', '古诗文-人物-儿童', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (51, '香炉初上日，瀑水喷成虹。', '彭蠡湖中望庐山', '孟浩然', '古诗文-山水-瀑布', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (52, '山上层层桃李花，云间烟火是人家。', '竹枝词九首·其九', '刘禹锡', '古诗文-植物-桃花', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (53, '去年元夜时，花市灯如昼。', '生查子·元夕', '欧阳修', '古诗文-节日-元宵节', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (54, '共看明月应垂泪，一夜乡心五处同。', '望月有感', '白居易', '古诗文-抒情-思乡', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (55, '岸雨过城头，黄鹂上戍楼。', '武威春暮闻宇文判官西使还已到晋昌', '岑参', '古诗文-天气-写雨', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (56, '棠梨叶落胭脂色，荞麦花开白雪香。', '村行·马穿山径菊初黄', '王禹偁', '古诗文-生活-乡村', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (57, '风雨端阳生晦冥，汨罗无处吊英灵。', '已酉端午', '贝琼', '古诗文-节日-端午节', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (58, '屈子冤魂终古在，楚乡遗俗至今留。', '午日观竞渡', '边贡', '古诗文-节日-端午节', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (59, '寒日萧萧上琐窗，梧桐应恨夜来霜。', '鹧鸪天·寒日萧萧上琐窗', '李清照', '古诗文-天气-太阳', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (60, '世间珍果更无加，玉雪肌肤罩绛纱。', '咏荔枝', '丘浚', '古诗文-食物-荔枝', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (61, '东风有恨致玄都，吹破枝头玉，夜月梨花也相妒。', '小桃红·咏桃', '周文质', '古诗文-植物-梨花', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (62, '谢亭离别处，风景每生愁。', '谢公亭·盖谢脁范云之所游', '李白', '古诗文-抒情-离别', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (63, '中秋月。月到中秋偏皎洁。', '中秋月·中秋月', '徐有贞', '古诗文-天气-月亮', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (64, '留连光景惜朱颜，黄昏独倚阑。', '阮郎归·呈郑王十二弟', '李煜', '古诗文-人生-青春', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (65, '读书不觉已春深，一寸光阴一寸金。', '白鹿洞二首·其一', '王贞白', '古诗文-人生-读书', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (66, '报答春光知有处，应须美酒送生涯。', '江畔独步寻花七绝句', '杜甫', '古诗文-抒情-感恩', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (67, '朔风如解意，容易莫摧残。', '梅花', '崔道融', '古诗文-四季-冬天', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (68, '随风潜入夜，润物细无声。', '春夜喜雨', '杜甫', '古诗文-人物-老师', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (69, '小酌酒巡销永夜，大开口笑送残年。', '雪夜小饮赠梦得', '白居易', '古诗文-食物-写酒', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (70, '雨打梨花深闭门，忘了青春，误了青春。', '一剪梅·雨打梨花深闭门', '唐寅', '古诗文-植物-梨花', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (71, '绿衣监使守宫门，一闭上阳多少春。', '上阳白发人', '白居易', '古诗文-抒情-闺怨', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (72, '俯瞰黄河小，高悬白雪清。', '咏贺兰山', '胡秉正', '古诗文-山水-黄河', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (73, '孤花片叶，断送清秋节。', '清平乐·孤花片叶', '纳兰性德', '古诗文-抒情-离别', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (74, '曲终漏尽严具陈，月没星稀天下旦。', '鸡鸣歌', '佚名', '古诗文-天气-星星', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (75, '今夜不知何处宿，平沙万里绝人烟。', '碛中作', '岑参', '古诗文-生活-边塞', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (76, '美人卷珠帘，深坐颦蛾眉。', '怨情', '李白', '古诗文-人物-女子', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (77, '慈母手中线，游子身上衣。', '游子吟 / 迎母漂上作', '孟郊', '古诗文-人物-母亲', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (78, '竹色溪下绿，荷花镜里香。', '别储邕之剡中', '李白', '古诗文-植物-荷花', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (79, '庭前落尽梧桐，水边开彻芙蓉。', '天净沙·秋', '朱庭玉', '古诗文-植物-荷花', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (80, '对望中天地，洞然如刷。', '满江红·中秋夜潮', '史达祖', '古诗文-节日-中秋节', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (81, '桃李务青春，谁能贯白日。', '长歌行', '李白', '古诗文-人生-青春', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (82, '东风吹落战尘沙，梦想西湖处士家；', '观梅有感', '刘因', '古诗文-人生-梦想', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (83, '先生名利比尘灰，绿竹青松手自栽。', '咏归堂隐鳞洞', '王汝舟', '古诗文-植物-竹子', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (84, '出入君怀袖，动摇微风发。', '怨歌行', '班婕妤', '古诗文-抒情-爱情', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (85, '斑竹枝，斑竹枝，泪痕点点寄相思。', '潇湘神·斑竹枝', '刘禹锡', '古诗文-抒情-思念', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (86, '醉卧沙场君莫笑，古来征战几人回？', '凉州词二首·其一', '王翰', '古诗文-生活-边塞', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (87, '凭仗丹青重省识，盈盈，一片伤心画不成。', '南乡子·为亡妇题照', '纳兰性德', '古诗文-抒情-悼亡', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (88, '春山烟欲收，天淡星稀小。', '生查子·春山烟欲收', '牛希济', '古诗文-天气-星星', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (89, '朔风吹散三更雪，倩魂犹恋桃花月。', '菩萨蛮·朔风吹散三更雪', '纳兰性德', '古诗文-抒情-思念', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (90, '井放辘轳闲浸酒，笼开鹦鹉报煎茶。', '夏日题老将林亭', '张蠙', '古诗文-食物-写茶', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (91, '乌啼鹊噪昏乔木，清明寒食谁家哭。', '寒食野望吟', '白居易', '古诗文-节日-清明节', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (92, '吟怀未许老重阳，霜雪无端入鬓长。', '九日吴山宴集值雨次韵', '序灯', '古诗文-节日-重阳节', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (93, '白日放歌须纵酒，青春作伴好还乡。', '闻官军收河南河北', '杜甫', '古诗文-人生-青春', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (94, '青山朝别暮还见，嘶马出门思旧乡。', '送陈章甫', '李颀', '古诗文-抒情-思念', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (95, '行多有病住无粮，万里还乡未到乡。', '逢病军人', '卢纶', '古诗文-生活-边塞', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (96, '雪中何以赠君别，惟有青青松树枝。', '天山雪歌送萧治归京', '岑参', '古诗文-四季-冬天', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (97, '无边落木萧萧下，不尽长江滚滚来。', '登高', '杜甫', '古诗文-山水-长江', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (98, '江南几度梅花发，人在天涯鬓已斑。', '鹧鸪天·雪照山城玉指寒', '刘著', '古诗文-植物-梅花', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (99, '耕夫召募爱楼船，春草青青万项田；', '闾门即事', '张继', '古诗文-生活-田园', 0, null, null, null) ;
INSERT INTO shi_ci (id, content, origin, author, category, deleted, create_time, update_time, version) VALUES (100, '盛年不重来，一日难再晨。', '杂诗·人生无根蒂', '陶渊明', '古诗文-人生-青春', 0, null, null, null) ;
