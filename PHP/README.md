# PHP 笔记

## 0 Catalogue
- `PHP` 基础
    - [基础笔记1(⚠️ 早期笔记)](/PHP/[PHP]%201~7.md)
    - [基础笔记2(⚠️ 早期笔记)](/PHP/[PHP]%208~14.md)
    - [基础笔记3(⚠️ 早期笔记)](/PHP/[PHP]%2015~21.md)
    - [基础笔记4(⚠️ 早期笔记)](/PHP/[PHP]%2022~28.md)
    - [CMS项目(⚠️ 早期笔记)](/PHP/[PHP]%20CMS内容管理系统.md)
    - [CMS项目(⚠️ 早期笔记)](/PHP/[PHP]%20MVC.md)
- `framework`
    - [Yii 框架基础部分(⚠️ 早期笔记)](/PHP/Yii/[Yii]%20base.md)
    - [Yii 框架基础部分(⚠️ 早期笔记2)](/PHP/Yii/[Yii]%20base.md)

## 1 Install

### 1.1 Linux(deepin)

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

### 1.2 MacOS(10.15.1)

- `PHP` 可以使用系统预装的 `7.3.1` :)
- 下载指定版本

