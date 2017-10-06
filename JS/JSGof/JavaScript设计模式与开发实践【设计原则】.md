# 设计原则与编程技巧

## 单一职责原则 (SRP)

> 就一个类而言, 应该仅有一个引起它变化的原因  
如果有两个动机改写一个方法, 那么这个方法就有两个职责  
如果一个方法承担了过多的职责, 那么在需求变迁过程中, 需要改写这个方法的可能性就越大  
SRP 原则体现为: 一个对象只做一件事情

### 分离职责

*单例模式 demo*
此时 createLoginLayer 有管理单例和创建登录浮窗的两个职责
```javascript
    var createLoginLayer = (function(){
        var div
        return function(){
            if (!div) {
                // 创建登录浮窗...
            }
        }
    })()
```

将职责分离

```javascript
    // 获取单例
    var getSingle = function(fun){
        var result
        return function(){
            return result || (result = fun.prototype.apply(this, arugments))
        }
    }
    var createLoginLayer = function(){
        // 创建登录浮窗 ...
    }
    var createSingleLoginLayer = getSingle(createLoginLayer)
    var loginLayer1 = new createSingleLoginLayer
    var loginLayer2 = new createSingleLoginLayer
    console.log(loginLayer1 === loginLayer2)
```

# 何时才应该分离职责

> 并不是所有的职责都应该一一分离  
如果随着需求的变化, 两个职责总是需要同时变化, 那么就不应该分离它们

## 最少知识原则

> 一个软件实体应当尽可能少的与其他实体发生相互作用

## 开放-封闭原则

### 用独享的多态性取代条件分支
> 过多的条件分之语句是造成程序违反开放-封闭原则的常见场景  
每当看到大片 if-else / switch-case 时, 就应该考虑通过对象多态性重构它们

### 通过其他方式帮助遵循开放-封闭原则
* 放置挂钩
* 使用回调函数

## 接口和面向接口编程

> 接口是对象能够响应的请求的集合

## 代码重构

* 提炼函数
* 合并重复的代码片段
* 合理使用循环
* 提前让函数退出取代嵌套条件分支
* 传递对象参数代替对象列表
* 尽量减少参数数量
* 少使用三目运算符
* 合理使用链式调用
* 分解大型类
* 用 return 退出多重循环

