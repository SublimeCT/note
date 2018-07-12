# 《build web application with golang》

## links
- [目录](https://github.com/astaxie/build-web-application-with-golang/blob/master/zh/preface.md)

## 环境变量
```bash
# Set path for Go
set -x GOPATH /home/xxx/project/go_demo
set -x GOROOT /usr/local/go
set -x GOARCH amd64
set -x GOOS linux
set -x PATH $GOROOT/bin $GOPATH/bin $PATH
```

### GOPATH
`GOPATH` 为工作目录

```bash
export GOPATH=/home/xxx/project/go_project
```

## 目录结构
> `$GOPATH/src` 就是开发目录; 每一个项目建立一个目录

- `src` 源码文件
- `pkg` 编译后文件, 如 `.a` 文件
- `bin` 编译后的可执行文件

```bash
➜  go_project tree
.
├── bin
│   └── hello
├── pkg
└── src
    └── hello.go
```

## 编译安装应用包
在应用包目录安装

```bash
➜  mymath go install
```

任意目录安装

```bash
➜  xxx go install mymath
```

调用应用包

```go
package main

import (
	"mymath", // 调用 mymath 包, 相对于 $GOPATH/src 路径
	"fmt"
)

func main () {
	fmt.Printf("Hello World. Sqrt(2) = %v\n", mymath.Sqrt(2))
}
```

编译程序
```bash
➜  xxx go build main.go
```

安装 mathapp
```bash
➜  mymath go install
```

执行 mathapp
```bash
➜  mathapp mathapp
Hello World. Sqrt(2) = 1.414213562373095
```

## 远程包
获取远程包
```bash
go get github.com/astaxie/beedb
```

调用远程包
```bash
import "github.com/astaxie/beedb"
```


