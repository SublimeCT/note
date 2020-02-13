# 5-树

`tree` 是有 `n (n>=0)` 个结点的有限集, `n = 0` 时称为空树

- 有且仅有一个 `root` 根结点
- 当 `n > 1` 时, 其余结点可分为 `m > 0` 个互不相交的有限集, 每个集合本身就是 `sub tree` 子树

![](../../../assets/images/tree.png)

## 结点
- `Degree`(度): 结点拥有的子节点的数量
- `Leaf`(叶结点): 结点的子节点数为 `0`
- `Branch Node`(分支结点): `Degree > 0`
- `Children`

## 二叉树

### 遍历方式
#### 前序遍历
从根节点开始遍历, 先前序遍历左子树, 再前序遍历右子树

![](../../../assets/images/preorder_binary_tree.png)
#### 中序遍历
从遍历左子树, 然后访问根节点, 再遍历右子树

![](../../../assets/images/inorder_binary_tree.png)
#### 后序遍历
从遍历左子树, 再遍历右子树, 然后访问根节点

![](../../../assets/images/postorder_binary_tree.png)
#### 层序遍历
按数的层由上向下遍历, 每层从左到右遍历

![](../../../assets/images/levelorder_binary_tree.png)

## 赫夫曼树

[相关文章](https://www.cnblogs.com/Braveliu/p/3453900.html)

