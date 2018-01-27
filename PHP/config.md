# PHP 配置笔记

## CGI
Common Gateway Interface, 公共网关接口  
Nginx(web server) 作为内容的分发者  
- 当收到 `index.html` 的请求时返回文件系统中的这个文件, 这是静态数据的请求  
- 当收到 `index.php` 时会将请求信息(包含url/query string/HTTP header...)交给 `php-fpm` (PHP解释器, 区别于 `PHP-CLI`) 处理, `php-fpm` 会解析 `php.ini` 初始化执行环境, 然后处理请求并以 `CGI` 规定的格式返回处理结果
`CGI` 规定了 `Nginx` (web server) 要传递给 `php-fpm` (CGI 程序 & PHP 解释器) 的数据及数据格式  


![CGI图解](https://images2015.cnblogs.com/blog/806469/201609/806469-20160927081047438-329876066.png)

### *FastCGI*
在 `CGI` 的基础上进行优化

### *php-fpm*
是一个实现了 `FastCGI` 的程序

### *资源*
[FastCGI 与 php-fpm 的关系](https://segmentfault.com/q/1010000000256516)
[PHP-FPM 图解](https://www.cnblogs.com/iiiiher/p/5911419.html)

## php-fpm
### [配置](http://blog.csdn.net/beyond__devil/article/details/53224004)

## Nginx 相关配置

### *nginx.conf*
```profile
worker_processes  2;

error_log  /usr/local/nginx/logs/error.log;
#error_log  logs/error.log  info;

# 进程标识符 存放路径
# pid        logs/nginx.pid;

# 进程可以打开的最大描述符数量
worker_rlimit_nofile 2048;

events {
    # I/O 模型
    use epoll;
}

# 引入 HTTP 模块主配置: conf.d/http.main
#     -> 引入所有虚拟主机配置
include conf.d/http.main;
```

### *conf.d/http.main*
```profile
http {
    include       mime.types;
    default_type  application/octet-stream;

    # 日志格式设置。
    # $remote_addr与$http_x_forwarded_for用以记录客户端的ip地址；
    # $remote_user：用来记录客户端用户名称；
    # $time_local： 用来记录访问时间与时区；
    # $request： 用来记录请求的url与http协议；
    # $status： 用来记录请求状态；成功是200，
    # $body_bytes_sent ：记录发送给客户端文件主体内容大小；
    # $http_referer：用来记录从那个页面链接访问过来的；
    # $http_user_agent：记录客户浏览器的相关信息；
    # 通常web服务器放在反向代理的后面，这样就不能获取到客户的IP地址了，通过$remote_add拿到的IP地址是反向代理服务器的iP地址。
    # 反向代理服务器在转发请求的http头信息中，可以增加x_forwarded_for信息，用以记录原有客户端的IP地址和原来客户端的请求的服务器地址。
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  logs/access.log  main;

    sendfile on;
    directio 4m;
    directio_alignment 512;

    tcp_nopush on;
    tcp_nodelay off;

    keepalive_timeout 180s;
    keepalive_requests 100;
    keepalive_disable msie6;
    send_timeout 60s;
    client_body_timeout 60s;
    client_header_timeout 30s;

    gzip on;
    gzip_min_length 1024;
    gzip_buffers 4 16k;
    gzip_comp_level 5;
    gzip_proxied any;
    gzip_types text/plain application/json application/x-javascript text/css appl
    ication/xml;
    gzip_vary on;
    gzip_disable "MSIE [1-6]\.";

    fastcgi_buffer_size 64k;
    fastcgi_buffers 4 64k;
    fastcgi_busy_buffers_size 128k;
    fastcgi_temp_file_write_size 256k;
    fastcgi_connect_timeout 300;
    fastcgi_send_timeout 300;
    fastcgi_read_timeout 300;
}

# 引入所有虚拟主机配置
include /usr/local/nginx/cong/conf.d/*.conf;
```

### `conf.d/test-php.conf`
```profile
server {
    listen       80; # 端口,一般http的是80
    server_name  test-php.com; # 一般是域名,本机就是localhost
    index index.php index.html;  # 默认可以访问的页面,按照写入的先后顺序去寻找
    root  /home/sven/project/php/test; # 项目根目录

    # 防止访问版本控制内容
    location ~ .*.(svn|git|cvs) {
        deny all;
    }

    # 此处不是必须的,需要时候配置
    # location / {
        # Laravel 5.4 Url 重写
    #    try_files $uri $uri/ /index.php?$query_string;
    # }


    # 下面是所有关于 PHP 的请求都转给 php-fpm 去处理
    location ~ \.php {

        # 注意： unix sock 和 ip ，两种方式只能选择一种

        # 基于unix sock 访问,Ubuntu Apt 方式安装的PHP默认是以sock方式启动
        # fastcgi_pass unix:/run/php/php7.0-fpm.sock;

        # 基于IP访问
        fastcgi_pass    127.0.0.1:9000;

        fastcgi_split_path_info ^(.+\.php)(.*)$;
        fastcgi_param PATH_INFO $fastcgi_path_info;
        fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include         fastcgi_params;
    }

    fastcgi_intercept_errors on;
    # 日志保存目录,一般按照项目单独保存, 开发环境可以关闭
    # access_log logs/test-php.log access; 
    access_log on;
}
```

