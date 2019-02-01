# Flutter

## links
- [flutter 中文网](https://flutterchina.club)

## Install
> 参考自 [flutter 中文网](https://flutterchina.club/setup-linux/) & [csdn 文章](https://www.cnblogs.com/zxsh/archive/2018/04/16/8859048.html)

使用google为国内开发者搭建的临时镜像

```bash
# 加入 fish 配置文件中 ...
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

```bash
$ cd /usr/local
$ git clone -b master https://github.com/flutter/flutter.git flutter
$ # 设置项目目录属主并设置环境变量 ...
$ sudo chown -R sven flutter/
$ flutter --version
Downloading Dart SDK from Flutter engine 101b27da7a1b9906d370fdf0612bf3ff31bd860b...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 49.3M  100 49.3M    0     0  2714k      0  0:00:18  0:00:18 --:--:-- 2802k
Building flutter tool...
Flutter 1.1.2-pre.38 • channel master • https://github.com/flutter/flutter.git
Framework • revision 59bfab157e (17 小时前) • 2018-12-15 13:29:54 -0800
Engine • revision 101b27da7a
Tools • Dart 2.2.0 (build 2.2.0-dev.1.0 f9ebf21297)

  ╔════════════════════════════════════════════════════════════════════════════╗
  ║                 Welcome to Flutter! - https://flutter.io                   ║
  ║                                                                            ║
  ║ The Flutter tool anonymously reports feature usage statistics and crash    ║
  ║ reports to Google in order to help Google contribute improvements to       ║
  ║ Flutter over time.                                                         ║
  ║                                                                            ║
  ║ Read about data we send with crash reports:                                ║
  ║ https://github.com/flutter/flutter/wiki/Flutter-CLI-crash-reporting        ║
  ║                                                                            ║
  ║ See Google's privacy policy:                                               ║
  ║ https://www.google.com/intl/en/policies/privacy/                           ║
  ║                                                                            ║
  ║ Use "flutter config --no-analytics" to disable analytics and crash         ║
  ║ reporting.                                                                 ║
  ╚════════════════════════════════════════════════════════════════════════════╝
$ flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel master, v1.1.2-pre.38, on Linux, locale zh_CN.UTF-8)
[!] Android toolchain - develop for Android devices (Android SDK 28.0.3)
    ! Some Android licenses not accepted.  To resolve this, run: flutter doctor --android-licenses
[!] Android Studio (version 3.2)
    ✗ Flutter plugin not installed; this adds Flutter specific functionality.
    ✗ Dart plugin not installed; this adds Dart specific functionality.
[!] IntelliJ IDEA Ultimate Edition (version 2018.2)
    ✗ Flutter plugin not installed; this adds Flutter specific functionality.
[!] VS Code (version 1.27.1)
    ✗ Flutter extension not installed; install from
      https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[!] Connected device
    ! No devices available
$ flutter doctor --android-licenses
```

```fish
# Set path for NodeJS
set -x NODE_HOME /usr/local/node
set -x PATH $NODE_HOME/bin $PATH

# Set path for Yarn
set -x YARN_HOME /home/sven/.yarn
set -x PATH $YARN_HOME/bin $PATH

# Set path for Java
set -x JAVA_HOME /usr/local/jdk1.8.0_191
set -x CLASSPATH $JAVA_HOME/lib $JAVA_HOME/lib/dt.jar $JAVA_HOME/tools.jar
set -x PATH $JAVA_HOME/bin $JAVA_HOME/jre/bin $PATH

# Set path for Postgresql
set -x PGUSER sven

# Set path for Go
set -x GOPATH /home/sven/project/go_demo
set -x GOROOT /usr/local/go
set -x GOARCH amd64
set -x GOOS linux
set -x PATH $GOROOT/bin $GOPATH/bin $PATH

# Set path for Dart
set -x DART_PATH /usr/lib/dart
set -x PATH $DART_PATH/bin $PATH

# Set path for flutter
set -x PUB_HOSTED_URL https://pub.flutter-io.cn
set -x FLUTTER_STORAGE_BASE_URL https://storage.flutter-io.cn
set -x FLUTTER_HOME /usr/local/flutter
set -x PATH $FLUTTER_HOME/bin $PATH
```

## 常用命令 [articel](https://www.jianshu.com/p/2c9867e737a1)

- `packages`
  - `geta`

## 布局

