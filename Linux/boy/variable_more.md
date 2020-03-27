# 3-variable_more

## 特殊变量

变量 | 描述 | 说明 | `fish` 兼容写法
--- |--- |--- |---
`$0` | 当前执行的 `shell` 脚本文件路径 | 可能包含命令行中的脚本文件路径, 如 `bash a/b/c`, 则 `$0` 是 `a/b/c` | *fish 暂未找到兼容方案*
`$1` ... `$n` | 第 `n` 个参数 | 当 n > 9 时要使用 `${}` 语法 | `$argv[11]`
`$#` | 打印参数数量 | | `count $argv`
`$*` | 打印所有参数 | `"$*"` 将所有参数视为一个字符串 | `$argv`
`$@` | 打印所有参数 | `"$@"` 将所有参数视为一个集合 | `$argv`
`$?` | 打印上一个命令的执行结果 | | `$status`
`$$` | 打印当前进程 `PID` | | `$fish_pid`

<!-- tabs:start -->

#### ** bash **

[filename](scripts/variable.sh ':include :type=code shell')

#### ** fish **

[filename](scripts/variable.fish ':include :type=code shell')

<!-- tabs:end -->

## 变量子串
?> `fish shell` 中的 `string sub` 命令的 `offset` 起点是 `1`, 而 `bash` 是 `0`

<!-- tabs:start -->

#### ** bash **

[filename](scripts/variable_str.sh ':include :type=code shell')

#### ** fish **

[filename](scripts/variable_str.fish ':include :type=code shell')

<!-- tabs:end -->

## 特殊扩展变量

<!-- tabs:start -->

#### ** bash **

[filename](scripts/variable_extension.sh ':include :type=code shell')

#### ** fish **

[filename](scripts/variable_extension.fish ':include :type=code shell')

<!-- tabs:end -->

## 参考
- [seq 命令](https://man.linuxde.net/seq)
- [string 命令(fish)](https://fishshell.com/docs/current/commands.html#string)