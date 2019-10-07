# Rust

## links
- [API document](https://doc.rust-lang.org/std/)
- [中文官网](https://rustlang-cn.org/office/rust/book/getting-started/ch01-01-installation.html)
- [使用中科大镜像](https://www.jianshu.com/p/cf1b534dbb16)
- [Cargo 仓库](https://docs.rs/)

## 基本概念
- `rustup` 是管理 `rust` 版本的工具
- [cargo](https://crates.io/) 是 `rust` 的包管理工具
- `package` 表示 `cargo new package_name` 创建的项目, 一个 `package` 中至少有一个 `crate` / `lib`
    - ``
    - `cargo`
        - `crate` 是一个模块的树形结构
        - `crate root` crate 根: `src/main.rs` / `src/lib.rs`
- `trait`

## 开发规范
- `rust` 中的变量和函数名都使用小写字母加下划线命名

## Install
0. 配置环境变量
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
5. 配置 `cargo` 镜像

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
- `移动`: *对于在堆上的数据, 数据的 `所有权` 在将值赋给另一个变量时被移动(给新的变量)*
- `克隆`: *对于在堆上的数据, 可以通过 `.clone()` 克隆一份数据*
- `拷贝`: *对于在栈上的数据, 在将值赋给另一个变量时数据将被拷贝*

### 引用
使用 `&foo` 表示 `foo` 的引用

- `可变引用`: `&mut foo`, 在一个作用域中只能有一个可变引用, 以此解决 **数据竞争** 问题
- `不可变引用`: `&foo`, 不可变引用可以存在多个, 但不能与 `可变引用` 同时存在

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
### `String`
### `hash map`

