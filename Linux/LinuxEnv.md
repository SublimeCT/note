# Linux 开发环境搭建

## list
- fish
- NodeJS
- Nginx
- MongoDB

## fish
> [配置](http://www.cnblogs.com/welhzh/p/5899875.html) / [教程](http://www.ruanyifeng.com/blog/2017/05/fish_shell.html)

将 `fish` 作为默认 shell
```bash
$ sudo apt-get install fish
$ chsh -s /usr/bin/fish
```

使用 [`omf`](https://github.com/oh-my-fish/oh-my-fish) 设置主题和插件
```bash
$ curl -L https://get.oh-my.fish | fish
$ omf doctor # 需要先检测本地 fish 环境
```

~~通过图形化界面设置 `fish`~~
```bash
$ fish_config
```

## Node
这里选择了 `/opt` 目录
```bash
$ wget https://npm.taobao.org/mirrors/node/v8.9.4/node-v8.9.4-linux-x64.tar.xz
$ tar -xvf node-v8.9.4-linux-x64.tar.xz -C /opt
$ sudo mv node-v8.9.4-linux-x64 node
```

配置环境变量
```bash
$ sudo vim /etc/profile
```

针对系统默认的 `bash` */etc/profile*
```profile
export NODE_HOME=/usr/local/node
export PATH=$NODE_HOME/bin:$PATH 
```

针对 `fish` 的配置方式, 特别需要注意的是 `fish` 通过**空格**分割环境变量
```bash
# Set path for NodeJS
set -x NODE_HOME /opt/node
set -x PATH $NODE_HOME/bin $PATH
```

## Nginx
解压到 `/usr/local/src`
```bash
$ wget http://nginx.org/download/nginx-1.12.2.tar.gz
$ sudo tar -zxvf nginx-1.12.2.tar.gz -C /usr/local/src
```

安装依赖
```bash
$ sudo apt install -y libpcre3-dev zlib1g-dev libssl-dev
```

编译安装, [配置项](http://nginx.org/en/docs/configure.html)
```bash
$ sudo ./configure --prefix=/usr/local/nginx --user=www --group=www --with-select_module --with-poll_module --with-http_ssl_module --with-pcre  --with-pcre-jit --with-zlib= --pid-path=/usr/local/nginx/run/nginx.pid
$ sudo make
$ sudo make install
```

创建 `www` 账户
```bash
$ sudo /usr/sbin/groupadd www
# 不允许 www 用户直接登录系统
$ sudo /usr/sbin/useradd -g www www -s /bin/false
$ sudo /usr/local/nginx/sbin/nginx -t
```

具体配置 -> [note](https://github.com/SublimeCT/note/blob/master/PHP/config.md)

## golang

```bash
# Set path for NodeJS
set -x NODE_HOME /usr/local/node
set -x PATH $NODE_HOME/bin $PATH

# Set path for Yarn
set -x YARN_HOME /home/xxx/.yarn
set -x PATH $YARN_HOME/bin $PATH

# Set path for Go
set -x GOPATH /home/xxx/project/go_demo
set -x GOROOT /usr/local/go
set -x GOARCH amd64
set -x GOOS linux
set -x PATH $GOROOT/bin $GOPATH/bin $PATH
```