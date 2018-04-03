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

