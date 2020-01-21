# 《跟老男孩学 Linux 运维》 学习笔记

## 速查
### 变量

名称 | 描述
--- |---
`$SHELL` | 系统默认 `shell`
`$HOME` | 用户家目录
`$UID` | 用户 UID
`$PWD` | 当前工作目录的绝对路径
`$USER` | 当前用户名

## 语法
```bash
# 将命令执行结果赋值给变量
FILE_NAME=$(date +%F.log)
```

## 参考
- [命令手册](http://man.linuxde.net/)