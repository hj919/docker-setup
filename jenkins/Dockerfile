FROM registry.docker-cn.com/library/jenkins:alpine
USER root
RUN set -xe \
    && echo http://mirrors.aliyun.com/alpine/v3.7/main > /etc/apk/repositories \
    && echo http://mirrors.aliyun.com/alpine/v3.7/community >> /etc/apk/repositories \
    && apk add --update rsync tzdata \
    && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" >  /etc/timezone \
USER jenkins