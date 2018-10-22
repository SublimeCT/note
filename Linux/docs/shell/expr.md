4. [expr 命令](https://github.com/SublimeCT/note/tree/master/Linux/docs/shell/expr.md) [:point_right: link](http://www.cnblogs.com/f-ck-need-u/p/7231832.html)

> expr 命令可以实现数值运算 / 字符串比较、匹配、提取 ...

```bash
expr abcde : 'ab\(.*\)' # cde 使用 \(\) 匹配字符串
expr abcde : 'ab.*' # 5 不使用 \(\) 返回匹配到的字符长度
expr abcde : 'd.*' # 0 expr 是从字符串首字符开始匹配
```
