FROM registry.docker-cn.com/library/nginx:alpine

MAINTAINER jie <2273828010@qq.com>

RUN set -xe \
  && echo http://mirrors.aliyun.com/alpine/v3.7/main > /etc/apk/repositories \
  && echo http://mirrors.aliyun.com/alpine/v3.7/community >> /etc/apk/repositories \
  && apk add --update tzdata \
  && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" >  /etc/timezone \

  && mkdir /htdocs /logs

WORKDIR /htdocs
VOLUME /htdocs

# 端口号配置
EXPOSE 80

# 容器命令执行
ENTRYPOINT ["nginx", "-g", "daemon off;"]