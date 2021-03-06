# MySQL

## links
- [about mysql_secure_installation](https://blog.csdn.net/qq_32786873/article/details/78846008)

## Install
这里只记录最新版的 `mysql8.x` `apt` 安装方式, `5.x` 版本的安装方式相似(`apt-get` 只能安装 `5.x`)

- [方式1](https://www.jianshu.com/p/40b770d86a7b), 通过 `mysql-apt-config_0.8.13-1_all.deb` 安装
- [方式2](https://blog.csdn.net/irving512/article/details/53793671), 安装 `https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-server_8.0.17-1debian9_amd64.deb-bundle.tar` 社区版安装
- [方式2 安装选项](https://www.linuxidc.com/Linux/2018-11/155408.htm)
- [安装包的不同版本](https://cloud.tencent.com/developer/article/1353360)
- [关于 systemctl](https://www.linux265.com/news/3385.html)

1. 首先从 [官网](https://dev.mysql.com/downloads/), 下载 `MySQL APT Repository` 包
![](https://images2015.cnblogs.com/blog/417876/201707/417876-20170712005943462-259670188.png)

2. 通过 `xxx_all.deb` 安装是可能会提示选择 `linux` 版本等信息, 可以参考 [方式2 安装选项](https://www.linuxidc.com/Linux/2018-11/155408.htm)

3. 执行附带的安全脚本

```bash
sudo mysql_secure_installation
```

4. 使用 [systemctl](https://wizardforcel.gitbooks.io/vbird-linux-basic-4e/content/150.html) 实现开机启动

```bash
sudo systemctl enable mysql
```

关于编译安装 `nginx` 自启动的问题:

首先添加 `/usr/lib/systemd/system/nginx.service` 配置文件, [参考这个配置](https://broqiang.com/posts/compile-install-nginx#%E9%85%8D%E7%BD%AE%E8%87%AA%E5%8A%A8%E5%90%AF%E5%8A%A8)

```bash
# 如果遇到下面这个端口占用的问题, 可以 netstat -ltunp 找到占用的进程并 kill
# nginx: [emerg] bind() to 0.0.0.0:10001 failed (98: Address already in use)
sudo systemctl enable nginx
```