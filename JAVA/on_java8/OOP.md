# 1-对象

## 抽象
一个对象具有自己的状态 / 行为 / 标识; 这意味着对象有自己的内部数据(提供状态) / 方法(产生行为) / 并彼此区分(每个对象在内存中有唯一的地址)

## 对象创建
在 `Java` 中万物皆对象, 所有的类都默认从一个基类(`Object`)继承

```java
String s; // 空指针
String s = "asdf"; // 使用双引号初始化字符串
String s = new String("asdf");
```

## 数据存储

程序在运行时会在以下地方进行数据存储:

1. **寄存器 `Register`**: `Java` 没有直接的控制权
2. **栈内存 `Stack`**: `RAM` 随机访问存储器 (Random Access Memory) 中, 通常存储 `Java` 的对象引用和基本数据类型
3. **堆内存 `Heap`**: 也在 `RAM` 中, 所有的对象数据都在对中, *分配和清理内存需要更多的时间*
4. **常量存储 `Constant storage`**: 常量值直接存储在程序代码中, 若需要严格保护, 可以存到 `ROM` (`Read Only Memory`) 中
5. **非 RAM 存储 `Non-RAM storage`**: 数据存到外存中, 程序未运行时依然存在, 主要用于数据持久化

## 基础数据类型

基础数据类型不需要通过 `new` 创建, *`new` 创建的对象保存在堆中*, `Java` 使用了 `C/C++` 一样的策略, 将基础数据类型保存在栈中;

| 基本类型  |    大小 |  最小值  | 最大值  | 包装类型 |
| :------: | :------: | :------: | :------: | :------: |
| boolean | —  | — | — | Boolean |
| char | 16 bits | Unicode 0  | Unicode 2<sup>16</sup> -1  | Character |
| byte | 8 bits | -128 | +127 | Byte |
| short | 16 bits | - 2<sup>15</sup> | + 2<sup>15</sup> -1 | Short |
| int | 32 bits | - 2<sup>31</sup> | + 2<sup>31</sup> -1 | Integer |
| long | 64 bits | - 2<sup>63</sup> | + 2<sup>63</sup> -1 | Long |
| float | 32 bits | IEEE754 | IEEE754 | Float |
| double | 64 bits |IEEE754 | IEEE754 | Double |
| void | — | — | — | Void |

