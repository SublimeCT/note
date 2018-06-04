# [bash 环境配置](https://github.com/SublimeCT/note/tree/master/Linux/docs/shell/2.md) [:point_right: link](http://www.cnblogs.com/f-ck-need-u/p/7417651.html)

## 交互式 shell 与非交互式 shell
- 交互式: shell 接受用户输入并立即执行输入的命令
- 非交互式: shell 不与用户交互, 例如执行一个脚本

```shell
echo $- # 变量 - 中包含 i 则为交互式
echo $PS1 # 值为非空则为交互式
```

## 登录式与非登录式
...

## 加载 bash 环境配置文件
> bash 通过加载配置文件来配置运行环境, 是否交互 / 是否登录会影响配置文件的加载




