#获取容器id
ID=$(docker ps -f name=nginx-mtproxy --quiet)
#获取在宿主机的绝对目录
list=$(docker inspect --format='{{.GraphDriver.Data.MergedDir}}' $ID)/etc/nginx/ip_white.conf
echo -e '当前白名单IP：'
cat -n "$list"
echo -e '\n'

echo && echo -e "欢迎使用白名单MTP管理脚本
1.添加白名单IP
2.删除白名单IP
3.清空白名单" && echo
	read -e -p "(默认: 取消):" bk_modify
	[[ -z "${bk_modify}" ]] && echo "已取消..." && exit 1
	if [[ ${bk_modify} == "1" ]]; then
               read -e -p "请输入要添加白名单的IP :" IP
               echo $IP 1';' >> $list
			   echo -e '当前白名单IP：'
               cat -n "$list"
	elif [[ ${bk_modify} == "2" ]]; then
               read -e -p "请输入要删除白名单的IP :" IP2
               sed -i '/'$IP2'/d' $list
			   echo -e '当前白名单IP：'
               cat -n "$list"
	elif [[ ${bk_modify} == "3" ]]; then
		echo '' > $list
		echo -e '当前白名单IP：'
        cat -n "$list"
	else
		echo -e "${Error} 请输入正确的数字(1-3)" && exit 1
	fi








