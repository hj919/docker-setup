#!/bin/bash

# 判断当前脚本所在的路径，支持软连接
SOURCE="$0"
while [ -h "$SOURCE"  ]; do 
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" 
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

# 创建基础镜像
base_image=$(docker images | grep my/alpine)
if [ ! -n "$base_image" ]
	then
		docker build -t my/alpine "$DIR"/alpine
fi

# 创建网络方法
function createNetwork(){
	# 如果网络不存在，则创建
	network=$(docker network ls | grep myNet)
	if [ ! -n "$network" ]
	then
		docker network create myNet
	fi
}

# 清除已存在的容器
function resetContainer(){
	if [  -n $1 ]
	then
		container=$(docker ps -a | grep $1)
		if [ -n "$container" ]
		then
			docker stop $1 && docker rm $1
		fi
	fi
}

# 创建应用方法
function createApp(){
	phpfpmImage=$(docker images | grep my/phpfpm)
	if [ ! -n "$phpfpmImage" ]
	then
		docker build -t my/phpfpm "$DIR"/phpfpm
	fi
	appName=$1
	if [ ! -n "$appName" ]
	then
		echo '请指定应用名称！'
		exit 1
	else
		resetContainer phpfpm-"$appName"
		docker run -d --name phpfpm-"$appName" --net=myNet \
		-v "$DIR"/apps/"$appName"/htdocs:/htdocs \
		-v "$DIR"/apps/"$appName"/server/conf/php.ini:/etc/php7/php.ini \
		-v "$DIR"/apps/"$appName"/server/conf/php-fpm.conf:/etc/php7/php-fpm.conf \
		-v "$DIR"/apps/"$appName"/server/conf/php-fpm.d/www.conf:/etc/php7/php-fpm.d/www.conf \
		-v "$DIR"/apps/"$appName"/server/logs:/logs \
		my/phpfpm
	fi
}

# 创建容器方法
function createContainer(){
	for arg in $@; do  
		if [ -f "$DIR"/${arg}/locked ]
		then
			continue
		fi
	case ${arg} in
   		'redis') 
			docker build -t my/redis "$DIR"/redis
			resetContainer redis
			docker run -d --name redis --net=myNet -v "$DIR"/redis/redis.conf:/etc/redis.conf my/redis
      		;;
      	'mysql') 
			docker pull mysql
			resetContainer mysql
			docker run -d --name mysql --net=myNet -v "$DIR"/mysql/data:/var/lib/mysql  -p 3306:3306 -e MYSQL_ROOT_PASSWORD=12346 mysql
      		;;
      	'nginx') 
			docker build -t my/nginx "$DIR"/nginx
			resetContainer nginx
			docker run -d --name nginx --net=myNet \
			-v "$DIR"/apps:/htdocs \
			-v "$DIR"/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
			-v "$DIR"/nginx/conf/conf.d/:/etc/nginx/conf.d \
			-v "$DIR"/nginx/logs:/logs \
			-p 80:80 my/nginx
      		;;
   		'gogs') 
      		# 安装版本控制服务器
			docker pull gogs/gogs
			resetContainer gogs
			mkdir -p "$DIR"/gogs
			# Use `docker run` for the first time.
			docker run  -d --name=gogs -p 10022:22 -p 10080:3000 -v "$DIR"/gogs:/data gogs/gogs
			# Use `docker start` if you have stopped it.
			#docker start gogs
      		;;
      	'jenkins') 
      		docker pull jenkins:alpine
      		resetContainer jenkins
			mkdir -p "$DIR"/jenkins
			docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v "$DIR"/jenkins:/var/jenkins_home -v "$DIR"/apps:/htdocs jenkins:alpine
      		;;
   		*) 
      		appPath="$DIR"/apps/${arg}
			if [ -d "$appPath" ]
			then
				createApp ${arg}
				vhostConf="$DIR"/apps/${arg}/server/conf/vhost.conf
				if [ -f "$vhostConf" ]
				then
					cp -f "$vhostConf" "$DIR"/nginx/conf/conf.d/${arg}.conf
					serverName=$(cat "$vhostConf" | grep server_name |  head -1 | tr -s ' ' | cut -d ' ' -f3 | tr -d ';')

					#添加 serverName 至 host文件
					hostContent=$(cat /etc/hosts |grep "$serverName")
					if [ ! -n "$hostContent" ]
					then
						echo 127.0.0.1 "$serverName" >> /etc/hosts
					fi

					docker restart nginx
				fi
			else
				exit 1
			fi
      		;;
	esac 
	if [ -d "$DIR"/${arg} ]
	then
		touch "$DIR"/${arg}/locked
	fi
	done  
}

createContainer $@

