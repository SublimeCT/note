# 初步入门

## 1-Shell
![](http://www.techug.com/wordpress/wp-content/uploads/2018/09/computer_system.png)

`Sehll` 是一个命令解释器, 它的作用是解释用户输入的命令及程序

### 运行脚本
- `bash script_file`, 使用 `bash` 作为解释器执行脚本, 即使文件 **没有可执行权限** 或 **文件开头为执行解释器** 也可以执行
- `./script_file`, 使用脚本中声明的解释器执行
- `source sciprt_file` / `. script_file`, 在父 `shell` 进程中载入指定的子 `shell` 脚本; **与上面两种方式不同的是, 当前的执行环境依然是父 `shell` 进程, 没有创建子 `shell` 进程**

### Hello World
```bash
echo -e '#!/bin/bash\necho Hello World;' > hello.sh
sudo chmod 744 hello.sh # 或者直接使用 bash hello.sh
./hello.sh
```

### 基本规范
开头声明解释器 / 日期 / 版本 / 作者 / 描述 等信息; 脚本中尽量不要使用中文; 脚本文件应该使用 `.sh` 扩展名

```bash
#!/bin/bash
# Date: 2020-01-19 13:06:53
# Author: sven<test@test.com>
# Description: This is function is ...
# Version: 1.1.0
```

### clean logs(version-1)
!> 原文中使用 `"$UID"` 判断当前用户的 UID, 改为 `id -u` 可以兼容 `fish shell` 环境(笔者使用的 `shell` 环境)

[filename](scripts/clean_logs.sh ':include :type=code shell')

## 参考
- [命令行界面 (CLI)、终端 (Terminal)、Shell、TTY的区别](https://www.cnblogs.com/sddai/p/9769086.html)