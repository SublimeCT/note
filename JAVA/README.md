# JAVA 笔记

## links
- [JDK & JRE 下载](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

## Linux 开发环境搭建
> `jdk9.x` 环境变量配置与低版本不同, `jdk` 中已不再包含 `jre` [相关文章](http://blog.csdn.net/hanjiang08/article/details/78107961?locationNum=5&fps=1)
- 从官网下载最新版 `jdk & jre`(9.0.4)
- 解压到 `/usr/local`(可自定义)
- 配置环境变量  

*bash* `/etc/profile`
```bash
# Edit for Java at 2018年03月11日13:22:36
export JAVA_HOME=/usr/local/java
export JRE_HOME=/usr/local/jre
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
export JAVA_HOME JRE_HOME PATH CLASSPATH
```
*fish* `~/.config/fish/config.fish`  
**需要特别注意 `.` 需要放到引号里面, 具体请参考相关[文章](https://github.com/fish-shell/fish-shell/issues/3148) / [文档](http://fishshell.com/docs/current/index.html)**
```bash
# Set path for JAVA
set -x JAVA_HOME /usr/local/java
set -x JRE_HOME $JAVA_HOME/jre
set -x CLASSPATH $JAVA_HOME/lib $JRE_HOME/lib
set -x CLASSPATH ".:$LASSPATH"
set -x PATH $JAVA_HOME/bin $JRE_HOME/bin $PATH
```

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


