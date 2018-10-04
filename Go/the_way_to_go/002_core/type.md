# [基本结构和基本数据类型](https://github.com/SublimeCT/note/blob/master/Go/the_way_to_go_docs/002_core/type.md)

## 包
> 如果对一个包进行更改或重新编译，所有引用了这个包的客户端程序都必须全部重新编译

alias
```go
import f "fmt"
```

## iota 枚举
```go
package main

import (
	"fmt"
)

const (
	Red = iota + 100
	Blue
	Yellow
)

func main() {
	fmt.Printf("Red: %d\n", Red)
	fmt.Printf("Blue: %d\n", Blue)
	fmt.Printf("Yellow: %d\n", Yellow)
}
```

## strings / strconv 包
- `strings.HasPrefix(s, prefix string) bool`
- `strings.HasSuffix(s, Suffix string) bool`
- `strings.Contains(s, substr string) bool`
- `strings.Repeat(s, count int) string`
- `strings.Split(s, sep string) []string`
- `func Join(a []string, sep string) string`
- `strings.Index`
- `strings.LastIndex`
- ...

## 时间和日期格式化
> [关于 time.Format](http://docs.studygolang.com/pkg/time/#Time.Format)

```go
func main () {
    fmt.Println("time: ", time.Now().Format("2006-01-02 15:04:05"))
}
```

## 指针 * 反引用操作符

```go
func main () {
    str := "music: 怪物史莱克 You Belong To Me"
	strPtr := &str
	fmt.Println("str ", str)
	fmt.Printf("strPtr: %p; now, change this var\n", strPtr)
	*strPtr = "modifyed !!!"
	fmt.Println("str ", str)
}
```

```bash
str  music: 怪物史莱克 You Belong To Me
strPtr: 0xc4200801c0; now, change this var
str  modifyed !!!
```