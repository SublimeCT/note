# 《跟老男孩学 Linux 运维》 学习笔记
> 由于笔者开发环境使用 [`fish shell`](https://fishshell.com/docs/current/index.html), `fish` 与 `bash` 不兼容, 所以本系列笔记将对大部分代码都有 `fish shell` 的兼容版本

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
- [awk 命令详解](http://www.zsythink.net/archives/tag/awk/)