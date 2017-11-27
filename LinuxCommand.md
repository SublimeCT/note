# Linux Command 常用命令整理

## marks

- [Linux 新手应该知道的 26 个命令](https://linux.cn/article-6160-1.html)  
- [Linux 命令文档](http://man.linuxde.net/)

## 文件查找

> `find` 是根据文件的属性查找  
`grep` 根据文件内容查找

### find
- 文件名
    - `find / -name httpd.conf`  
        在根目录下查找 `httpd.conf`
    - `find . -iname '*.conf'`  
        在当前目录下查找 *.conf 且不区分大小写
    - `find /etc -maxdepth 1 -name '*.md'`  
        在 `/etc` 目录下查找 `.md` 结尾的文件, 目录层级设置为 1
- 文件属性
    - `find . -amin 10`  
        10 分钟内访问的文件
    - `find . -mtime 10`  
        10 小时内修改过的文件
    - `find . +1G`  
        大于 1G 的文件 **c 字节 k M G**


