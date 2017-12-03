# 常用 Git 命令笔记
> 重新学习 Git, 参照官网学习  
> 侧重于整理常用的 git 命令, 以后遇到其他命令再做补充  

## links
- [官网](https://git-scm.com/book/zh/v2)

## 配置
### 配置文件
1. `/etc/gitconfig` 包含系统上每一个用户及他们仓库的通用配置, 使用带有 `--system` 选项的 `git config` 时从此文件读写配置变量
2. `~/.gitconfig` 或 `~/.config/git/config` 文件只针对当前用户, 可以传递 `--global` 选项读写此文件
3. 当前使用仓库的 `Git` 目录中的 config 文件 `.git/config` **只针对该仓库**

### 用户信息
> 初始化完 git 仓库后第一件事就是设置用户信息, 这些信息会写到每一次的提交中

```shell
git config [--global] user.name "sven"
git config [--global] user.email "helllosc@qq.com"
```

### 检查配置信息
```shell
git config --list
git config user.name
```

## help
```shell
git help
```

## 初始化

