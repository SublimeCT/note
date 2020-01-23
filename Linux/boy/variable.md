# 2-variable

## 变量分类
?> 系统变量全局范围生效, 普通变量仅在创建它们的 `shell` 环境生效

- 环境变量(全局变量)
    - `bash` 内置环境变量
    - 自定义环境变量
- 普通变量(局部变量)

## 查看变量
```bash
# 查看所有变量
set
# 查看环境变量
env
# 查看所有变量 / 函数 / 整数 / 已导出的变量
declare
```

## 设置变量

环境变量:

<!-- tabs:start -->

#### ** bash **

```bash
# 定义
export NAME=Sven
# 添加全局变量
echo 'export NAME=Sven' >> ~/.bashrc

```

#### ** fish **

```bash
# 定义
set -x NAME Sven
# 添加全局变量
echo 'export NAME=Sven' >> ~/.config/fish/config.fish
# 设置变量并使其在所有 fish shell 中可访问
set -Ux NAME Sven
```

<!-- tabs:end -->

局部变量:

?> 定义变量并使用双引号是最常用的使用场景

<!-- tabs:start -->

#### ** bash **

```bash
a=hello $SHELL      # hello /usr/local/bin/fish
b='hello $SHELL'    # hello $SHELL
c="hello $SHELL"    # hello /usr/local/bin/fish

d=${NAME}_book      # 当变量后需要连接其他字符时应该使用 `${}` 语法
```

#### ** fish **

```bash
set a hello $SHELL      # hello /usr/local/bin/fish
set b 'hello $SHELL'    # hello $SHELL
set c "hello $SHELL"    # hello /usr/local/bin/fish

set d {$NAME}_book      # 当变量后需要连接其他字符时应该使用 `{}` 语法
```

<!-- tabs:end -->


## 删除变量
<!-- tabs:start -->

#### ** bash **

```bash
unset NAME
```

#### ** fish **

```bash
set -e NAME
```

<!-- tabs:end -->

## 将命令执行结果作为值插入到脚本中

<!-- tabs:start -->

#### ** bash **

```bash
timestamp=$(date +%s)
timestamp=`date +%s`
```

#### ** fish **

```bash
set timestamp (date +%s)
```

<!-- tabs:end -->

## 环境变量初始化文件
![](../../../assets/images/bash_load.png)

