# Radies 笔记

## 资源
- [慕课网教程](https://www.imooc.com/learn/809)

## 安装
```bash
$ tar zxf redis-4.0.9.tar.gz
$ cd redis-4.0.9/
$ make
$ sudo make install
```

### redis-server
```bash
➜  redis-4.0.9 redis-server --help
Usage: ./redis-server [/path/to/redis.conf] [options]
       ./redis-server - (read config from stdin)
       ./redis-server -v or --version
       ./redis-server -h or --help
       ./redis-server --test-memory <megabytes>

Examples:
       ./redis-server (run the server with default conf)
       ./redis-server /etc/redis/6379.conf
       ./redis-server --port 7777
       ./redis-server --port 7777 --slaveof 127.0.0.1 8888
       ./redis-server /etc/myredis.conf --loglevel verbose

Sentinel mode:
       ./redis-server /etc/sentinel.conf --sentinel
➜  redis-4.0.9 
```

#### 配置
启动 redis 需要指定一个配置文件, 模板在 `./redis.conf`

改为后台启动
```profile
# By default Redis does not run as a daemon. Use 'yes' if you need it.
# Note that Redis will write a pid file in /var/run/redis.pid when daemonized.
daemonize yes
```

修改端口
```profile
# Accept connections on the specified port, default is 6379 (IANA #815344).
# If port 0 is specified Redis will not listen on a TCP socket.
port 7200
```

#### 启动
```bash
➜  ~ redis-server /usr/local/etc/redis/redis.conf 
➜  cnode git:(master) ✗ ps aux | grep redis-server
xxx     11479  0.0  0.0  45048  4232 pts/3    Sl+  20:50   0:00 redis-server 127.0.0.1:6379
xxx     11616  0.0  0.0  14524   988 pts/2    S+   20:51   0:00 grep --color=auto redis-server
```

### redis-cli
```bash
$ mongo-cli -p 7200
> info
```
