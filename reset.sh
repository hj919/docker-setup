#!/bin/bash

# 一切清零,慎用！！！
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images -q)
