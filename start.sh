#! /bin/bash
prepare_file(){
        [ -d "/data/soft" ] || mkdir -p /data/soft
        chmod 777 /data/soft
	apt-get -y --force-yes install git
	apt-get -y --force-yes install gcc
	git clone "https://github.com/luoshihai/soft.git"
	cd soft

}
install_pcre(){
	cd $host
        tar xf pcre-8.39.tar.gz -C /data/soft
        cd /data/soft
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
	cd $host
        tar xf nginx-1.10.2.tar.gz -C /data/soft
        cd /data/soft/nginx-1.10.2/
        ./configure --prefix=/data/server/nginx --without-http_gzip_module --with-http_stub_status_module –with-http_ssl_module
        make
        make install
	ln -s /data/soft/pcre-8.39/.libs/libpcre.so.1 /lib/x86_64-linux-gnu/
        echo "--------------------------------------nginx install finished---------------------------------------------------------" 
	/data/server/nginx/sbin/nginx -t
	cp $host/nginx_script /etc/init.d/nginx	
	chmod +x /etc/init.d/nginx	
	export PATH=/data/server/nginx/sbin/:$PATH
	source /etc/profile
	update-rc.d nginx defaults
	systemctl daemon-reload
        if [ $? == 0 ]
        then
        echo "-------------------------------------nginx install success------------------------------------------" 
        else
        echo "----------------------------------------nginx install failed---------------------------------------"
        exit
        fi
}
install_redis(){
	cd $host
        tar xf redis-3.2.6.tar.gz -C /data/soft
	tar -zxvf redis-3.2.6.tar.gz -C $data_path
	cd $data_path/redis-3.2.6
	make
	make PREFIX=$install_path/redis install
	set -i '128s#no#yes#g' /data/soft/redis-3.2.6/redis.conf
	cp $host/redis_script /etc/init.d/redis
	chmod +x /etc/init.d/redis	
	export PATH=/data/install/redis/bin:$PATH
	source /etc/profile
	update-rc.d redis defaults
}
install_mysql(){
	apt-get -y --force-yes install mysql-server
}
install_env(){
        sudo apt-get install python-pip
        sudo pip install virtualenv
        sudo pip install virtualenvwrapper
        pip install --upgrade pip
        mkdir ~/.virtualenvs
        echo export WORKON_HOME=$HOME/.virtualenvs >> ~/.bashrc
        echo source /usr/local/bin/virtualenvwrapper.sh >> ~/.bashrc
        source ~/.bashrc
}

parm_num=$#
array=$@
host=$(pwd)/soft
data_path=/data/soft
install_path=/data/install
main(){
	prepare_file
        if [[ $parm_num == 0 ]]
        then
        echo "参数错误 使用方式:/bin/bash $0 nginx|redis"
        exit
        else
		for i in ${array[@]}
		do
			if [[ $i =~ "nginx" ]]
			then
			install_pcre
			install_nginx
			elif [[ $i =~ "redis" ]]
			then
			install_redis
			elif [[ $i =~ "mysql" ]]
			then
			install_mysql
			elif [[ $i =~ "virtuallenv" ]]
			then
			install_evn
			fi
		done
        fi
}
main

