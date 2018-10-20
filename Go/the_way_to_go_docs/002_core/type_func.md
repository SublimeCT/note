# [type & func](https://github.com/SublimeCT/note/blob/master/Go/the_way_to_go_docs/002_core/type_func.md)

# new
new 函数给一个新的结构体变量分配内存，它返回指向已分配内存的指针

```go
type T struct {
    i1  int
    f1  float32
    str string
}

func main() {
    ms := new(T)
}
```

# 混合字面量语法
`&struct1{a, b, c}` 是一种简写，底层仍然会调用 `new()`

```go
type Interval struct {
    start int
    end   int
}
```

```go
intr := Interval{3,4}
intr := Interval{start: 3, end: 4}
intr := Interval{end: 5}
```

