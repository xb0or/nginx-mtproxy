#!/bin/bash                                                                                                  
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#check root
[ $(id -u) != "0" ] && { echo "错误: 您必须以root用户运行此脚本"; exit 1; }

# @安装docker
install_docker() {
    docker version > /dev/null || curl -fsSL get.docker.com | bash 
    service docker restart 
    systemctl enable docker  
}
install_docker_compose() {
	curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
}

# 单独检测docker是否安装，否则执行安装docker。
check_docker() {
	if [ -x "$(command -v docker)" ]; then
		echo "您的系统已安装docker"
		# command
	else
		echo "开始安装docker。。。"
		# command
		install_docker        
	fi
}
check_docker_compose() {
	if [ -x "$(command -v docker-compose)" ]; then
		echo "docker-compose is installed"
        echo -e "\033[32m====================================\033[0m"	
        echo -e "\033[32m 系统已存在Docker环境                        "
        echo -e "\033[32m====================================\033[0m"
	else
		echo "Install docker-compose"
		# command
		install_docker_compose
	fi
}



#开始菜单
start_menu(){
    clear
    echo -e "\033[32m====================================\033[0m"
    echo -e "\033[0;33m  即将开始安装Docker；否则按Ctrl+C退出 \033[0m"
    echo -e "\033[32m====================================\033[0m"
    echo
    read -p "是否继续？:" num
    case "$num" in   
    *)
	check_docker
    check_docker_compose
    echo -e "\033[32m====================================\033[0m"	
    echo -e "\033[32m 恭喜，您已经完成docker环境的安装                        "
    echo -e "\033[32m====================================\033[0m"	
	;;
    esac
}

start_menu
