# OOP
> Go 语言的面向对象只有封装(struct), 没有继承和多态; 面向接口编程

## 1. 结构体
结构体中的属性的封装约定
-  `public` 为 `CamelCase`
- `private` 为 `camelCase`

```go
// 创建 TreeNode 结构
type TreeNode struct {
	value int
	left, right *TreeNode
}

// 为结构体定义方法, (node TreeNode) 定义方法的的接收者
// 此时 node 为值接收者, 函数内部的 node 是拷贝调用者, 这是 Go 语言特有的
func (node TreeNode) print() {
	fmt.Println(node.value)
}
// 使用指针作为方法的接收者
func (node *TreeNode) setValue (value int) {
	node.value = value
}

func main () {
	node := TreeNode{value: 3} // key: value 方式声明
	node.left = &TreeNode{}
    node.right = &TreeNode{5, nil, nil} // 按顺序声明
    // 不管是结构本身还是地址都可以使用 . 访问
    node.right.left = new(TreeNode) // 使用内建函数 new 创建 TreeNode 对象
    // 创建 slice, 在 slice 声明内部可省略 TreeNode 类型声明
    nodeList := []TreeNode{
		{value: 3},
		{0, &node, nil},
	}

	fmt.Println(node)
}
```

使用工厂函数实现构造
```go
func createNode (value int) *TreeNode {
	return &TreeNode{value: value} // 在此返回了局部变量的地址, Go 会为它在堆上分配地址
}
```

**Go 语言中 `nil` 指针可以成功执行方法**
```go
// 实现中序遍历
func (node *TreeNode) traverse () {
	if node == nil { return }
	node.left.traverse()
	node.print()
	node.right.traverse()
}
```

## 2. 扩展 type
> 可以通过 ***定义别名*** 和 ***使用组合*** 扩展类型

在 `nodes` 包中创建入口文件 `entry/entry.go` 作为 main
```go
package main

import (
	"yunss.com/sven/impression/node"
)

type MyTreeNode struct {
	node *nodes.TreeNode
}

func (myNode *MyTreeNode) postOrder () {
	if myNode == nil || myNode.node == nil { return }
	left := MyTreeNode{myNode.node.Left}
	right := MyTreeNode{myNode.node.Right}
	left.postOrder()
	right.postOrder()
	myNode.node.Print()
}

func main () {
	/*
	 *			2
	 *		3		0
	 *		  6   4
	 */
	root := nodes.TreeNode{Value: 2}
	root.Left = &nodes.TreeNode{Value: 3}
	root.Left.Right = &nodes.TreeNode{Value: 6}
	root.Right = &nodes.TreeNode{}
	root.Right.Left = &nodes.TreeNode{Value: 4}
	node := MyTreeNode{&root}
	node.postOrder()
}
```

