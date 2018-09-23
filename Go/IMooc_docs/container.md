# 数组/切片/容器

## 1. 数组
> 数组是值类型, **作为函数参数时会拷贝数组**

```go
// 如果是数组类型则必须声明长度
func sum (arr [5]int) int {
    sum := 0
    for _, v := range arr {
        sum += v
    }
    fmt.Println(sum)
}

func main () {
    arr1 := [2]int{1, 2}
    arr2 := [...]int{3, 5, 7, 9, 11}
    // 3 × 5 的数组
    arr3 := [3][5]int
    // 使用 _ 省略 index
    for _, v := range arr2 {
        fmt.Println("value: %d", v)
    }
    fmt.Println(sum(arr2))
}
```

## 2. slice
> slice 本身没有数据, 是对底层 array 的 view, 可作为数组的引用传递给函数

```go
// 如果是数组类型则必须声明长度
func sum (arr [5]int) int {
	sum := 0
	for _, v := range arr {
		sum += v
	}
	return sum
}

func main () {
    arr1 := [5]int {2, 12, 43, 4, 4}
	arr2 := arr1[2:3] // [43] 包含 2 不包含 3
	fmt.Println("changeArr(arr2) ", changeArr(arr2))
	fmt.Println("arr1 ", arr1)
}
```

### 2.1`slice` 的实现
- `ptr`, 指向起始位置的元素
- `len`, `slice` 的长度
- `cap`, 从起始位置到原始 `array` 结束位置的长度

```go
func main () {
	arr1 := [...]int {0, 1, 2, 3, 4, 5, 6, 7}
	arr2 := arr1[2:5]
	arr3 := arr2[1:4]
	fmt.Println("arr2 ", arr2) // 2 3 4
	fmt.Println("arr3 ", arr3) // 3 4 5
}
```
