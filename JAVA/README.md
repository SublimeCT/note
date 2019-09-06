# JAVA 笔记

## links
- [JDK 华为镜像](https://blog.csdn.net/qq_29753285/article/details/93992594)
- [JDK 官网下载](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
- [随便找个 Oracle 账号?](https://blog.csdn.net/weixin_42369687/article/details/90340691)
- [Maven](http://maven.apache.org/download.cgi)

## Linux 开发环境搭建
- 下载最新版 `jdk`
- 解压到 `/usr/local`(可自定义)
- 配置环境变量

*fish* `~/.config/fish/config.fish`  
**需要特别注意 `.` 需要放到引号里面, 具体请参考相关[文章](https://github.com/fish-shell/fish-shell/issues/3148) / [文档](http://fishshell.com/docs/current/index.html)**
```bash
# Set path for JAVA
set -x JAVA_HOME /usr/local/java
set -x JRE_HOME $JAVA_HOME/jre
set -x CLASSPATH $JAVA_HOME/lib $JRE_HOME/lib
set -x CLASSPATH ".:$CLASSPATH"
set -x PATH $JAVA_HOME/bin $JRE_HOME/bin $PATH
```

## maven


## Hello World
`HelloWorld.java`
```java
public class HelloWorld {
    public static void main (String[] args) {
        System.out.println("Hello World");
    }
}
```

```bash
$ javac HelloWorld.java
$ java HelloWorld
```


