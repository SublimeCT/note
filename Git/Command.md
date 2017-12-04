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

```bash
git config [--global] user.name "sven"
git config [--global] user.email "helllosc@qq.com"
```

### 检查配置信息
```bash
git config --list
git config user.name
```

## help
```bash
git help
```

## 基础命令

### 初始化

```bash
# 从当前目录创建项目
# 将创建 .git 目录
git init
echo 'test' > test
# 将文件提交到 暂存区
git add test
# 将 暂存区 中的文件提交到本地仓库
git commit -m "test"
```

### 忽略文件
```bash
# 使用 shell 的 glob 模式匹配
# 忽略 .o 和 .a 结尾的文件
*.[oa]
```

### 查看修改
```bash
# 对比暂存区和工作区文件差异(尚未暂存的改动)
git diff
# 已暂存的将要提交的内容(在暂存区中尚未提交的改动)
git diff --staged
```

### 移除文件
> 从暂存区移除该文件并**不再跟踪该文件**

```bash
# 从暂存区移除文件
git rm file_a --cache
# 从暂存区和工作区移除文件(强制删除)
git rm *.log -f
```

### 移动文件
```bash
# 重命名文件
git mv file_a file_A
# 相当于以下命令
mv file_a file_A
git rm file_a
git add file_A
```