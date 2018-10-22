5. [管道和重定向基础](https://github.com/SublimeCT/note/tree/master/Linux/docs/shell/pipe.md) [:point_right: link](http://www.cnblogs.com/f-ck-need-u/p/7325378.html)

> 管道的本质是数据的传递, 是为了解决进程间通信而存在的

## 匿名管道

在执行 `ps` 时并行执行 `grep`, `ps` 收集的信息时 `grep` 处于等待状态, 收集完成后将数据放入内存， 管道右边的进程读取, 所以在执行 `ps` 时会看到 `grep` 进程

```bash
➜  xxx git:(master) ✗ ps aux | grep ssh
xxx       860  0.0  0.0  11080   332 ?        Ss   19:29   0:00 /usr/bin/ssh-agent /usr/bin/sogou-session /usr/bin/im-launch /usr/bin/startdde
xxx      3787  0.0  0.0  14524   960 pts/1    S+   19:52   0:00 grep --color=auto ssh
```

## 重定向
0. stdin <
1. stdout > / >>
2. stderr 2> / 2>>


