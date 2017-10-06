# ECMAScript 6 笔记

by 开源书籍 [ECMAScript6 入门 [阮一峰]](http://es6.ruanyifeng.com)

[![进入](http://es6.ruanyifeng.com/images/cover-3rd.jpg)](http://es6.ruanyifeng.com)

## 简介

ES6 的第一个版本在 2015年6月发布, 简称 ES2015
> 标准委员会决定, 标准在每年 6 月正式发布一次, 作为当年的正式版本, 接下来的时间, 就在这个版本的基础上做改动

### 语法提案的审批流程
* Stage 0 - Strawman（展示阶段）
* Stage 1 - Proposal（征求意见阶段）
* Stage 2 - Draft（草案阶段）
* Stage 3 - Candidate（候选人阶段）
* Stage 4 - Finished（定案阶段）

## 语法

*let / cosnt*
---
> 1. 避免了内部变量覆盖外部变量  
2. 避免用来计数的局部变量泄露为全局变量

* 仅在当前代码块内有效
```javascript
// 循环中的闭包
var a = [];
// i 仅在当前代码块内有效
for (let i = 0; i < 10; i++) {
    a[i] = function () {
        console.log(i);
    };
}
a[6](); // 6
```

* 不存在变量提升
```javascript
// undefined
console.log(a)
var a = 'test'
// 报错
console.log(a)
const a = 'test'
```

* 暂时性死区
> 暂时性死区意味着 typeof 不再是一个百分百安全的操作

```javascript
var a = 1
if (1) {
    // 报错
    console.log(a)
    let a = 2
}
```

* 不允许重复声明
```javascript
let a = 1
// 报错
let a = 2
// 报错
var a = 3
```

* 块级作用域
```javascript
// IIFE 写法
(function(){
    var a = 1
})()
// 块级作用域写法
{
    let a = 1
}
```

* const
const 声明一个只读变量, 不能被再次赋值

*解构赋值*
---

* 数组
```javascript
let [foo, [[bar], baz], , ...last] = [1, [[2], 3], 4, 5, 6];
// 1, 2, 3, [5,6]
let [x, y, ...z] = ['a'];
// a, undefined, []
```

* 默认值
```javascript
let [a, b = null] = arr
let {a = null} = obj
```

* 对象
```javascript
let {first: f, last: l} = {first: 'fff', last: 'lll'}
// f = 'fff'
// l = 'lll'

let a = {test:null}
let b = []
({aa: a.test, bb: b[0]} = {aa: '*', bb: false})
```

* 字符串
```javascript
const [a, b, c] = 'PHP'
const [length: len] = 'PHP'
```

* 函数
```javascript
function test({a, b} = {}){
    // ...
}
```

*字符串的扩展*
---
* repeat
```javascript
'test'.repeat(2)    // 'testtest'
```

* 模板字符串
```javascript
const name = 'sven'
const age = 21
const getStr = () => { return 'is'; }
cosnt str = `${name} ${getStr()} ${age}`
```

*数值*
---

```javascript
Math.trunc(-166.66)     // -166  直接取整
Math.floor(-166,66)     // -167  取不大于原数的最大整数

2 ** 3     // 8    指数运算符 ** 
```

*函数*
---

* 函数参数默认值

> 在 ES6 之前不能直接为函数参数指定默认值, 只能采用变通的方法
```javascript
function test(a, b) {
    var a = a || 'test'
    if (typeof b === 'undefined') {
        b = 0
    }
}
```

* rest参数
```javascript
function test(...values){
    let sum = 0
    for (val of values) {
        sum += val
    }
    return sum
}
// 通过 rest 函数取代 arguments
// arguments变量的写法
function sortNumbers() {
  return Array.prototype.slice.call(arguments).sort();
}
// rest参数的写法
const sortNumbers = (...numbers) => numbers.sort();
```

* 箭头函数
    - 没有形成独立的作用域, this 指向不变
    - 不能当做构造函数, new 会报错
    - 不能使用 arguments, 应使用 rest 参数代替
    - 不能使用 yield 命令, 因此箭头函数不能当做 Generator 函数

*数组*
---

* 代替数组的 apply 方法

```javascript
function f(a, b, c){
    // ...
}
const args = [1, 2, 3]
f.apply(null, args)

// ES6 写法
const args = [1, 3, 4]
f(...args)
```

* 扩展运算符应用
合并数组
```javascript
    arr = arr1.concat(arr2)
    arr = [...arr1, ...arr2]
```

* find / findIndex

```javascript
var arr = [1, 2, 3]
arr.filter((n) => n>1)      // [2, 3]    返回所有符合条件的元素
arr.find((n) => n>1)        // 2    返回第一个符合条件的元素
arr.findIndex((n) => n>1)   // 1    返回第一个符合条件的元素索引
```

* fill

```javascript
let arr = ['A', 'B', 'A', 'C', 'B', 'A']
arr.fill('', 1, 2)
// 第二三个参数为开始和结束位置
// ["A", "", "A", "C", "B", "A"]
```

* entries / keys / values

```javascript
for (let [i, v] of arr.entries) { /* 返回包含键和值的迭代器对象 */ }
// 手动调用迭代器对象
arr = ['a', 'b', 'c']
let entries = arr.entities()
console.log(entries.next().value)   // 0, 'a'
console.log(entries.next().value)   // 1, 'b'
```

* includes

```javascript
['s', 'v', 'e', 'n'].includes('s')  // true     返回数组是否包含给定值, 与 indexOf 和字符串的 includes 相似
'sven'.includes('f')                // false
```

* 数组的空位

ES5 对空位的处理
    - forEach(), filter(), every() 和some()都会跳过空位。
    - map()会跳过空位，但会保留这个值
    - join()和toString()会将空位视为undefined，而undefined和null会被处理成空字符串。

```javascript
const arr = new Array(3)
arr     // (3) [empty × 3]  只有 length: 3 属性

// ES6 中的 Array.from/展开运算符/fill... 明确地将空位转化为 undefined
```

*对象*
---

* 属性的简介表示法
```javascript
const a = true
const b = 1
const obj = {
    a,
    b,
    _name: 'sven',
    _age: 21,
    // ES5 中的 get / set 方法
    get name () {
        // 只有 get 使该属性只读
        return this._name + '=>'
    },
    // get 和 set 都有时为可读写, 只有 set 为只写(不可读)
    set age (age) {
        return this._age + '- -'
    },
    get age () {
        return this._age
    },
    test () {
        return {
            this.a,
            this.b
        }
    }
}
```

* 属性名表达式

```javascript
let obj = {
    ['123' + 'abc'] () {
        // ...
    }
} 
```

* 方法的 name 属性

```javascript
let obj = {
    getName () {}
}
obj.getName.name    // 'getName'
```

* Object.is

```javascript
0 === -0        // true
NaN === NaN     // false

Object.is(0, -0)            // false
Object.is(NaN, NaN)         // true
```

* Object.asign

```javascript
const target = { a: { b: 'c', d: 'e' } }        // 当前对象
const source = { a: { b: 'hello' } }            // 源对象
// 执行浅复制, 引用类型直接复制源对象中的引用
// 只复制可枚举属性
// 同名属性直接覆盖
Object.assign(target, source)
// { a: { b: 'hello' } }
```

* __proto__

> ES6 中推荐使用 setPrototypeOf / getPrototypeOf / create 取代各个浏览器广泛支持的 __proto__ 属性 

```javascript
let proto = {};
let obj = { x: 10 };
Object.setPrototypeOf(obj, proto);

proto.y = 20;
proto.z = 40;

obj.x // 10
obj.y // 20
obj.z // 40
```

*Symbol*
---

> Symbol 是 JavaScript 中的第 7 种数据类型, 表示独一无二的值

* 声明

```javascript
const a = Symbol('aaa')
const b = Symbol('bbb')
a.toString()        // 'Symbol(aaa)'
```

* 作为对象属性

```javascript
const my_name = Symbol('name')
const my_age = Symbol('age')

person = new Person
person[my_name] = 'sven'
person[my_age] = 21

// 定义一组常量, 保证这组常量的值不相等
obj.status = {
    DEBUG: Symbol('debug'),
    INFO: Symbol('info'),
    WARN: Symbol('warn')
}
```

* 消除魔术字符串
> 魔术字符串是指在代码中多次出现, 与代码形成强耦合的字符串或数值

```javascript
const shape = {
    // 这里的 type 的具体值并不重要, 只要保证互不冲突即可
    type: {
        rect: Symbol('rect'),
        triangle: Symbol('triangle')
    },
    getArea (type, options) {
        let area = 0
        switch (type) {
            case this.type.rect:
                return options.width * options.height
                break
            case this.type.triangle:
                return .5 * options.width * options.height
                break
        }
    }
}
shape.getArea(shape.type.rect, {width: 3, height: 5})
```

* 遍历对象中的 Symbol 属性

```javascript
const name = Symbol('name')
const o = {
    [name]: 'sven'
}
console.log(Object.getOwnPropertySymbols(o));
```

* Symbol.for / Symbol.keyFor

> Symbol.for 和 Symbol 都会生成新的Symbol  
Symbol.for 会被登记在全局环境中供搜索，后者不会。  
Symbol.for()不会每次调用就返回一个新的 Symbol 类型的值，而是会先检查给定的key是否已经存在  
如果不存在才会新建一个值, 存在就直接返回该值

```javascript
const a = Symbol.for('foo')
const b = Symbol.for('foo')
a === b     // true
```

```javascript
const foo = Symbol('foo')
// 获取以 foo 为键的 symbol 值, 并进行登记
const a = Symbol.for('foo')
// 返回已登记的 symbol 类型值的 key
const b = Symbol.forKey(a)
``` 

*Set / Map 数据结构*
---

    - add(value)：添加某个值，返回Set结构本身。
    - delete(value)：删除某个值，返回一个布尔值，表示删除是否成功。
    - has(value)：返回一个布尔值，表示该值是否为Set的成员。
    - clear()：清除所有成员，没有返回值。
    
```javascript
const set = new Set([1,2,3,3,3,3,3,3])
set.add('4')
set.size    // 4

// 去除数组中重复值
let arr = [1,2,3,3,3,3]
arr = [...new Set(arr)]
```

* [**WeakSet**](http://es6.ruanyifeng.com/#docs/set-map#WeakSet)

    - WeakSet.prototype.add(value)：向 WeakSet 实例添加一个新成员。
    - WeakSet.prototype.delete(value)：清除 WeakSet 实例的指定成员。
    - WeakSet.prototype.has(value)：返回一个布尔值，表示某个值是否在 WeakSet 实例之中。

> WeakSet 与 Set 类型相似, 都是值不重复的值的集合  
1. WeakSet 类型的属性只能是对象  
2. WeakSet 类型的引用的对象在添加引用时不增加引用计数, 即如果其他对象都不再引用该对象占用的内存  
3. WeakSet 类型成员数量随时可能发生变化, 因此不可遍历, 也没有 size 属性


```javascript
const foos = new WeakSet()
class Foo {
    constructor() {
        foos.add(this)
    }
    method () {
        if (!foos.has(this)) {
            throw new TypeError('Foo.prototype.method 只能在Foo的实例上调用！');
        }
    }
}
```

* Map

> Map 类似与对象, 但键可以是任意数据类型, 是更加完善的 Hash 结构的实现  
属性/方法:  
size / set / get / has / delete / clear 

```javascript
const key1 = ['key']
const key2 = ['key']
const map = new Map([
    [key1, 'aaa'],
    [key2, 'bbb']
])
console.log(map.get(key1))      // aaa      Map 中的键实际上是跟内存地址绑定
console.log(map.get(key2))      // bbb
```

* [WeakMap](http://es6.ruanyifeng.com/#docs/set-map#WeakMap-的用途)

> 只能接受对象作为键 ...

*[proxy](http://es6.ruanyifeng.com/#docs/proxy)*
---

*[Reflect](http://es6.ruanyifeng.com/#docs/reflect)*
---

*[Promise](http://es6.ruanyifeng.com/#docs/promise)
---

> 状态:  
1. pending      进行中
2. fulfilled    已成功
3. rejected     已失败

```javascript
const loadImageAsync = (url) => {
    return new Promise((resole, reject) => {
        const img = new Image
        img.onload = () => {
            resole(img)
        }
        img.onerror = () => {
            reject(new Error('could not load image'))
        }
        img.src = url
    })
}
const url = 'https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png'
loadImageAsync(url).then(
    img => {
        document.body.appendChild(img)
    },
    error => {
        throw new Error(error)
    }
)
.catch(
    e => {
        // 处理 promise函数 / then 中的所有错误
        console.log('error')
    }
)
```

* [两个有用的附加方法](http://es6.ruanyifeng.com/#docs/promise#两个有用的附加方法)

*async 函数*
---




