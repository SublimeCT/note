# [特殊字符 & 快捷键](https://github.com/SublimeCT/note/tree/master/Linux/docs/abs/chars.md)chars

## 快捷键
- 

## `#`
注释

## `;`
分割多条命令

```bash
echo hello; echo world

if [ -x "$filename" ]; then
    echo "File $filename exists"; cp $filename $filename.bak
else
    echo "File not found"; touch $filename
fi; echo "File test complete"
```

## `;;`
双分号, 终止 `case` 语句

```bash
case "$foo" in
abc)    echo "\$foo = abc" ;;
def)    echo "\$foo = def" ;;
esac
```

## `.`
等价于 `source`, 是 linux **内建命令**

## `\`
转义符

## ```
命令替换

## `:`
空命令, 等价于 `NOP`, 与内建命令 `true`, 作用相同， 它的 `exit code` 是 `true`

### 变量扩展 / 子串替换

```bash
: > access_log # 等价于 cat /dev/null > access_log
```

### 分隔符
```bash
$ echo $PATH
/home/sven/.yarn/bin:/usr/local/node/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/sbin:/usr/sbin
```

## `*` `?`
通配符

## ${}
参数替换

### ${parameter}
与 `$parameter` 相同

### ${parameter-default}
`parameter` 未声明时使用默认值 `default`

### ${parameter:-default}
`parameter` 未声明或为空时使用默认值 `default`

```bash
foo=
echo ${foo-undefined} # 输出为空, 因为 foo 已经定义
echo ${foo:-null} # null
```

为脚本提供一个参数默认值
```bash
DEFAULT_FILENAME=foo.bar
filename=${1:-$DEFAULT_FILENAME}
```

### ${parameter=default}
如果 `maramrter` 未定义, 则将它的值改为 `default`

### ${parameter:=default}
如果 `maramrter` 未定义或为空, 则将它的值改为 `default`

### ${parameter+default}
如果 `parameter` 已声明, 则使用 `default`

### ${parameter:+default}
如果 `parameter` 已声明或为空, 则使用 `default`

## `$*` / `$@`

### `$0` `$1`
第 `n` 个参数

### `$#`
参数个数

### `$*`
所有参数

### `$@`
所有参数, 它输出的是所有参数, 每个参数都是独立的; [`$*` 与 `$@` 的区别](https://www.cnblogs.com/5201351/p/4590811.html)

## ()
在括号中的命令列表, 将作为一个 `子 shell` 来执行

## {}

```bash
# 通配符
cp file.{png,bak} # cp file.png file.bak
```

## []
条件测试

## [[]]
测试

## -
表示 `stdin` / `stdout`

```bash
echo 'hello' | cat - # 此时的 - 表示 stdin
```
