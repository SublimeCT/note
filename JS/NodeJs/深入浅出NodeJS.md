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

## js 模块的编译

```javascript
(function () {
    
})();
```
















