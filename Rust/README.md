# Rust

## links
- [API document](https://doc.rust-lang.org/std/)
- [rust 程序设计语言](https://github.com/KaiserY/trpl-zh-cn)
- [rust 程序设计语言(国内站点)](http://120.78.128.153/rustbook/foreword.html)
- [rust 程序设计语言(github page)](https://kaisery.github.io/trpl-zh-cn/ch04-01-what-is-ownership.html)
- ~~[中文官网](https://rustlang-cn.org/office/rust/book/getting-started/ch01-01-installation.html)~~, 已失效
- [使用中科大镜像](https://www.jianshu.com/p/cf1b534dbb16)
- [Cargo 仓库](https://docs.rs/)

## 基本概念
- 工具链
    - `rustup` 是管理 `rust` 版本的工具
    - [cargo](https://crates.io/) 是 `rust` 的包管理工具
- 模块化
    - `crate` 是 `rustc` 编译器的编译起点
    - `package`
- 特性
    - `trait`

## 模块化
每个项目中至少包含一个 `cargo`, 编译器将以 `crate` 为起点编译

类型 | 路径 | 数量
--- |--- |---
`library crate` | `src/lib.rs` | 最多包含一个
`binary crate` | `src/main.rs` | 可以包含任意多个

src/lib.rs
```rust
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist () {}
    }
}
// 使用 `use` 将模块引入作用域
use crate::front_of_house::hosting;
// 也可以使用相对路径
// use front_of_house::hosting;
fn main () {
    hosting::add_to_waitlist();
}
```

## 开发规范
- `rust` 中的变量和函数名都使用小写字母加下划线命名

## Install and configure
1. 配置环境变量
```bash
# Set path for Rust
set -x RUSTUP_DIST_SERVER https://mirrors.ustc.edu.cn/rust-static
set -x RUSTUP_UPDATE_ROOT https://mirrors.ustc.edu.cn/rust-static/rustup
set -x PATH $HOME/.cargo/bin $PATH
```

1. 下载 `rust-init.sh`

```bash
curl -o rust-init.sh https://sh.rustup.rs
```

2. 替换其中的 `RUSTUP_UPDATE_ROOT`
3. `sh ./rust-init.sh`
4. 将 `$HOME/.cargo/bin` 添加到环境变量中
5. **配置 `cargo` 镜像**

`$HOME/.cargo/config`

```toml
[source.crates-io]
registry = "https://mirrors.ustc.edu.cn/crates.io-index"
replace-with = 'ustc'

[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"
```

## 目录结构
- `src` 源码目录
- `target` 编译后的文件
- `Cargo.toml` 项目配置文件
- `Cargo.lock` 类似 `yarn.lock`

## cli
```bash
# rust
rustc main.rs # 编译 rust 文件

# cargo
cargo new project_name # 创建新项目
cargo build # 构建项目, 将会在 `target/debug` 生成可执行文件
cargo build --release # 构建 `release` 项目, 将会在 `target/release` 生成可执行文件
cargo run # 编译并运行可执行文件
cargo check # 检测项目是否可编译
cargo doc --open # 构建 document(包含依赖包文档)
```

## cargo
`cargo` 作为 `rust` 的构建系统和包管理器

### install

添加项目依赖
```toml
[dependencies]
rand = "0.3.14"
```

```bash
cargo build
```

## 语法

### 基本语法 / 变量
```rust
use std::io; // 引入标准库中的 io

fn main() { // fn 声明函数; main 为入口函数

    /// 创建变量(默认为不可变)
    let guess1 = "hello";
    // 使用 `mut` 创建可变变量
    // String::new 表示 new 是 String 的关联函数, 关联函数是针对类型实现的, 对应其他预言中的静态方法
    let mut guess2 = String::new();
    /// 创建(编译时)常量
    const MAX_PORINTS: u32 = 100_100; // 常量必须声明类型, 并且是编译时常量

    /// 原始标识符
    let r#fn = "raw indentifier";

    /// 占位符
    // {} 表示占位符, `println!` 是一个在屏幕上打印字符串的宏
    println!("x={}, y={}", x, y);

    /// 循环 1
    let mut count = 0
    let foo = loop {
        count++;
        if count == 10 {
            break count * 2;
        }
    }
    /// 循环 2
    while count == 10 {
        count++;
    }
    /// 循环 3
    let arr = [1,2,3,4,5]
    for element in arr.iter() {
        println!("value: {}", element);
    }
    /// 循环 4
    for number in (1..4).rev() {
        println!("{}!", number);
    }

    /// slice 类型
    /// 字面量字符串就是 slice 类型, slice 类型不获取所有权
    let foo = "Hello World";
    // baz(str: &str) -> &str
    baz(&foo[..]); // 与 baz(&foo) 一样
    baz(&foo[0..5]); // Hello
    baz(&foo[6..]); // World

    /// 枚举类型
    enum IpAddrKind {
        V4(u8, u8, u8, u8),
        V6(String) // 包含关联数据的成员
    }
    let ip4 = IpAddrKind::V4(192, 169, 123, 321)
    enum Message {
        Quit,
        Move { x: i32, y: i32 }, // 匿名结构体
        Write(String),
        ChangeColor(i8, i8, i8)
    }
    impl {
        fn call(&self) {
            // ...
        }
    }

    /// 空值
    let some_number = Some(5);
    let absent_number: Option<i32> = None;

    /// 通配符
    let num = 3
    match num {
        1 => println!("val: 1"),
        2 => println!("val: 2"),
        _ => () // _ 会匹配所有值
    }

    /// Vector
    let v = Vec::new();
    let mut v2 = vec![1, 2, 3]; // 使用 vec! 宏
    v.push(4); // 增加 item
    // 获取 item
    let _first: &i32 = &v[0]; // 1. 通过 & [] 方式获取
    // 2. 通过 `get()` 获取
    match v.get(0) {}
        Some(_first) => println!("first is 1"),
        None => println!("first not found")
    }
    /// 遍历元素
    for i in &mut v {
        *i += 10;
    }
    /// 使用枚举存储多种类型
    enum People {
        Point(i32, i32),
        Name(String)
    }
    let p = vec![People::Point(1, 2)];

    /// String 类型: 可增长 / 可变 / 有所有权 / UTF-8 编码的字符串类型
    let s = String::new();
    let mut ss = String::from("Hello");
    let s1 = "test"; // 声明 str 类型
    s = s1.to_string(); // str 转为 String
    ss.push_str(" World"); // 附加字符串 slice
    ss.push("."); // 附加单个字符
}

/// 函数
fn sum (x: i8, y: i8) -> i32 {
    x + y // 结尾没有分号时作为返回值
}
```

### match
`match` 表达式由分支 `arms` 组成; 分支开头为模式 `pattern`

```rust
let guess: u32 = match guess.trim().parse() {
    Ok(number) => number,
    Err(_) => {
        println!("Please type a number");
        continue;
    }
};
```

### mut 与 shadow
rust 中允许重复声明变量, 重复声明后之前的重名变量将被销毁, 取而代之的是新声明的 count

```rust
let count = "";
let count = 0;
```

但是使用 `mut` 声明时不能改变变量的类型

```rust
let mut count = "";
count = 0; // Error
```

## 数据类型
`标量类型` 中所有的类型都是 `Copy trait`; 在复合类型中, `tuple` 的子项中如果包含非标量类型, 则不是 `Copy trait`

### 所有的字符数据类型
- `字符编码`: 在计算机中存储数据 `0100_0001` 来标识字符 `'A'`, 这种映射关系就是 `字符编码`
- [UTF-8](https://blog.csdn.net/qq_43043859/article/details/89510121) 编码使用最广泛
    - 因支持绝大多数字符
    - 通过特定的编码规则实现可变长度来节省空间
    - 基于特定编码规则实现了避免传输时误判问题

类型 | 存储位置 | 长度 | 是否固定长度 | 写法 | 
--- |--- |--- |--- |---
`char` | `stack `| 4 `byte` | y | `let s = 'R'`
`&str` | `Stack` | _ | y | `let s = "Rust"`
`String` | `Heap` | _ | n | `let s = String::from("Rust")`

### 标量类型

- 整型
    - `i8` / `u8` / `i16` / `u16` / `i32`(默认) / `u32` / `i64` / `u64` / `isize` / `usize`
    - `isize` / `usize` 长度依赖计算机架构
- 浮点型
    - `f32` / `f64`(默认)
- boolean
- char

```rust
const name: char = 'sven'; // char 类型使用单引号
```

### 复合类型
复合类型可以将多个值组合成一个新类型, 复合类型的数据存储在栈上

- `tuple` 元组

```rust
// let x: (i32, f64, u8) = (500, 6.4, 1);
let tup = (500, 6.4, 1);
// 解构
let (x, y, z) = tup;
// 直接访问
let five_hundred = x.0
println!("x: {}, y: {}", x, y);
```

- `array` 数组

```rust
// 数组的长度固定, 且子项类型相同, 使用 [type; count] 声明
let a: [i32; 5] = [1, 2, 3, 4, 5];
```

## [所有权](https://rustlang-cn.org/office/rust/book/understanding-ownership/ch04-01-what-is-ownership.html#%E6%89%80%E6%9C%89%E6%9D%83%E4%B8%8E%E5%87%BD%E6%95%B0)
`所有权` 机制使 `rust` 无需垃圾回收即可保障内存安全 

`所有权` 规则:
1. 每一个值都有一个被称为 `所有者` 的变量
2. 值有且只有一个 `所有者`
3. `所有者` 离开作用域后这个值将被丢弃


### 变量与数据的交互方式

1. 数据移动
```rust
let x = 5;
let y = x;
```

```rust
let x = String::from("Rust"); // String 类型
let y = x;
// println!("x is {}", x); // error[E0382]: use of moved value: `x`
```

![](https://kaisery.github.io/trpl-zh-cn/img/trpl04-04.svg)

### 变量与数据的交互方式
- `移动`: *对于在堆上的数据, 数据的 `所有权` 在将值赋给另一个变量时被移动(给新的变量)*
- `克隆`: *对于在堆上的数据, 可以通过 `.clone()` 克隆一份数据*
- `拷贝`: *对于在栈上的数据, 在将值赋给另一个变量时数据将被拷贝*

### 引用
使用 `&foo` 表示 `foo` 的引用

- `可变引用`: `&mut foo`, 在一个作用域中只能有一个可变引用, 以此解决 **数据竞争** 问题
- `不可变引用`: `&foo`, 不可变引用可以存在多个, 但不能与 `可变引用` (在特定的作用于中)同时存在

### 借用
使用 `引用` 作为函数参数称为 **借用**

## Slice 切片类型
`slice` 是对集合中片段的引用

![](http://120.78.128.153/rustbook/img/trpl04-06.svg)

## structure
```rust
struct User {
    username: String,
    email: String,
    sign_in_count: u64,
    active: bool,
}

impl User {
    // 定义成员方法
    fn say(&self) {
        println!("Hello I'm {}", self.username);
    }
    // 定义静态方法
    // @description 关联函数(静态方法) 是不以 `&self` 作为参数的函数, 例如 `String::from()`
    // @emample User::outline_user(username, email)
    fn outline_user(username: &String, email: &String) -> User {
        User {
            username,
            email,
            sign_in_count: 0,
            active: false
        }
    }
}

let user1 = User {
    email: String::from("someone@example.com"),
    username: String::from("someusername123"),
    active: true,
    sign_in_count: 1,
}

let user2 = User {
    email: String::from("another@example.com"),
    username: String::from("anotherusername567"),
    ..user1 // 此处只复用了 user1 中 user2 没有声明的属性
}

/// tuple structure 
struct Color (u8, u8, u8);
```

## 集合类型
集合类型表示多个值, 且值是存到堆上的, 所以长度没有限制

### `vector`
可以存储多个相同类型的值, **可以使用 `枚举` 来实现存储多类型值**

```rust
let mut v = vec![1, 2, 3];
v.push(4);
v.get(2); // 3
v.get(100); // None, rust 认为这是正常情况, 返回 None
&v[100]; // panic, rust 认为这是严重错误

for item in &mut v { // 遍历 Vector
    *item += 10; // 在修改 Vector 中的可变引用指向的值时需要先解引用
}
```

```rust
let mut v = vec![]
```

### `String`
`String` 实际上是字节的集合, 并提供了一些实用的方法

```rust
// 遍历每个字
for c in "नमस्ते".chars() {
    println!("{}", c);
}
// 遍历每个字节
for b in "नमस्ते".bytes() {
    println!("{}", b);
}
```

### `HashMap`
`HashMap` 是键和值类型相同的结构

统计单次数量
```rust
use std::collections::HashMap;

fn main() {
    let text = "Hello world wonderful world";
    let mut word_stat = HashMap::new();
    for word in text.split_ascii_whitespace() {
        let count = word_stat.entry(word).or_insert(0);
        *count += 1;
    }
    println!("word stat: {:?}", word_stat);
}
```

## 错误处理
- `panic!`
- `Result`

通过 `Result` 处理文件打开错误
```rust
use std::fs::File;
use std::io::ErrorKind;

fn main() {
    let file_name = "hello.log";
    let f = File::open(file_name);
    let f = match f {
        Ok(file) => file,
        Err(err) => match err.kind() {
            ErrorKind::NotFound => match File::create(file_name) {
                Ok(file) => file,
                Err(err) => panic!("Problem create the file {:?}", err),
            },
            _ => panic!("Problem opening the file {:?}", err),
        }
    };
}
```

直接调用 `panic` 并提供 `message`
```rust
let f = File::open("hello.log").expect("Problem opening hello.log");
let f = File::open("hello.log").unwrap(); // 不提供 message
```

传播错误
```rust
fn foo () -> Result<String, io::Error> {
    // ...
    let mut s = String::new();
    File::open("hello.log")?.read_to_string(&mut s)?;
    // ...
}
```

## trait
```rust
pub trait Summary {
    fn summarize(&self) -> String {
        // 作为默认实现, 只有函数签名时必须实现
        return String::from("read more ...");
    }
}

pub struct NewsArticle {
    pub author: String,
    pub title: String,
    pub content: String,
}

impl Summary for NewsArticle {
    fn summarize(&self) -> String {
        return format!("{} - {}", self.title, self.author);
    }
}

// 普通实现方式 - impl
// fn notify(article: &impl Summary) {
//     println!("Breaking news => {}", article.summarize());
// }

// trait bounds 实现方式(即范型格式) - <T: Summar>
fn notify<T: Summary>(article: &T) {
    println!("Breaking news => {}", article.summarize());
}
// // trait bounds 使用 where 从句 - <T: Summar>
// fn notify<T>(article: &T) where T: Summary {
//     println!("Breaking news => {}", article.summarize());
// }

fn main() {
    let news = NewsArticle {
        author: String::from("Jinping Xi"),
        title: String::from("The Chinese Dream"),
        content: String::from("zzzzzzzzzzzzzzzzzzz"),
    };
    println!("news: {}", news.summarize());
}
```

标准库为任何实现了 `Display` `trait` 的类型实现了 `ToString` `trait`
```rust
impl<T: Display> ToString for T {
    // ...
}
```

## lifetime 生命周期
`rust` 中每个引用都有其生命周期(即引用保持有效的作用域), **借用的生命周期不能长于出借方的生命周期**, 通过生命周期确保了不会出现悬垂引用

- `输入生命周期`: 函数参数的生命周期
- `输出生命周期`: 函数返回值的生命周期

```rust
// 泛型生命周期
fn longest<'a>(first: &'a str, second: &'a str) -> &'a str {
    // Error: 若返回值与输入参数没有关联, 生命周期标注将毫无意义
    // return String::from("abc");
    if first.len() > second.len() { first } else { second }
}

// 静态生命周期, 在整个程序执行期间都有效
let s: &'static str = "hello";
```






