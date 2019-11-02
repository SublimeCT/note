# Laravel note

## links
- [v6.0 中文文档](https://learnku.com/docs/laravel/6.x/installation/5124)

## Install

1. 安装 `Laravel` 安装器
```bash
composer global require laravel/installer
```

2. 添加环境变量
```fish
# Set path for PHP
set -x COMPOSER_PATH /home/sven/.config/composer/vendor
set -x PATH $COMPOSER_PATH/bin $PATH
```

## cli

```bash
# 创建项目
# laravel new blog 由于安装器内代码中的下载地址是写死的, 无法使用国内镜像, 所以会非常慢
# 应该使用 composer create-project 代替
composer create-project --prefer-dist laravel/laravel blog
```

