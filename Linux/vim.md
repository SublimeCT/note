# Vim
> Vim 是一个支持高度自定义的 **模式化文本编辑器**

![Vim 快捷键](http://www.runoob.com/wp-content/uploads/2015/10/vi-vim-cheat-sheet-sch1.gif)

## 资源
- [Vim galore 中文翻译](https://github.com/wsdjeg/vim-galore-zh_cn)
- [如何学习 vim](https://zhuanlan.zhihu.com/p/34936917)
- [:hammer:space vim](https://spacevim.org/cn/)

## 模式
- `normal` 缺省的编辑模式; 通过 `Esc` / `ctrl+[` 返回正常模式
- `command` 用于执行命令; `normal` 模式下输入 `:` 进入 `command` 模式
- `insert` 输入文本时使用; 输入 `a`(append) `i`(insert) 进入
    - `a` 光标后面
    - `A` 当前行行尾
    - `i` 光标前面
    - `I` 当前行行首
    - `o` 当前行下面开辟新行
    - `O` 当前行上面开辟新行
    - `s` 删除光标后面的字符
    - `S` 删除当前行
- `visual` 用于选定文本块; `v` 按字符选定 `V` 按行选定　`ctrl+V`　按块选定

## 快捷键
### 移动位置
- `kjhl` 移动方向
- `0` 行首
- `$` 行尾
- `gg` 顶部
- `G` 底部
- `22G` 跳转到第 `22` 行
- `w` 向后移动一个单词的位置
- `b` 向后移动一个单词的位置

### 字符操作
- `x` 删除光标后面的字符
- `X` 删除光标前面的字符
- `dw` 从光标位置删除后面的一块内容
- `d0` 删除到行首
- `D` / `d$` 删除到行位
- `dd` 删除一行
- `ndd` 删除多行, `n` 为行数
- `>>` / `<<` 缩进

### 撤销操作
- `u` 撤销
- `ctrl+r` 反撤销

### 复制
- `yy` 复制行
- `nyy` 复制 `n` 行
- `p` 粘贴到下一行
- `P` 粘贴到上一行

### 查找
- `/string` 由光标位置向下查找
- `?string` 由光标位置向上查找
- `#` 搜索光标所在块

## 替换
- `:s/马/horse` 将当前行的首个 `马` 替换为 `horse`
- `:s/马/horse/g` 将当前行的所有 `马` 替换为 `horse`
- `:%s/马/horse` 将所有行的首个 `马` 替换为 `horse`
- `:%s/马/horse/g` 将当前行的所有 `马` 替换为 `horse`
- `:20,30s/马/horse/g` 将 `20-30` 行的所有 `马` 替换为 `horse`

## 执行命令
`!pwd` 输入 `!` 执行命令

## 分屏
- `sp` 水平分屏
- `vsp a.md` 垂直分屏并打开文件



