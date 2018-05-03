FROM registry.docker-cn.com/library/php:7.2-fpm-alpine3.7

MAINTAINER jie <2273828010@qq.com>

RUN set -xe \
  && echo http://mirrors.aliyun.com/alpine/v3.7/main > /etc/apk/repositories \
  && echo http://mirrors.aliyun.com/alpine/v3.7/community >> /etc/apk/repositories \
  && apk add --update --upgrade tzdata \
  && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo "Asia/Shanghai" >  /etc/timezone \
  && docker-php-ext-install pcntl


CMD ["php","workerman/start.php","start"]