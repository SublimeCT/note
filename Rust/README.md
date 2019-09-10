# Rust

## links
- [中文官网](https://rustlang-cn.org/office/rust/book/getting-started/ch01-01-installation.html)
- [使用中科大镜像](https://www.jianshu.com/p/cf1b534dbb16)

## 基本概念
- `rustup` 是管理 `rust` 版本的工具
- `cargo` 是 `rust` 的包管理工具

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
```

## cargo
`cargo` 作为 `rust` 的构建系统和包管理器

