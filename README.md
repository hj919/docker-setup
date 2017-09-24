# 开始使用

* `git clone`
* 执行命令 `sudo ./init.sh [nginx mysql redis gogs jenkins 应用名称（英文）]`可同时使用多个参数，不分顺序，根据参数起对应的容器；重新起容器，需删除各应用目录里的locked文件；
* 应用项目的配置变更,运行 `sudo ./init.sh 应用名称` 即可生效；
* open http://xxx.dev/

# 目录结构说明
|- apps 各应用的存放目录
  |-deault 默认应用
    |-htdocs 应用代码存放
    |-phpfpm.conf 容器phpfpm环境配置文件
    |-vhost.conf  nginx虚拟服务器配置文件
|- mysql
|- nginx 
|- phpfpm
|- redis
|- gogs
|- jenkins