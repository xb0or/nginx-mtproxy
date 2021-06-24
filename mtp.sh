#!/bin/bash                                                                                                  
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

echo -e "正在安装依赖: Docker... ";
echo y | bash <(curl -L -s https://cdn.jsdelivr.net/gh/xb0or/nginx-mtproxy@main/docker.sh) > /dev/null;
echo -e "正在安装nginx-mtproxy... ";
docker run --name nginx-mtproxy -d  -p 80:80 -p 8443:8443 ellermister/nginx-mtproxy:latest > /dev/null;
echo -e "正在设置开机自启动... ";
docker update --restart=always nginx-mtproxy > /dev/null;
echo -e "输入 docker logs nginx-mtproxy 获取链接信息";
