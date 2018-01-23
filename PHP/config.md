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

