# interface

## 1. 定义
> 接口的实现是隐式的, 只要实现接口里的方法就可以了  
接口变量中包含实现者的类型和实现者的值(或指针)

- 使用者 `download`
- 实现者 `retriever`

retriever/real/retriever.go
```go
package real

import (
	"net/http"
	"net/http/httputil"
	"time"
)

// 定义结构, 只需实现使用者定义的 interface 中的方法
type Retriever struct {
	UserAgent string
	TimeOut   time.Duration
}

func (r Retriever) Get(url string) string {
	resp, err := http.Get(url)
	if err != nil {
		panic(err)
	}

	bytes, e := httputil.DumpResponse(resp, true)
	resp.Body.Close()
	if e != nil {
		panic(err)
	}

	return string(bytes)
}

```

retriever/main.go
```go
package main

import (
	"fmt"
	real2 "yunss.com/sven/impression/retriever/real"
)

// 定义 Retriever 接口
type Retriever interface {
	Get(url string) string
}

// 由使用者通过接口限定参数类型
func download(r Retriever) string {
	return r.Get("http://www.imooc.com")
}

func main() {
    // 定义接口变量
	r := real2.Retriever{}
	fmt.Println(download(r))
}
```

## 2. 类型断言
> [article](https://studygolang.com/articles/3314)

直接断言
```go
// 表示任意类型
var v interface{}
v = "Hello"
if value, ok := v.(int); ok {
    fmt.Println(value)
} else {
    fmt.Println("not int")
}
```

通过 `switch` 断言
```go
var v interface{}
v = "Hello"
switch t := v.(type) {
case string:
    fmt.Println("string -> ", t)
case int:
    fmt.Println("int -> ", t)
}
```

## 3. 特殊接口
- Stringer `fmt/print.go`
- Writer
- Reader

```go
type StringBox struct {
	Contents string
}
// 创建 String 方法实现 Stringer 接口
func (sb StringBox) String() string {
	return sb.Contents
}
```
