# 函数与闭包

## 1. 标准的闭包
> `golang` 对函数式编程的支持主要体现在闭包上

```go
package main

import "fmt"

func Adder() func(int) int {
	sum := 0
	return func(num int) int {
		sum += num
		return sum
	}
}

func main() {
	counter := Adder()
	for count := 0; count < 10; count++ {
		fmt.Println("total: ", counter(count))
	}
}
```

### 正统的函数式编程
- 不可变性: 不能有状态, 只能包含常量和函数
- 函数只有一个参数
- *go 语言对函数式编程没有严格的规定*

```go
type iAdder func(int) (int, iAdder)

func Adder2 (num int) iAdder {
	return func(v int) (int, iAdder) {
		return num + v, Adder2(num + v)
	}
}

func main() {
	counter := Adder2(0)
	for count := 0; count < 10; count++ {
		var sum int
		sum, counter = counter(count)
		fmt.Println("total: ", sum)
	}
}
```

## demo-1 斐波那契数列
> 函数是一等公民, 可以为函数实现接口

```go
func fibonacci() intGen {
	a, b := 0, 1
	return func() int {
		a, b = b, a + b
		return a
	}
}

type intGen func() int

// 使 intGen 实现 io.Reader 接口
func (ig intGen) Read(p []byte) (n int, err error) {
	next := ig()
	if next > 10000 {
		return 0, io.EOF
	}
	s := fmt.Sprintf("%d\n", next)
	return strings.NewReader(s).Read(p)
}

// 通过实现 io.Read 接口的 reader 读取内容
func printFileContents (reader io.Reader) {
	scanner := bufio.NewScanner(reader)
	for scanner.Scan() {
		fmt.Println(scanner.Text())
	}
}

func main() {
	fil := fibonacci()
	printFileContents(fil)
}
```
