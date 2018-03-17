FROM php:alpine

MAINTAINER jie <2273828010@qq.com>

RUN set -xe \
  && echo 'http://mirrors.aliyun.com/alpine/latest-stable/main' > /etc/apk/repositories \
  && echo '@community http://mirrors.aliyun.com/alpine/latest-stable/community' >> /etc/apk/repositories \
  && apk add tzdata \
  && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" >  /etc/timezone \
  && docker-php-ext-install pcntl


CMD ["php","workerman/start.php","start"]