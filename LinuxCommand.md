# Linux Command 常用命令整理

## marks

- [Linux 新手应该知道的 26 个命令](https://linux.cn/article-6160-1.html)  
- [Linux 命令文档](http://man.linuxde.net/)

## 文件操作

### find 查找文件
- 文件名
    - `find / -name httpd.conf`  
        在根目录下查找 `httpd.conf`
    - `find . -iname '*.conf'`  
        在当前目录下查找 *.conf 且不区分大小写
    - `find /etc -maxdepth 1 -name '*.md'`  
        在 `/etc` 目录下查找 `.md` 结尾的文件, 目录层级设置为 1

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

### unzip 文件解压
- `unzip test.zip -d my_dir/`  
    在指定目录解压文件
- `unzip -v test.zip`  
    查看解压目录但不解压
- `unzip -n test.zip -d my_dir`  
    如果存在同名文件则不覆盖
- `unzip -o test.zip -d my_dir`  
    如果存在同名文件则覆盖
