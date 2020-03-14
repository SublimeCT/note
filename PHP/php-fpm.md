# php-fpm
> `php-fpm` 是一个实现了 `FastCGI` 的程序, [FastCGI 笔记](/PHP/FastCGI.md)

## 启动
```bash
php-fpm
```

## 停止
```bash
ps aux | grep php-fpm
sudo kill -QUIT $PHP_FPM_PID
```

## 报错解决方案
- 错误信息: `ERROR: failed to open configuration file '/private/etc/php-fpm.conf': No such file or directory`
- 环境: `MacOs` 预装或编译安装时出现
- 原因: `php-fpm` 需要一个配置文件

解决方案 1:
```bash
sudo cp /private/etc/php-fpm.conf.default /private/etc/php-fpm.conf
```

解决方案 2:
```bash
# 指定一个已存在的配置文件
php-fpm --fpm-config $YOUR_CONFIG_FILE
```

- 错误信息: `ERROR: failed to open error_log (/usr/var/log/php-fpm.log): No such file or directory (2)`
- 环境: `MacOs`
- 原因: `php-fpm` 需要一个日志文件, 但这个目录并不存在, *这里我修改了目录位置*

```bash
# 首先建立 PHP 相关日志存放的目录
sudo mkdir /var/log/php
sudo touch /var/log/php/php-fpm.log
sudo chown -R nobody:nobody /var/log/php/
# 然后修改 php-fpm.conf 中的日志路径
vim php-fpm.conf
```

```conf
; Error log file
; If it's set to "syslog", log is sent to syslogd instead of being written
; into a local file.
; Note: the default prefix is /usr/var
; Default Value: log/php-fpm.log
error_log = /var/log/php/php-fpm.log
```

```bash
sudo php-fpm
```

## refer
- [官网具体配置](https://www.php.net/manual/zh/install.fpm.configuration.php)