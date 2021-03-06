# 深入浅出 NoodeJS 笔记
> [豆瓣](https://book.douban.com/subject/25768396/)  
[图灵社区](http://www.ituring.com.cn/book/1290)

![封面](http://file.ituring.com.cn/ScreenShow/010062ed2dd24ac49ff9)

## 一、特点

- 异步 IO
- 单线程

## 应用场景

- IO 密集型
- CPU 密集型
    * 场景:  
        长时间运行的运算将会导致 CPU 时间片不能释放, 使得后续 IO 无法发起  
    * 解决方案:  
        - 适当调整分解为多个小任务
        - 通过编写 C/C++ 方式更高效地利用 CPU
        - 将一部分进程当作常驻服务进程用于计算

## 二、模块机制

- CommonJS
> JavaScript 天生缺乏包管理系统

### 模块规范
```javascript
// 模块定义
export.xxx = () => new Date()
// 模块引用
const xxx = require('xxx')
```

### 引入步骤
- 路径分析
- 文件定位
- 编译执行

### 模块实现
> 模块分为 `Node` 提供的核心模块和用户编写的文件模块

- 核心模块
    `Node` 核心模块直接编译为二进制执行文件, `Node` 进程启动时部分核心模块就直接加载进内存
    分为 `C/C++` 和 `JavaScript` 编写的二进制文件
    存放在 `Node` 项目的 `/src` 目录下, `JavaScript` 文件存放在 `/lib` 目录下

- 文件模块
    运行时动态加载

### 模块加载
> `Node` 缓存的是编译和执行后的对象

- 优先级  
    `缓存` > `核心模块` > `路径形式的文件模块` > `自定义模块`(只有文件名)
- 自定义模块加载优先级  
    当前目录下的 `node_modules` 目录 > 上级目录下的 `node_modules` 目录 > ... `/node_modules`
- 文件定位优先级  
    当 `require` 的文件不包含扩展名时, 在同一个 `node_modules` 目录查找:  
    `xxx.js` > `xxx.json` > `xxx.node` > `index.js` > `index.json` > `index.node`

### 模块编译
> `Node` 中每个文件模块都是一个对象

```javascript
function Modules (id, parent) {
    this.id = id;
    this.exprots = {};
    this.parent = parent;
    if (parent && parent.children) {
        parent.children.push(this);
    }
    this.filename = null;
    this.loaded = false;
    this.children = null;
}
```

- js 文件  
    通过 `fs` 模块同步读取后编译执行
- node 文件
    如果时 `C/C++` 编写的扩展文件, 通过 `dlopen()` 加载后编译执行
- json 文件
    `JSON.parse`
- 其他文件
    都会被当作 `js` 文件载入

> 每个编译成功的模块都会将文件路径作为索引缓存在 `Module._chche` 对象上

### 自定义文件扩展名加载

> `v0.10.6` 开始官方不鼓励通过 `require.extensions['.coffee']` 的方式实现自定义文件扩展名加载,  
而是先将其他语言编译为 `JavaScript` 文件后再加载, 不再占用 `Node` 的执行时间

```javascript
// 根据不同的文件扩展名, Node 会调用不同的读取方式
// Module._extensions 会被赋值给 require.extensions
Module._extensions['.json'] = function (module, filename) {
    var content = NativeModule.require('fs').readFileSync(filename, 'utf-8')
    try {
        module.exports = JSON.parse(stripBOM(content))
    } catch (err) {
        err.message = filename + err.message
    }
}
```

### js 模块的编译

> 每个模块通过 `vm` 模块的 `runInThisContext` 方式进行作用域隔离

```javascript
(function (exports, require, module, __filename, __dirname) {
    // ...
})();
```

### module.exports

> `exports` 是通过形参的方式传入的, 要达到 `require` 引入的效果， 赋值给 `module.exports`

### C/C++ 模块的编译

> `Node` 调用 `process.dlopen` 的方式执行, 实际上 `.node` 模块只需要加载和执行 

...

### 前后端共用模块

- 模块侧重点
    - 前端 JS 需要经历从同一个服务器分发到多个客户端执行, 且为了用户体验模块引入采用异步形式， 瓶颈在于带宽
    - 后端则是相同代码需要执行多次, 几乎所有模块引入采用同步， 先 `require` 再使用， 瓶颈在于 `CPU` 和内存

### AMD 规范

> `CMD` 是 `Asynchronous Module Definition 异步模块定义`, 是 `CommonJS` 模块规范的延伸

```javascript
// AMD 只用一个接口
define([id, dependedcies,] factory)
// `CMD` 的 `id` 和依赖是可选的
define(function () {
    var exports = {}
    exports.sayHello = function () {
        alert('hello NodeJS')
    }
    return exports
})
```

### CMD 规范

```javascript
define(['dep1', 'dep2'], function (dep1, dep2) {
    return function () {}
})
```

## 三、异步 IO

### 资源分配

假设业务场景中有一组互不相关的任务需要完成

- 单线程异步  
    * 优点  
        远离死锁和状态同步, 使 IO 不再阻塞后续代码执行, 通过 `Node` 提供的类似 `HTML5` 的 `Web Workers` 子进程高效利用 `CPU` 和 `IO`  

- 多线程并行完成
    * 优点  
        在多核 `CPU` 上能有效提升 `CPU` 利用率  
    * 缺点  
        创建线程和执行期间上下文切换开销较大, 经常面临死锁和状态同步问题  

### 异步 I/O
`
application                     OS
    I/O 调用                      |
        ------ 异步调用 -------> 处理请求
        |                      *****
        |                      *****
        |                      *****
      *****                    *****
      *****                    *****
      * 其他调用 *              *****
      *****                    *****
      *****                    *****
        |                      *****
        |                      *****
        |                      *****
        |                      *****
      ***** <---- 返回数据 -------|
      * 执行回调 *                |
      *****                      |
      *****                      |
      *****                      |
      *****                      |
      *****                      |
`

### 阻塞与非阻塞 I/O
对于系统内核而言, 只有阻塞与非阻塞  
- 阻塞是系统内核完成所有操作后调用才结束, 造成了 CPU 等待, CPU 处理能力不能充分利用  
- 非阻塞 I/O 调用后会立即返回, 必须通过文件描述符再次获取数据(**轮询**)  
> 操作系统对计算机进行抽象, 将所有 I/O 设备抽象为文件, 内核在进行文件 I/O 操作时通过 [文件描述符](http://blog.csdn.net/u013078669/article/details/51172429) 进行管理  

### 轮询方案
- epoll  
    `Linux` 下的事件通知机制, 在进入轮询时如果没有检测到 I/O 事件, 将进行休眠, 直到事件将它唤醒

### 现实的 I/O
让部分线程进行阻塞/非阻塞 I/O, 另一个进程负责计算处理, 通过进程通信进行数据传递, 实现了 **多线程异步 I/O**  
在 NodeJS 中通过 `libuv` 提供了兼容 *nix & windows 的抽象层  

## 四、异步编程














