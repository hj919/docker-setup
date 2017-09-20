FROM my/alpine
# 软件包安装
RUN apk --update add nginx

# 软件包参数配置
RUN mkdir /run/nginx
RUN mkdir /htdocs
RUN mkdir /logs

WORKDIR /htdocs
VOLUME /htdocs

# 端口号配置
EXPOSE 80

# 容器命令执行
ENTRYPOINT ["nginx", "-g", "daemon off;"]