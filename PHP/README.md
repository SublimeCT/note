# PHP 笔记

## Install
可以通过两种方式安装, [编译安装](https://broqiang.com/posts/compile-install-php7) 和 [通过 ppa源 安装](https://www.mf8.biz/ubuntu-debian-install-php7-3/)

下面是通过 `ppa` 软件源安装

1. 安装软件源拓展工具

```bash
apt -y install software-properties-common apt-transport-https lsb-release ca-certificates
```

2. 添加 GPG

```bash
wget -O /etc/apt/trusted.gpg.d/php.gpg https://mirror.xtom.com.hk/sury/php/apt.gpg
```

3. 添加 sury 软件源并更新, 由于这里使用的源中没有增加 `stable` 软链接, 所以要改为 `debian` 的版本名称, 关于 [source.list 格式](https://www.cnblogs.com/beanmoon/p/3387652.html)

```bash
echo "deb https://mirror.xtom.com.hk/sury/php/ jessie main" > /etc/apt/sources.list.d/php.list
sudo apt update
```

3. 安装 `Compuser` 依赖管理工具, 参照 [文档](https://pkg.phpcomposer.com/#how-to-install-composer)

```bash
# 这里使用 PHP 语法
php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"

# 使用镜像
composer config -g repo.packagist composer https://packagist.phpcomposer.com
```


