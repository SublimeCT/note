# iheima.com

## 文件和目录操作
- `/bin`  
即 `Binary`, 存放二进制可执行文件, 存放常用命令
- `/sbin`  
`Super Binary`, 存放管理员使用的系统管理程序
- `/boot`  
存放系统启动时的一些核心文件
- `/dev`  
`Device` 的缩写， Linux 将外部设备抽象为文件, 可以通过访问设备文件访问外部设备
－ `/etc`  
系统配置文件目录
- `/lib`  
动态连接共享库  
- `/lost+found`  
系统异常关机后的文件碎片
- `/media`  
系统将识别的设备挂载到这个目录中
- `/mnt`  
可以临时挂载其他文件系统
- `/opt`  
用户安装的软件存放目录
- `/proc`
这是一个虚拟目录, 是系统内存的映射
- `/usr`
`User Software Resource`, 存放用户安装的应用程序和文件
- `/usr/bin`
系统用户使用的应用程序
- `/usr/sbin`
root 用户使用的应用程序
- `/usr/src`
内核源码默认存放目录
- `/var`
系统中经常需要变化的文件, `/var/logs` 日志文件目录

## 硬链接与软连接
- 硬连接
    `linux` 下的文件是通过索引节点 `inode` 来识别文件, 硬链接可以认为是一个指向文件索引节点的指针, 系统并不为它重新分配 `inode`  

- 软连接 (符号连接)
    建立软连接的文件是一个文本文件, 其中包含它提供链接的另一个文件的路径名

系统通过硬链接计数确定是否删除该文件

## 查看目录使用情况
- `du -h` 查看当前目录下所有文件使用情况
- `du -sh` 查看当前目录使用情况
- `df -h` 查看磁盘使用情况

## 修改文件权限
```bash
chmod u+r file # 为文件所有者增加读权限
chmod g-r file # 为同组用户删除读权限
chmod o=wr file # 为其他用户设置为　rw-
chmod +x file # 为所有用户增加可执行权限
```

## 修改文件所有者和用户组
```bash
sudo chown user:group file
```

## 按文件内容查找文件
```bash
grep -r 'test' test_dir
```

## 软件安装与卸载
### 在线安装 `apt-get`
```bash
sudo apt-get clean # 清理软件包列表, 实际清理的是 /var/cache/apt/archives 的 .deb 文件
```

### dpkg
```bash
dpkg -i xxx
dpkg -r xxx
```

### 源码安装
1. 解压源代码包
2. 进入软件包目录
3. `./configure` 并加入配置参数
4. `make`
5. `sudo make install`
6. `sudo make distclean` 卸载软件

## U盘的挂载

### 基础
- 所有的设备文件都抽象为文件, 通过 `/dev` 目录访问
- `Linux` 系统磁盘种类
    - sd: SCSI Device
    - hd: Hard Disk
    - fd: Floppy Disk 软盘
- 硬盘列表
    - sda 第一块硬盘
        - 主分区[最多有 `4` 个]
            - `sda1`
            - `sda2`
            - `sda3`
            - `sda4`
        - 逻辑分区[从 `5` 开始]
            - `sda5`
    - sdb 第二块硬盘
    - sdc 第三块硬盘

插入 U盘  

```bash
➜  ~ tree /media
/media
├── apt [error opening dir]
├── cdrom
└── xxx
    └── 0010-CC6A
        └── user4
            ├── 安雯 月满西楼.mkv
            └── 泽尔丹 扎西措 今生相爱.mkv
```

### 卸载

```bash
➜  ~ umount /media/sven/0010-CC6A 
```

### 挂载

```bash
# 查看设备名称
➜  ~ sudo fdisk -l
Disk /dev/sda: 119.2 GiB, 128035676160 bytes, 250069680 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x8b7774bc

Device     Boot Start       End   Sectors   Size Id Type
/dev/sda1  *     2048 250068991 250066944 119.2G 83 Linux


Disk /dev/sdb: 7.5 GiB, 8053063680 bytes, 15728640 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x0010cc6a

Device     Boot Start      End  Sectors  Size Id Type
/dev/sdb1  *       64 15728639 15728576  7.5G  b W95 FAT32

# 执行挂载
➜  ~ sudo mount /dev/sdb1 /mnt
```

## 压缩
### tar
- z 使用 `gzip` 方式压缩
- c 压缩
- v 显示提示信息
- x 解压缩
- f 指定压缩文件的名字
- C 解压时指定解压目录

```bash
# 解压到指定目录
tar -zxvf test.tar.gz -C test_dir
```

### zip
- r 目录
- d 指定解压目录

```bash
tar -r test.zip test_dir # 压缩
tar test.zip -C tset_dir # 解压
```

## 进程管理

### tty 终端
- `tty1` ~ `tty6` 虚拟终端
- `tty7` 图形界面终端

### ps 查看所有进程
- a 所有用户的进程
- u 查看进程所有者等信息
- x 查看没有 `tty` 终端的进程

### kill 传递指定信号给进程
- l 查看所有信号名称

## 网络
### nsloolup
```bash
➜  ~ nslookup www.test.com
Server:		192.168.1.1
Address:	192.168.1.1#53

Non-authoritative answer:
Name:	www.test.com
Address: 69.172.200.235
```

## 用户管理
### useradd
- s 指定 `shell` 类型
- g 用户组
- d 家目录

### userdel
- r 将家目录一起删除

### groupadd 创建用户组

## 服务器搭建
- ftp
- nfs 设置共享目录后, 可直接通过 mount 挂载
- ssh (微软)







