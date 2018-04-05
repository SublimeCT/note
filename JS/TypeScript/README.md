# TypeScript 笔记

## links
- [doc](https://www.tslang.cn/docs/home.html)
- [test page](http://www.typescriptlang.org/play/index.html)

## 简介
`TypeScript` 是 `JavaScript` 的一个超集, 主要提供了类型系统和对 `ES6` 的支持

## 安装
```bash
$ yarn global add typescript
```

## 编译
编译过程中如果报错, 仍然会生成编译后的文件

```bash
$ tsc greeter.ts
```

监听文件变化
```bash
$ tsc -w greeter.ts
```

## 基础类型

### boolean
### number
`TypeScript` 的 `number` 类型可以表示二进制和八进制的数值

```typescript
const binaryLiteral: number = 0b1010
const octalLiteral: number = 0o744
```

### string
### array

```typescript
const list1: number[] = [1, 2, 3]
const list2: Array<number> = [1, 2, 3]
```

### tuple 元组
元组表示一个已知元素数量和类型的数组

```typescript
let list: [number, string]
list = [123, 'test']
// 当访问越界元素时, 将使用联合类型替代, 即 number|string
list[2] = false
```

### emun 枚举
枚举类型为一组数值赋予语义化的名字

```typescript
// 枚举类型表示的数值默认从 1 开始
enum Color {Red, Green, Blue = 10086}
const c: Color = Color.Blue
// 通过数值获得类型名
console.log(Color[c]) // 'Blue'
```

### any
```typescript
let arr: any[] = [1, false, 'test']
```

### void
`void` 类型的变量可以为:

- 没有返回值的 `function`
- undefined
- null

### undefined
### null
### never
`never` 类型是其他类型的子类型, 表示不会出现的值, 如抛出异常或死循环

## 变量声明
[doc](https://www.tslang.cn/docs/handbook/variable-declarations.html)

## 接口
[doc](https://www.tslang.cn/docs/handbook/interfaces.html)

### interface
```typescript
interface LabelledValue {
    label: string // 必选属性
    readonly name: string // 只读属性
    xxx?: string // 可选属性
}
const printLabel = (LabelledObj: LabelledValue) => {
    console.log(LabelledObj.label, LabelledObj.name, LabelledObj.xxx)
}
const myObj: LabelledValue = {name: 'sven', label: 'Hello TypeScript !!!'}
printLabel(myObj)
```

当传入的 **字面量对象** 包含接口中没有的属性时会报错, 可以使用类型断言绕开检测
```typescript
// 接口中不存在 test 属性, 使用类型断言绕开检测
printLabel({name: 'sven', label: 'Hello TypeScript !!!', test: 0} as LabelledValue)
```

### 只读数组
```typescript
const arr = [0, 1, 2]
const arr2: ReadonlyArray<number> = arr
arr2[0] = 1 // error
arr2.push(2) // error
arr2.length = 100 // error
arr = arr2 // error
```

### 其他类型接口
```typescript
// 函数类型 interface
interface TestFun {
    (src: any, attr: string): boolean
}
// 可索引类型 interface
interface TestArray {
    [index: number]: string
}
// 类 interface
interface XXX {
    xxx: boolean
}
interface Animal {
    eat(content: string): string
}
// interface 之间可以互相继承
interface Cat implements XXX, Animal {
    sleep(sleeped: boolean): void
}
// 混合类型
interface Counter {
    (start: number): string
    interval: number
    reset(): void
}
// 规范函数的参数类型
const test: TestFun = (src: any, attr: string) => {
    const result = attr in src
    return result
}
// 使用混合类型的 interface
const counter: Counter = () => {}
counter.interval = 3
counter.reset = () => {}
console.log(counter.interval)
```

class 的创建
```typescript
// 定义一个 function 的 interface, 检测 new Cat() 的参数
interface CatConstructor {
    new (name: string, age: number): Cat
}
class Cat {
    name: string
    age: number
    constructor (name, age) {
        this.name = name
        this.age = age
        console.log(this)
    }
}
const createCat = (cat: CatConstructor) => {
    new cat('shit', 22)
}
createCat(Cat)
```

`interface` 继承 `class`
```typescript
class Control {
    private state: any
}
interface SelectableControl extends Control {
    select(): void
}
class Button extends Control implements SelectableControl {
    select () {}
}
// error: 必须继承 Control 才能实现 SelectableControl 接口
class TextBox implements SelectableControl { }
```

