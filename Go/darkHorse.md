# 《build web application with golang》

## links
- [目录](https://github.com/astaxie/build-web-application-with-golang/blob/master/zh/preface.md)

## 环境变量
### GOPATH
`GOPATH` 为工作目录

```bash
export GOPATH=/home/xxx/project/go_project
```

## 目录结构
> `$GOPATH/src` 就是开发目录; 每一个项目建立一个目录

- `src` 源码文件
- `pkg` 编译后文件, 如 `.a` 文件
- `bin` 比那以后的可执行文件

```bash
➜  go_project tree
.
├── bin
│   └── hello
├── pkg
└── src
    └── hello.go
```
