# launchctl
> `launchctl` 是  下的统一的服务管理框架，可以启动、停止和管理守护进程、应用程序、进程和脚本等

- `~/Library/LaunchAgents` 由用户自己定义的任务项
- `/Library/LaunchAgents` 由管理员为用户定义的任务项
- `/Library/LaunchDaemons` 由管理员定义的守护进程任务项

## 创建 plist 文件

***MacOs* 开机启动使用 `brew services` 实现, 编译安装或系统预装的软件需要先写好 `plist` 文件, 若任务需要管理员权限, 则需要在上述目录中加入 `plist` 文件, [参考](https://blog.csdn.net/u012390519/article/details/74542042)**

```bash
# 使用 brew 安装的可以直接设置为开机启动, 需要注意的是如果软件需要管理员权限运行, 则必须使用 root 用户执行 `brew services start`
sudo brew services start nginx
```

编译安装或系统自带的 `php` 需要通过 `launchctl` 设置为开机启动

首先创建 `plist` 文件 `/Library/LaunchDaemons/net.php.php-fpm.plist`
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>net.php.php-fpm</string>
    <key>Program</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>RunAtLoad</key>
    <true/>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/sbin/php-fpm</string>
    </array>
  </dict>
</plist>
```

```bash
# 创建日志文件
sudo touch /var/log/php/php-fpm-launch-error.log
```

## 加入新任务

```bash
# 查看任务列表
launchctl list | grep php-fpm
# 如果之前设置了 brew services start nginx, 没有用 root 权限执行, 则需要执行如下步骤:
# 如果该软件通过 `brew` 安装, 则可以直接执行 `brew services start nginx`, 与以下命令效果一致
# 0. 先 unload
sudo launchctl unload -w ~/Library/LaunchDaemons/org.php.php-fpm.plist
# 1. 复制到 /Library/LauncDaemons 下
cp ~/Library/LaunchDaemons/org.php.php-fpm.plist /Library/LaunchDaemons/org.php.php-fpm.plist
# 2. 修改文件所有者为 root
sudo chown root /Library/LaunchDaemons/org.php.php-fpm.plist
# 载入新任务
sudo launchctl load -w /Library/LaunchDaemons/org.php.php-fpm.plist
```

## refer
- [MacOs 下 brew services 配置开机启动项](https://segmentfault.com/a/1190000018928643?utm_source=tag-newest)
- [MacOs 下 launchctl 配置开机启动项](https://blog.csdn.net/qq_19557947/article/details/90604492)