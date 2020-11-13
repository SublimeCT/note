# Rust 中的字符串

![](https://upload-images.jianshu.io/upload_images/15688561-40f34710abc66d1c.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/812/format/webp)

## String

`Rust` 会将 `String` 对象存储到栈上:

```
                     buffer(指向缓冲区的堆分配指针)
                   /   capacity(容量)
                 /   /  length(数据长度)
               /   /   /
            +–––+–––+–––+
stack frame │ • │ 8 │ 6 │ <- my_name: String
            +–––+–––+–––+
```

对应的堆中的数据:

```
            buffer 指针
              |
              |
            +–V–+–––+–––+–––+–––+–––+–––+–––+
       heap │ P │ a │ s │ c │ a │ l │   │   │
            +–––+–––+–––+–––+–––+–––+–––+–––+
```

- `String` 类型的值固定为 `3` 个字节长度
- `&String` 的结构表示: `&String ---> String(buffer, capacity, length) ---> heap(buffer)`
- 当要改变缓冲区的内容时, 会重新申请缓冲区大小, *如 `push_str("foo")` 时*

## str
字符串 `slice` 是引用其他字符串(`String` / `str`)的引用

```rust
let label = String::from("Hello, World");
println!("{}", &label[7..]); // > World
```

字符串切片的引用(`&str`)在栈和堆中的存储结构:

```
         friend_name: String   last_text: &str
            [––––––––––––]    [–––––––]
            +–––+––––+––––+–––+–––+–––+
stack frame │ • │ 32 │ 20 │   │ • │13 │ 
            +–│–+––––+––––+–––+–│–+–––+
              │                 │
              │                 +–––––––––+
              │                           │
              │                           │
              │                         [–│––––––––––––––––––––– str –––––––––––––––––––––––]
            +–V–+–––+–––+–––+–––+–––+–––+–V–+–––+–––+–––+–––+–––+–––+–––+–––+–––+–––+–––+–––+
       heap │ l │ a │ o │ t │ i │ e │   │ s │ h │ u │ a │ n │ g │   │ j │ i │   │ 6 │ 6 │ 6 │ 
            +–––+–––+–––+–––+–––+–––+–––+–––+–––+–––+–––+–––+–––+–––+–––+–––+–––+–––+–––+–––+
```

- 其中 `13` 表示长度
- `&str` 没有在栈上存储容量信息, 是可以自己管理容量的 `String` 对象的引用
- `str` 的大小是不确定的, 因为堆是动态分配的(随时准备申请缓冲区大小)
- 但是 `&str` 的大小是确定的, 因为 `&str` 只是一个地址
- **实际上, 字符串切片永远是引用, 并且是只读的**

## 字符串字面量

- 字符串字面量是 `&str`
- 字符串字面量作为可执行文件的一部分保存在 `read-only` 内存中; *换句话说, 这是程序附带的内存, 不依赖堆分配的缓冲区*

## 应该使用哪种类型

如果在作用域中不依赖于这个字符串 或者 不需要改变字符串 应该使用 `&str`

## refer
- [(原文)Rust: String vs &str](https://blog.thoughtram.io/string-vs-str-in-rust/)
- [(译文)Rust: String vs &str](https://www.jianshu.com/p/d2d0eebc9575)
