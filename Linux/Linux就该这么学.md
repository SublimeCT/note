# 《Linux 就该这么学》 笔记

## links
- [《Linux 就该这么学》](http://www.linuxprobe.com/chapter-00.html)

## [零](http://www.linuxprobe.com/chapter-00.html)
### UNIX / GNU / Linux
- 1979年, AT&T公司宣布了对 `UNIX` 系统的商业化计划, 成为专利产品
- 1984年, Richard Stallman面对于如此封闭的软件创作环境, 发起了GNU源代码开放计划并制定了著名的 `**GPL许可协议**`
    - 1987年时, GNU计划获得了一项重大突破 `**gcc编译器**` 发布, 这使得程序员可以基于该编译器编写出属于自己的开源软件
    - 1991年10月, 芬兰赫尔辛基大学的在校生Linus Torvalds编写了一款名为 `**Linux**` 的操作系统, 该系统基于 `GNU GPL 协议` 开源

## [一](http://www.linuxprobe.com/chapter-01.html)

## [二](http://www.linuxprobe.com/chapter-02.html)
### pidof
查询某个指定服务进程的 `PID`

### kill / killall
终止某个服务进程
```bash
~/projects/note$ pidof nginx
3876 3875 3874
~/projects/note$ killall nginx
```

### wc
统计指定文本行数 / 字节数 / 字数
```bash
# 统计系统中的账户数量
~/projects/note$ wc -l /etc/passwd
37 /etc/passwd
```

### stat
查看文件详细信息

### cut
按列提取文本
```bash
~/projects/note$ cut -d: -f 1 /etc/passwd
root
daemon
bin
sys
sync
games
man
lp
mail
news
uucp
proxy
www-data
backup
list
irc
gnats
nobody
systemd-timesync
systemd-network
systemd-resolve
systemd-bus-proxy
_apt
messagebus
strongswan
dnsmasq
usbmux
geoclue
nm-openconnect
nm-openvpn
lightdm
pulse
hplip
avahi
gluster
sven
mysqls
```

### grep
在文本中执行关键词搜索
```bash
# -n 显示行号 -v 反选
~/projects/note$ grep -n :/sbin/nologin /etc/passwd
```

## [三](http://www.linuxprobe.com/chapter-03.html)
### 输入 / 输出重定向
- `输入重定向` 是指把文件导入到命令中
- `输出重定向` 是指把原本要输出到屏幕的内容输出到文件中

> 标准输入重定向 (STDIN，文件描述符为0) 默认从键盘输入, 也可从其他文件或命令中输入  
标准输出重定向 (STDOUT，文件描述符为1) 默认输出到屏幕  
错误输出重定向 (STDERR，文件描述符为2) 默认输出到屏幕  

## [五](http://www.linuxprobe.com/chapter-05.html)
### UID 用户身份ID
> 管理员UID为0：系统的管理员用户  
系统用户UID为 `1`-`999` Linux系统为了避免因某个服务程序出现漏洞而被黑客提权至整台服务器, 默认服务程序会有独立的系统用户负责运行, 进而有效控制被破坏范围  
普通用户UID从 `1000` 开始 是由管理员创建的用于日常工作的用户  

### GID 用户组ID
> `Linux` 系统创建用户时会自动创建一个与之同名的基本用户组, 每个用户只有一个基本用户组, 但可以有多个扩展用户组  

### 用户管理命令

- [uesradd](https://github.com/SublimeCT/note/blob/master/Linux/Command.md#useradd)


