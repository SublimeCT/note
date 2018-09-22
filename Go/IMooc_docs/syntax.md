# 基础语法

## 变量定义
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
