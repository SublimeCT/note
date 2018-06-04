# [简介](https://github.com/SublimeCT/note/tree/master/Linux/docs/shell/1.md) [:point_right: link](http://www.cnblogs.com/f-ck-need-u/p/5915048.html)

> 脚本都以 `#!/bin/bash` 开头, `/bin/bash` 为解释程序的路径

## 基础
- `shell` 是一个命令语言解释器
- `shell` 在成功登入系统时启动, 在 `/etc/passwd` 中每个用户都有缺省的 `shell`

## 多命令逻辑执行顺序
- `分号 ;` 所有命令没有逻辑关系, 其中一个报错也不影响其他命令执行
- `||` 
- `&&`
- `&` 表示将前面的命令放入后台执行并立即执行后面的命令 

## 变量
### 环境变量
```shell
env # 查看环境变量
echo $PATH
PATH=/usr/local/mysql/bin:$PATH # 修改环境变量值
```

### 普通变量
```shell
set # 查看所有变量
test='test' # bash 环境
set test test # fish 环境
readonly test='test' # 设置只读变量

export test # 将普通变量升级为环境变量
# 设置为永久全局变量
source /etc/profile # `/etc/profile` 文件在每个用户登录时都会执行

unset test # 销毁变量
echo ${foo:-text} # foo 未定义或为空时输出 text 
echo ${foo-text} # foo 未定义时输出 text, 为空时输出 null 
```

### 特殊变量
```shell
echo ${#test} # 获取变量长度
```

```bash
sh ./var.sh param1 param2
```

```shell
echo $# #  2 参数个数
echo $0 # ./var.sh 脚本名
echo $1 # param1 第 1 个参数
echo $* # param1 param2 所有参数整体
```

### 针对变量的操作
```shell
#!/bin/bash
file_name='Linux.docx.jpg'
# 删除
echo ${file_name#.*} # 从左到右匹配, 删除第一个 .*
echo ${file_name##.*} # 贪婪删除
echo ${file_name%.*} # 从右到左匹配, 删除第一个 .*
echo ${file_name%%.*} # 贪婪匹配
# 提取和替换
echo ${file_name:1:3} # 字符串截取
echo ${file_name/jpg/png} # 替换
echo ${file_name//jpg/png} # 贪婪替换
# 将 PATH 中重复的路径删除
test_path='/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/usr/local/apache/bin:/usr/local/mysql:/usr/local/apache/bin'
echo ${test_path/:\/usr\/local\/apache\/bin/}
echo $test_path
```

### 其他
`var.sh`
```shell
shift $1
```

## 命令执行过程
![](https://images2017.cnblogs.com/blog/733013/201708/733013-20170823180217886-1435362444.png)

```bash
echo -e "some files:" ~/i* "\nThe date:$(date +%F)\n$name's age is $((a+4))" >/tmp/a.log
```

1. 读取输入的命令
2. 解析并分割每个单词, 分割后的每个单词称为 `token`
![](https://images2017.cnblogs.com/blog/733013/201708/733013-20170823180302324-561234934.png)
3. 检查命令结构, 对 `shell` 编程中的关键字进行特殊处理
4. 检查第一个 `token` 是否是别名, 如果是别名则返回 `2`
5.  