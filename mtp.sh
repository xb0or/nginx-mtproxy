#!/bin/bash                                                                                                  
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

read -e -p "请输入链接端口(默认443) :" port
if [[ -z "${port}" ]]; then
port="443"
fi

read -e -p "请输入密码(默认随机生成) :" secret
if [[ -z "${secret}" ]]; then
secret=$(head -c 16 /dev/urandom | xxd -ps)
fi

read -e -p "请输入伪装域名(默认cloudflare.com) :" domain
if [[ -z "${domain}" ]]; then
domain="cloudflare.com"
fi
read -rp "你需要TAG标签吗(Y/N): " chrony_install
    [[ -z ${chrony_install} ]] && chrony_install="Y"
    case $chrony_install in
    [yY][eE][sS] | [yY])
        read -e -p "请输入TAG:" tag
        if [[ -z "${tag}" ]]; then
        echo "请输入TAG"
        fi
        echo -e "正在安装依赖: Docker... "
        echo y | bash <(curl -L -s https://cdn.jsdelivr.net/gh/xb0or/nginx-mtproxy@main/docker.sh)
        echo -e "正在安装nginx-mtproxy... "
        docker run --name nginx-mtproxy -d -e tag="$tag" -e secret="$secret" -e domain="$domain" -p 80:80 -p $port:$port ellermister/nginx-mtproxy:latest
        ;;
    *)
echo -e "正在安装依赖: Docker... "
echo y | bash <(curl -L -s https://cdn.jsdelivr.net/gh/xb0or/nginx-mtproxy@main/docker.sh)

echo -e "正在安装nginx-mtproxy... "
docker run --name nginx-mtproxy -d  -p 80:80 -p 8443:8443 ellermister/nginx-mtproxy:latest
        ;;
    esac



echo -e "正在设置开机自启动... "
docker update --restart=always nginx-mtproxy
echo -e "输入 docker logs nginx-mtproxy 获取链接信息";
