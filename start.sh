#! /bin/bash
down_file(){
	[ -d "/data/soft" ] || mkdir -r /data/soft	
	chmod 777 /data/soft
	cd /data/soft
	[ -f nginx-1.10.2.tar.gz ] || wget -P /data/soft "https://github.com/luoshihai/doc/blob/master/nginx-1.10.2.tar.gz"
	[ -f pcre-8.39.tar.gz ] || wget -P /data/soft "https://github.com/luoshihai/doc/blob/master/pcre-8.39.tar.gz"
	echo "------------------------------down finish----------------------------------------------------" 
	[ -f nginx-1.10.2.tar.gz ] ||  (echo "---------------------------------------nginx download failured---------------------------" && exit)
	[ -f pcre-8.39.tar.gz ] || (echo "-----------------------------------------pcre download failured---------------------------" && exit)
}
install_pcre(){
	cd /data/soft
	[ -d pcre-8.39 ] && rm -rf pcre-8.39
	tar xf pcre-8.39.tar.gz
	cd pcre-8.39
	./configure
	make
	make install
	echo "-----------------------------------------------------------------------------------------------" 
	echo "---------------------------------------pcre install finished---------------------------------------" 
	if [ $? == 0 ]
	then
	echo "--------------------------------pcre install success----------------------------------------" 
	else
	echo "-------------------------------------prce install failed-------------------------------------"
	exit
	fi
}
install_nginx(){
	cd /data/soft/
	[ -d nginx-1.10.2 ] && rm -rf nginx-1.10.2
	tar xf nginx-1.10.2.tar.gz
	cd nginx-1.10.2/
	./configure --prefix=/data/server/nginx --without-http_gzip_module
	make
	make install
	echo "--------------------------------------nginx install finished---------------------------------------------------------" 
	if [ $? == 0 ]
	then
	echo "-------------------------------------nginx install success------------------------------------------" 
	else
	echo "----------------------------------------nginx install failed---------------------------------------"
	exit
	fi
}
main(){
	down_file
	install_pcre
	install_nginx
}
main
