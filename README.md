# [MoLiAPI](https://api.bingchunmoli.com)

![](https://badgen.net/github/release/bingchunmoli/MoLiApi/stable)
![](https://badgen.net/github/prs/bingchunmoli/MoLiApi)
![](https://badgen.net/github/commits/bingchunmoli/MoLiApi)
![](https://badgen.net/github/releases/bingchunmoli/MoLiApi)
![](https://badgen.net/github/license/bingchunmoli/MoLiApi)
[![Java CI with Maven](https://github.com/BingChunMoLi/MoLiAPI/actions/workflows/maven.yml/badge.svg?event=branch_protection_rule)](https://github.com/BingChunMoLi/MoLiAPI/actions/workflows/maven.yml)

## 快速开始:
```shell
docker run -d --name api -p 8090:8090 -v /.api/:/soft/config/ bingchunmoli/moliapi:latest
```
or
```shell
java -jar -Dspring.profiles.active=h2 moliapi.jar
```

docker-compose:
```shell
docker-compose up -d
```

## 已支持接口:
1. Bing美图
2. emoji表情处理
3. 公网IP查询
4. UserAgent解析
5. 二维码处理
6. 随机诗词或指定
7. 随机一言或制定
8. QQ头像获取(支持多种方式)
9. QQ空间头像获取(支持多种方式)
10. 天气查询
11. Hosts订阅
12. 随机图
13. 迅雷链接转换
14. 每日签到网址
15. 自动更新腾讯CDN证书(定时任务, 暂仅支持单域名,如需多域名请提Iss)
16. 网易云音乐歌单收藏
17. b站收藏获取,通知失效视频

## 后台管理功能
1. 签到
2. 签到日志查询
3. 随机music
4. 歌单歌曲

## 启用所有功能
1. 添加配置文件(~/.api/目录下) application.yml
2. 下载application-template.yml 并修改文件名为application-default.yml
3. 完善application-default.yml配置
