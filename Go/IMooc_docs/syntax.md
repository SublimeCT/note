# 基础语法

## 1. 变量定义
```golang
package main

// 使用 var 定义变量
// 可在包内和函数内使用
var num int
// 使用 var 赋初始值
var email, name string = "123@qq.com", "Jim"
// 使用 var 集中定义变量
var (
    email = "123@qq.com"
    name = "Jim"
)
// 让编译器自动决定变量类型
var name, age, email = "Jim", 22, "123@qq.com"

// 使用 := 代替 var
// 只能在 func 内使用
name, age email := "Jim", 22, "123@qq.com"
```

## 2. 内建变量类型
> [GO 中的数据类型](https://studygolang.com/articles/8276)

- `bool`, `string`
- `(u)int8`, `(u)int16`, `(u)int32`, `(u)int64`, `(u)int`(等于 CPU 位数), `uintptr`(指针)
- `byte`, `rune`(`Unicode` 字符类型, 32 `bit`, 与 `int32` 等价)

## 3. 强制类型转换
> 类型转换是强制的

```go
func triangle () {
	a, b := 3, 4
	var c int
    // math.Sqrt(x float64) float64
    // Golang 中没有隐式类型转换, 参数需要转换为 float64, 返回值也需要转为 int
	c = int(math.Sqrt(float64(a*a + b*b)))
	fmt.Println(c)
}
```

## 4. 常量

```go
// 常量名不必大写
// 必须有初始值
const num1, num2 = 3, 4

// 数值型常量没有具体的类型, 除非指定一个类型
const num3 int8 = 2

// 数值型常量在逻辑上下文中获取类型
const num4 = 123
fmt.Println(math.Sin(num4))
```

## 5. 枚举类型

```go
// 使用 iota 实现自增枚举
const (
    js = iota
    php
    golang
)

fmt.Println(js, php, golang)
```

## 6. 分支语句

### 6.1 if
```go
func readFile () {
	const fileName = "test.md"
    content, err := ioutil.ReadFile(fileName)
    // if 中不需要加括号
	if err != nil {
		fmt.Println(err)
	} else {
		fmt.Println(content)
	}
}
```

作为 `if` `block` 中的局部变量
```go
func readFile () {
    const fileName = "test.md"
    // cotnent, err 的作用域为 if 代码块
	if content, err := ioutil.ReadFile(fileName); err != nil {
		fmt.Println(err)
	} else {
		fmt.Println(content)
	}
}
```

### 6.2 switch
`case` 会默认 `break`, 除非使用 `fallthrough`
```go
func grade (score int) string {
    level := ""
    // case 中加入条件时不需要写 switch 后的值
	switch {
	case score < 60: level = "F"
	case score < 70: level = "D"
	case score < 80: level = "C"
	case score < 90: level = "B"
	case score <= 100: level = "A"
	default: panic(fmt.Sprintln("Wrong scroe: %d, %s", score))
	}
	return level
}
```

### 6.3 for
```go
func sayHi (name string) {
	for times := 0; times < 5; times++ {
		fmt.Println("Hello, I'm %s", name)
	}
}

func printFile (fileName string) {
	file, err := os.Open(fileName)
	if err != nil {
		panic(err)
	}

	scanner := bufio.NewScanner(file)

    // 只保留条件表达式来替代 while, go 中没有 while
	for scanner.Scan() {
		fmt.Println(scanner.Text())
	}
}
```

## 7. func
> `golang` 是一个函数式语言, 参数传递为**值传递**

```go
// num1 与 num2 同类型
// 可以包含多个返回值
func eval (num1, num2 int, op string) (int, error) {
    switch op {
    case "+": return num1 + num2, nil
    case "-": return num1 - num2, nil
    case "*": return num1 * num2, nil
    case "/": return num1 / num2, nil
    default: return 0, fmt.Errorf("unsported operation %s", op)
    // 使用 panic 会终止程序执行
    // default: panic("unsported operation %s", op)
    }
}

func main () {
    if res, err := eval(2, 4, "-"); err != nil {
		fmt.Println("error", err)
	} else {
		fmt.Println(res)
	}
}
```

函数式编程
```go
func apply (op func(num1, num2 int) int, a, b int) int {
	return op(a, b)
}

func main () {
    res := apply(func (num1, num2 int) int {
		return int(math.Pow(float64(num1), float64(num2)))
	}, 9, 5)
	fmt.Println(res)
}
```

可变参数列表
```go
func printSum (nums ...int) int {
    sum := 0
    for n := range nums {
        sum += nums[n]
    }
    return sum
}

func main () {
    printList(1, 2, 3, 4, 5)
}
```

## 8. 指针
交换两数值
```go
func swap (a, b *int) {
	*a, *b = *b, *a
}

func main () {
    a, b := 2, 5
    swap(&a, &b)
    fmt.Println(a, b)
}
```

更好的方式
```go
func swap (a, b int) (int, int) {
    return b, a
}

func main () {
    a, b := 2, 5
    a, b = swap(a, b)
    fmt.Println(a, b)
}
```

