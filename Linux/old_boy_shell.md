# 《跟老男孩学Linux运维：Shell编程实战》 笔记

## 2 脚本入门
### 2.6.1 基本格式
`#!` 为固定格式， `/bin/bash` 为指定执行该程序的解释器

```bash
#!/bin/bash
```

- 执行 `shell` 脚本时会向系统内核请求启动一个新进程用于执行脚本
- 如果存在子脚本则会创建新的进程执行子脚本

### 2.6.2 shell 脚本的执行方式
- `bash [script_file]` 在脚本没有执行权限或开头没有指定解释器时也可以执行
- `./[script_file]` / `path_to/[script_file]` 在当前目录下执行脚本
- `source [script_file]` / `. [script_file]` 将在父 `shell` 脚本进程中执行
- `sh < [script_file]` / `cat [script_file]|sh`

## 3 变量
### 3.1 分类
- 环境变量
    - 自定义环境变量
    - `bash` 内置变量
- 普通变量

### 3.2 环境变量
> 根据系统规范, 所有环境变量均为大写

```bash
$ export TEST_NUM=12345
```

查看环境变量
- `set` 显示所有(全局和局部)变量  
    `set -o` 显示 `bash shell` 的所有参数配置信息
- `env` 只显示全局变量
- `delcaare` 显示所有的变量/函数/已导出的变量

自定义环境变量的两种方式
```bash
$ export FOO=123
$ declare -x BAR=456
```