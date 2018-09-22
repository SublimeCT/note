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




