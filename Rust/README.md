# Rust

## links
- [中文官网](https://rustlang-cn.org/office/rust/book/getting-started/ch01-01-installation.html)
- [使用中科大镜像](https://www.jianshu.com/p/cf1b534dbb16)

## 基本概念
- `rustup` 是管理 `rust` 版本的工具
- [cargo](https://crates.io/) 是 `rust` 的包管理工具
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
复合类型可以将多个值组合成一个新类型

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

## [所有权](https://rustlang-cn.org/office/rust/book/understanding-ownership/ch04-01-what-is-ownership.html)
`所有权` 机制使 `rust` 无需垃圾回收即可保障内存安全 

- 复制
    - 分配在堆上的数据类型值只能通过 `clone` 复制, 因为 `rust` 中堆中的数据
    - 分配在栈上的数据类型值可以直接复制

