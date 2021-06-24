#!/bin/bash                                                                                                  
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
echo -e "正在安装依赖: Docker "
echo y | bash <(curl -L -s https://raw.githubusercontent.com/Baiyuetribe/codes/master/docker.sh) > /dev/null

		docker run --name nginx-mtproxy -d  -p 80:80 -p 8443:8443 ellermister/nginx-mtproxy:latest
        docker update --restart=always nginx-mtproxy
        docker logs nginx-mtproxy

