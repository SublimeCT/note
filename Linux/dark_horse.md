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

