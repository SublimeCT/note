# High Performance JavaScript [Syntax Note]

![](https://img3.doubanio.com/lpic/s6245861.jpg)

## 四、 算法和流程控制

* 颠倒数组顺序提高循环性能
> 使用倒序遍历时控制条件部分没有 i 与迭代数的比较  
将控制条件部分的比较次数从两次减少到一次  

```javascript
const arr = ['PHP', 'JS', 'Go']
for (let i=arr.length; i--; ) {
    // code ...
}
```

* 减少迭代次数
> Duff's Device  
每次循环最多可以执行 8 次 console.log  
原书代码有误, 下为修正版

```javascript
const items = [1,2,3,4,5,6,7,8,9,0]

// Duff's Device
const a = items.length % 8
const b = Math.floor(items.length / 8)
let i = 0
while(a--) {
    console.log(items[i++])
}
while(b--) {
    console.log(items[i++])
    console.log(items[i++])
    console.log(items[i++])
    console.log(items[i++])
    console.log(items[i++])
    console.log(items[i++])
    console.log(items[i++])
    console.log(items[i++])
}
```

* 基于函数的迭代
> ECMA-262 引入的 forEach 是基于函数的迭代, 但由于调用外部方法的开销, 性能低于基于循环的迭代

* 优化 if-else
    - 最小化到达正确分支前所需判断的条件数量

* 查找表
> 优化条件语句的最佳方案是避免使用过多的 if-else & switch  

* 迭代
> 任何递归能够实现的算法都可以使用迭代代替

## 五、 字符串和正则表达式
...

