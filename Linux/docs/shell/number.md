# [算术运算](https://github.com/SublimeCT/note/tree/master/Linux/docs/shell/number.md) [:point_right: link](http://www.cnblogs.com/f-ck-need-u/p/7231870.html)

```bash
#!/bin/bash
num=100
let num+=2 # 通过 let 实现算数运算
echo $num
echo $[num+=100]
echo $((num+=100)) # 两种格式
```

## bc 命令

```bash
#!/bin/bash

# 使用 here string 方式计算
value1=`bc<<EOF
scale=3
r=3
3.1415926*r*r
EOF`

# 当结果小于 1 时返回 .x
value2=`bc<<EOF
i=0.1
i
EOF`

echo $value1
echo $value2
```
