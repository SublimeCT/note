# Markdown常用语法
-------------------------------
## 1. 字体样式
**strong**
*em1*    _em2_
***strong & em***
~~delete~~

## 2. 分级标题
    # 一级标题
    ## 二级标题
    
## 3. 超链接
- 行内式
[百度](http://baidu.com)
```
[百度]("http://baidu.com" "百度一下，你就知道")
URL和标题之间有空格
```

- 参考式
学习编程经常去的网站[百度][baidu],[google][2]
[1]:https://baidu.com "百度一下，你就知道"
[2]:https://google.com
```
学习编程经常去的网站[百度][1],[google][2]
[1]:https://baidu.com "百度一下，你就知道"
[2]:https://google.com
```

- 自动链接
<https://baidu.com>
```
<https://baidu.com>
```

## 4. 列表
- 无序列表
1. 有序列表
```
- 无序列表
1. 有序列表
```
- 有序列表
1. test1
2. test2
```
1. test1
2. test2
```

- 定义型列表
PHP
:   I'm PHPer

JavaScript
:   I'm JavaScripter

```
PHP
:   I'm PHPer

JavaScript
:   I'm JavaScripter
```
## 5. 引用
>这是一首简单的小情歌

```
这是一首简单的小情歌
```

- 多层引用
>>> test3

>> test2

> test1
```
>>> test3

>> test2

> test1
```

## 6. 图片
![南拳的情歌](https://al-qn-echo-image-cdn.app-echo.com/FrdDyOz-N0Fe5QJFMOwTFAHm7g4s?imageMogr2/auto-orient/quality/100%7CimageView2/0/w/500/q/100  "南拳的情歌")
```
![南拳的情歌](https://al-qn-echo-image-cdn.app-echo.com/FrdDyOz-N0Fe5QJFMOwTFAHm7g4s?imageMogr2/auto-orient/quality/100%7CimageView2/0/w/500/q/100  "南拳的情歌")
```

## 7. 表格
语言|语言类型
-|-
PHP|动态语言
JAVA|静态语言

```
语言|语言类型
-|-
PHP|动态语言
JAVA|静态语言
```
## 8.分隔线
------------------
**********************************
```
----------------------------------
**********************************
```

## 9.代码
```PHP
// this is PHP code
echo 'This is PHP code';
if(true){
    echo 'end';
}
```



