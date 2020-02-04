# 6-条件语句实践
> 书中实例部分直接跳过了 ...

## if 语法

<!-- tabs:start -->

#### ** bash **

```bash
if [ $? -eq 0 ]; then
    echo 'hello'
elif
    echo 'probloms ...'
fi
```

#### ** fish **

```bash
if test -e /tmp/launch.log
    echo 'exists'
else
    echo 'not exists'
end
```

<!-- tabs:end -->

## 参考
- [awk 命令](https://man.linuxde.net/awk#awk%E7%9A%84%E5%B7%A5%E4%BD%9C%E5%8E%9F%E7%90%86)
- [MacOS 升级 bash 版本](https://www.jianshu.com/p/905d178f433c)