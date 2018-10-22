# 资源管理与错误处理

## 1. [defer](https://blog.csdn.net/qwertyupoiuytr/article/details/55224156)
> defer 被用来延迟执行函数, 直到函数体内 `return` 之前才会执行, 包含多个 `defer` 函数时为栈结构

```go
package main

import (
	"bufio"
	"fmt"
	"os"
	"yunss.com/xxx/impression/fibonacci/fib"
)

func writeFile(fileName string) {
	file, err := os.Create(fileName)
	if err != nil {
		panic(err)
	}
	defer file.Close()
	writer := bufio.NewWriter(file)
	defer writer.Flush()
	f := fib.Fibonacci()
	for i := 0; i < 70; i++ {
		fmt.Fprintln(writer, f())
	}
}

func main() {
	writeFile("defer/fib.txt")
}
```

## 2. 错误处理
> 对已知类型的错误进行自定义处理, 未知错误 panic

```go
func writeFile(fileName string) {
	// 直接调用 OpenFile 自定义 flag, os.O_EXCL: 如果文件存在则报错
	file, err := os.OpenFile(fileName, os.O_EXCL|os.O_CREATE, 0666)
	// 错误处理
	if err != nil {
		// 判断 err 类型, 如果是 PathError 则自定义把报错信息, 否则 panic
		// If there is an error, it will be of type *PathError.
		if pErr, ok := err.(*os.PathError); ok {
			fmt.Printf("file already exists: \n\t %s, %s, $s", pErr.Op, pErr.Path, pErr.Err)
		} else {
			panic(err)
		}
		return
	}
	defer file.Close()
	writer := bufio.NewWriter(file)
	defer writer.Flush()
	f := fib.Fibonacci()
	for i := 0; i < 70; i++ {
		fmt.Fprintln(writer, f())
	}
}
```

### 自定义错误类型

```go
type CustomError struct {
	errorMsg string
}

func (customErr *CustomError) Error() string {
	return customErr.errorMsg
}

func customErr() {
	err := errors.New("This is custom error")
	fmt.Println(err.Error())
}

func main() {
	customErr()
}
```

### demo-1 统一错误处理
启动 http 服务器, 统一处理错误

```go
package main

import (
	"net/http"
	"os"

	"github.com/gpmgo/gopm/modules/log"
	"yunss.com/sven/impression/defer/file_server/listener"
)

type handleFun func(writer http.ResponseWriter, request *http.Request, conf *listener.WebConfig) error

func beforeListen() *listener.WebConfig {
	return &listener.WebConfig{"/files/", ":10000"}
}

// 函数式编程
// handleFun 中只需要返回 err
// 包装 handleFun 统一并处理错误
func errorWraper(handle handleFun, conf *listener.WebConfig) func(http.ResponseWriter, *http.Request) {
	return func(writer http.ResponseWriter, request *http.Request) {
		err := listener.HandleFun(writer, request, conf)
		if err != nil {
			log.Warn("Error handling request ... %s", err.Error())
			code := http.StatusOK
			switch {
			case os.IsNotExist(err):
				code = http.StatusNotFound
			case os.IsPermission(err):
				code = http.StatusForbidden
			default:
				code = http.StatusInternalServerError
			}
			http.Error(writer, http.StatusText(code), code)
		}
	}
}

func main() {
	conf := beforeListen()
	http.HandleFunc(conf.BasePath, errorWraper(listener.HandleFun, conf))
	err := http.ListenAndServe(conf.Addr, nil)
	if err != nil {
		panic(err)
	}
}
```

## 2. panic / recover

`panic` 会停止当前函数执行, 并向上返回, 执行每一层的 `defer`, 如果没有 `recover` 则退出

`recover` 是一个函数, 返回 `panic` 返回值, 只能在 `defer` 中使用, 无法处理错误可以重新 `panic`

```go
func tryRecover() {
	// 这是一个自执行函数
	defer func() {
		// 获取 panic 值
		if rErr := recover(); rErr != nil {
			fmt.Println("recover value", rErr)
			if err, ok := rErr.(error); ok {
				fmt.Println("Error occurred: ", err)
			} else {
				panic(rErr)
			}
		}
	}()

	panic(errors.New("TODO"))
}

func main() {
	tryRecover()
}
```