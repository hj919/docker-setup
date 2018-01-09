FROM nginx:alpine

MAINTAINER jie <2273828010@qq.com>

RUN set -xe \
  && echo 'http://mirrors.aliyun.com/alpine/latest-stable/main' > /etc/apk/repositories \
  && echo '@community http://mirrors.aliyun.com/alpine/latest-stable/community' >> /etc/apk/repositories \
  && ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
  && echo "Asia/Shanghai" >  /etc/timezone \

  && mkdir /htdocs /logs

WORKDIR /htdocs
VOLUME /htdocs

# 端口号配置
EXPOSE 80

# 容器命令执行
ENTRYPOINT ["nginx", "-g", "daemon off;"]