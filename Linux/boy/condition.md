# 5-条件测试与比较

语法 | 描述
--- |---
`[ ]` | 最常用的语法
`test` | 与 `[ ]` 相同
`[[ ]]` | 新语法, 可以包含通配符和二元操作符
`(( ))` |

## 常用文件测试表达式

表达式 | 全拼 | 描述
--- |--- |---
`-d` | `directory` | 是否是目录
`-f` | `file` | 是否是文件
`-e` | `exists` | 文件是否存在
`-r` | `read` | 可读
`-w` | `write` | 可写
`-x` | `executable` | 可执行
`-s` | `size` | 文件大小是否大于 `0`
`-L` | `link` file | 是否是链接文件
`file1 -nt file2` | `new then` | 用来对比文件是否比另一个文件新(判断修改时间)
`file1 -ot file2` | `old then` | 用来对比文件是否比另一个文件旧 ...

## 常用字符串测试表达式

表达式 | 全拼 | 描述
--- |--- |---
`-n` | `non-zero` | 字符串长度不为 `0`
`-z` | `zero` | 字符串长度不 `0`
`"$str1" = "$str2"` | | 对比字符串是否相等, *可以使用 `==` 代替 `=`*
`"$str1" != "$str2"` | | 对比字符串是否不相等, *不能使用 `!==` 代替 `!=`*

## 整数二元操作符

包含常用的 `eq` / `ne`  / `lt` / `gt` / `le` / `ge`

## 逻辑运算符

表达式 | 全拼 | 描述
--- |--- |---
`-a` / `&&` | `and` |
`-o` / `\|\|` | `or` |
`!` | `not` |

<!-- tabs:start -->

#### ** bash **

```bash
[ -e /tmp/launch.log ] && echo 'exists' || echo 'not exists'
# 整数判断
[ 3 -gt 2 ] && echo 'gt' || echo 'lt'
[[ 3 > 2 ]] || echo 'lt'
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

## example
读取用户输入并判断

<!-- tabs:start -->

#### ** bash **

[filename](scripts/condition.sh ':include :type=code shell')

#### ** fish **

[filename](scripts/condition.fish ':include :type=code shell')

<!-- tabs:end -->

执行结果:

```bash
➜  scripts git:(gh-pages) ✗ fish condition.fish                                13:49:15

1. install lamp
2. install lnmp
3. exit

please input the num you want:
2
2
lnmp is installed
```

## 参考
- [fish if 命令](https://fishshell.com/docs/current/commands.html#if)
