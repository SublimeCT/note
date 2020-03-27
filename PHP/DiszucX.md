# DiscuzX 3.4 安装记录

## 基本环境

- `PHP`: 笔者使用的 `MacOS 10.15.1` 已经预装 `PHP7.3.9`;
- `DiscuzX 3.4`: `git clone` 官方的[仓库](https://gitee.com/ComsenzDiscuz/DiscuzX)安装
- `nginx 1.17.3`: 使用 `brew` 安装
- `mysql`: 使用 `brew` 安装, *安装时间较长, 应该使用科学上网*
- `composer`: 依照官网的[安装方式](https://getcomposer.org/download/), 安装后直接 `mv composer.phar /usr/local/bin/composer`

## 安装
1. 修改 `/upload` 权限为 `777` 并修改所有者为 `nobody`
2. 配置 `nginx` 设置网站根目录为 `/upload`
3. 访问 `http://demo.discuz.com/install` 并按提示安装

## refer
- [官方论坛教程](https://www.discuz.net/forum.php?mod=viewthread&tid=3845172)
