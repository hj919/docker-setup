FROM nginx:alpine

RUN echo 'http://mirrors.aliyun.com/alpine/v3.6/main' > /etc/apk/repositories
RUN echo '@community http://mirrors.aliyun.com/alpine/v3.6/community' >> /etc/apk/repositories


RUN mkdir /htdocs /logs

WORKDIR /htdocs
VOLUME /htdocs

# 端口号配置
EXPOSE 80

# 容器命令执行
ENTRYPOINT ["nginx", "-g", "daemon off;"]