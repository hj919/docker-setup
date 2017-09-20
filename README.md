# 开始使用
* 
* [可选]加入全局变量 `ln -s $PWD/init.sh /usr/local/bin/docker-setup`
* 执行命令 `sudo ./init.sh [参数]` 全局命令 `sudo docker-setup [参数]`
* 可用参数 redis mysql nginx 应用名称（英文），可同时使用多个参数，不分顺序，根据参数起对应的容器；重新起容器，需删除各应用目录里的locked文件；
* 项目的配置变更,运行 `sudo docker-setup xxx` 即可生效；
* open http://xxx.dev/
