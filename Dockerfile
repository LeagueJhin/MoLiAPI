# 基础镜像
FROM openjdk:17-jdk-alpine

# 作者信息
MAINTAINER  BingChunMoLi <bingchunmoli@foxmail.com>

# 添加一个存储空间
VOLUME ~/.api/

# 暴露8090端口
EXPOSE 8090

# 往容器中添加jar包
ADD /target/moliapi.jar ~/.api/app.jar

# 启动镜像自动运行程序
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/urandom","-jar","~/.api/app.jar"]