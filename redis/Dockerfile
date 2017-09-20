FROM my/alpine

# 软件包安装

RUN apk --update add redis

RUN mkdir /data
VOLUME /data
WORKDIR /data

EXPOSE 6379

CMD ["redis-server","/etc/redis.conf"]