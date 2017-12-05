# Linux Command 常用命令整理

## marks

- [每天一条 Linux 命令](https://www.cnblogs.com/peida/archive/2012/12/05/2803591.html)
- [Linux 新手应该知道的 26 个命令](https://linux.cn/article-6160-1.html)  
- [Linux 命令文档](http://man.linuxde.net/)

## 文件操作

### [find](http://man.linuxde.net/find) 查找文件
- 文件名
    - `find / -name httpd.conf`  
        在根目录下查找 `httpd.conf`
    - `find . -iname '*.conf'`  
        在当前目录下查找 *.conf 且不区分大小写
    - `find /etc -maxdepth 1 -name '*.md'`  
        在 `/etc` 目录下查找 `.md` 结尾的文件, 目录层级设置为 1
    - `find . -maxdepth 1 -regex './T.*'`  
        使用 **正则表达式** 匹配文件或目录 (完全匹配, 包含 `./`)

- 文件类型  
`find . -type <文件类型>`
    - f 普通文件  
    - l 符号连接  
    - d 目录  

- 文件属性
    - `find . -amin -10`  
        10 分钟内访问的文件
    - `find . -mtime +10`  
        修改超过 10 小时的文件
    - `find . -type d -size +5k`  
        大于 `5k` 的目录 **c 字节 k 千字节 M 兆字节 G**
    - `find . -empty`  
        查找空文件

- 配合其他命令使用
    - `find . -name 'test.md' -exec cat {} \;`  
        查找后打印该文件

### [unzip](http://man.linuxde.net/unzip) / [zip](http://man.linuxde.net/zip) 文件解压
- `unzip test.zip -d my_dir/`  
    在指定目录解压文件
- `unzip -v test.zip`  
    查看解压目录但不解压
- `unzip -n test.zip -d my_dir`  
    如果存在同名文件则不覆盖
- `unzip -o test.zip -d my_dir`  
    如果存在同名文件则覆盖
- `zip xxx.tar.gz *`  
    压缩当前目录到指定文件

### [ls](http://man.linuxde.net/find) 列出子目录和文件
- `ls -la`  
    单列输出所有子目录和文件  
- `ls -lt`  
    按文件或目录修改时间排序
- `ls -R`  
    递归显示所有文件

## [tar](http://man.linuxde.net/tar) 打包文件或目录
***打包与压缩***
> 包是指将一大堆文件或目录变成一个总的文件, 压缩则是将一个大的文件通过一些压缩算法变成一个小文件  

***Linux 中的压缩***
> `Linux` 中很多压缩程序只能针对一个文件进行压缩, 压缩多个文件需要先用 `tar` 命令将所有文件打包, 然后再用 `gzip` `bzip2` 压缩程序进行压缩

### 常用参数
命令 | 描述
---|---
x | 从备份文件中还原文件**解压**  
c | 建立新的备份文件**打包**  
C | 在指定**目录**解压缩
v | 显示指令 `执行过程`  
f | `指定` 备份文件  
z | 使用 `gzip` 处理备份文件
j | 使用 `bzip2` 处理备份文件

### 打包/压缩
- `tar -cvf log.tar.gz logs/`  
    仅打包, 不压缩
- `tar -zcvf`  
    打包且使用 `gzip` 压缩

### 解压
- `tar -zxvf xxx.tar.gz -C test`  
    将压缩文件解压到制定目录 

## [rm](http://man.linuxde.net/tar) 删除文件

- `rm -rf xxx`  
    递归删除指定目录


