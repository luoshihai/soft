#脚本启动方式 /bin/bash start.sh nginx|redis|mysql

# nginx配置
1. Nginx源文件路径:/data/soft/
2. Nginx安装路径路径:/data/server/nginx
3. Nginx 配置文件路径:/data/soft/nginx-1.10.2/conf/nginx.conf
4. Nginx使用方式: service nginx start|stop|restart

# redis配置
1. redis源文件路径:/data/soft/
2. redis安装路径路径:/data/install/redis
3. redis 配置文件路径:/data/soft/redis-3.2.6/redis.conf
4. redis使用方式: service redis start|stop|restart
5. redis-cli 位置: /data/install/redis/bin/redis-cli
6. 启动时候将配置文件 redis.conf 并修改 daemonize no（第128行） 为 daemonize yes 
# mysql 配置
1. MySQL 安装路径路径:/usr/bin/mysql
2. MySQL 配置文件路径:/etc/mysql/mysql.conf.d/mysqld.cnf
3. redis使用方式: service MySQL start|stop|restart
