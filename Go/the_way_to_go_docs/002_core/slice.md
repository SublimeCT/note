# [数组和切片](https://github.com/SublimeCT/note/blob/master/Go/the_way_to_go_docs/002_core/slice.md)

## 数组
> 具有**唯一类型**且**长度固定**的数据项序列, 在 `Go` 语言中数组是值类型

```go
var arr [len]type
```

使用 `for-range` 遍历
```go
arr := []int{2, 3, 4}
for _, item := range arr {
    fmt.Println(item)
}
```

