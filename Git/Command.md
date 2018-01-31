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

从当前目录创建项目, 将创建 `.git` 目录  
```bash
git init
```
将文件提交到 `暂存区`  
```bash
echo 'test' > test
git add test
```
将 `暂存区` 中的文件提交到本地仓库
```bash
git commit -m "test"
```

### 忽略文件

使用 `shell` 的 `glob` 模式匹配
```bash
# 忽略 .o 和 .a 结尾的文件
*.[oa]
```

### 查看修改
对比暂存区和工作区文件差异(尚未暂存的改动)
```bash
git diff
```
已暂存的将要提交的内容(在暂存区中尚未提交的改动)
```bash
git diff --staged
```

### 移除文件
> 从暂存区移除该文件并**不再跟踪该文件**

从暂存区移除文件
```bash
git rm file_a --cache
```
从暂存区和工作区移除文件(强制删除)
```bash
git rm *.log -f
```

### 移动文件
重命名文件
```bash
git mv file_a file_A
```
相当于以下命令
```bash
mv file_a file_A
git rm file_a
git add file_A
```

### 查看提交历史

显示最近两次提交记录并列出修改内容
```bash
git log -p -2
```
显示最后一次提交记录的简略信息
```bash
git log --stat -1
```
使用 `ASCII` 图形表示分支合并历史
```bash
git log --graph
```
每条记录只显示一行
```bash
git log --pretty=oneline
```

### 撤销操作

修改上次的提交信息
```bash
git commit -m "first"
git commit --amend
git commit -m "next"
```

撤销 add
```bash
git reset HEAD test_file
```

恢复到上次提交时的状态
```bash
git checkout -- xxx.md
```

### 远程仓库

查看
```bash
git remote -v
```

添加
```bash
git remote add origin https://github.com/test/test
```

### 标签
- 轻量标签
    对某个特定提交的引用
- 附注标签
    存储在 git 数据库中的对象, 包含用户名, email, 时间和标签信息

添加附注标签
```bash
git tag -a v0.1.0 -m 'test'
git tag -a v0.3.0  8a90j83h
```

添加轻量标签
```bash
git tag v0.1.2
```

查看标签信息
```bash
git tag
git show v0.1.0
```

推送标签, 默认 `git push` 不会提交 `tag`
```bash
git push origin v0.2.2
git push origin --tags
```

### git别名

查看最后一次提交内容
```bash
git config --global alias.last 'log -p -1'
```

## 分支

### 创建分支

## 其他
### `git commit` (Angular)格式[规范](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)
```html
<type>(scope): <subject>

<body>

<footer>
```

- `type`
    - `fix` 修复 bug
    - `feat` (feature) 新功能
    - `docs` 文档
    - `style` 样式修改
    - `refactor` 重构
    - `test` 增加测试
    - `chore` 构建过程或辅助工具的变动

- `scope`  
    用于说明影响范围

- `subject`
    简短描述

- `body`
    详细描述

- `footer`
    - 不兼容的变动  
        以 `BREAKING CHANGE:` 开头, 后面是对变动的描述 / 变动理由 / 迁移方法
    - 关闭 Issue
        Closes #1002, #837, #1233

#### 特殊情况
- `revert`  
如果当前的 `commit` 用于撤销当前的 `commit`, 则必须以 `revert:` 开头  
`<body>` 部分固定为 `This revert commit <hash>`, `<hash>` 为被撤销的 `commit` 的 SHA 标识符









