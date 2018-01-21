# 原生 Nodejs

## [events](http://nodejs.cn/api/events.html)
- 大多数 `Nodejs` 核心 `API` 都采用异步事件驱动架构
- `events` 模块只提供了一个 `EventEmmiter` 类(对象)

### `this` 指向
`on方法` 回调函数中的 `this` 指向该 `EventEmmiter`, (**使用箭头函数无法绑定 `this`**)
```javascript
const EventEmmiter = require('events')
class MyEmmiter extends EventEmmiter {}
const evt = new MyEmmiter()

evt.on('eventName', function (str) {
    console.log(str, this)
})
/* eventName MyEmmiter {
  domain: null,
  _events: { eventName: [ [Function], [Function] ] },
  _eventsCount: 1,
  _maxListeners: undefined } */
evt.emit('eventName', 'params...')
```

### `error` 事件
当 `EventEmmiter` 实例发生错误时, 触发 `error` 事件, 当未监听 `error` 事件并发生错误时会**报错并退出 `Node` 进程**

```javascript
e.on('error', function (e) {
    console.log('Error', e)
})
e.emit('error', new Error('whoops'))
```

可以通过 `process` 对象的 `uncaughtException` 事件处理错误
```javascript
process.on('uncaughtException', err => console.error('Error => ', err))
e.emit('error', new Error('whoops))
```

### `newListener` / `removeListener` 事件
在该监听器上注册事件时会先触发 `newListener` 事件

```javascript
// 使用 once 只执行一次
e.once('newListener', (event, listener) => {
    if (event === 'test') e.on('test', () => console.log('before'))
}).on('test', () => {
    console.log('emit')
})
e.emit('test')
```

### `defaultMaxListeners`
每个 `EventEmitter` 默认最多注册 `10` 监听器, 超出将输出警告, 使用 `getMaxListeners` / `setMaxListeners` 修改最大值
、
### `eventNames`
获取已注册的所有事件名, 返回值为 `String` / `Symbol`

### `listeners(eventName)`
获取监听

### `prependListener` / `prependOnceListener`
将事件函数添加到监听器数组开头
```javascript
e.on('data', function () {
    console.log(1)
}).prependListener('data', function () {
    console.log(2)
})
e.emit('data', 'hello')
// 2 1
```

### `removeAllListener(eventName)` / `removeListener(eventName, listener)`

## [path](http://nodejs.cn/api/path.html)

### `basename` / `dirname` / `extname`
`path` 模块的默认操作会根据运行环境的不同而变化
`Windows`
```javascript
path.basename('C:\\temp\\myfile.html')
// myfile.html
```
`POSIX`
```javascript
path.basename('C:\\temp\\myfile.html')
// C:\\temp\\myfile.html
```
指定操作系统
```javascript
path.win32.basename('C:\\temp\\myfile.html')
path.posix.basename('C:\\temp\\myfile.html')
```
`ext` 参数
```javascript
path.basename('./index.tar.gz', 'tar.gz')
// index
```

### `delimiter`
平台路径分隔符
- `Windows` 为 `;`
- `POSIX` 为 `:`
```javascript
process.env.PATH.split(path.delimiter)
```

### `format` / `parse`
将 `path` 解析为对象 / 字符串
```javascript
const obj = path.parse('/home/user/dir/file.txt')
// { 
//     root: '/',
//     dir: '/home/user/dir',
//     base: 'file.txt',
//     ext: '.txt',
//     name: 'file'
// }
path.format(obj)
// /home/user/dir/file.txt
```

### `isAbsolute`
判断路径是否为绝对路径

### `join`
如果连接后的字符串为空则返回 `.` 表示当前工作目录

### `relative`
返回从 `from` 到 `to` 的相对路径
```javascript
path.relative('/data/orandea/test/aaa', '/data/orandea/impl/bbb')
// ../../test/bbb
```

### `resolve([...paths])`
将路径集合解析为一个绝对路径
当前路径为 `/Users/test/test/node`
```javascript
path.resolve('a', 'b/c', '../cc')
// '/Users/test/test/node/a/b/cc'
```
不传参数则返回当前路径
```javascript
path.resolve()
// '/Users/test/test/node'
```

### `sep`
提供了特定平台的片段分隔符
```javascript
'/test/dir/file.md'.split(path.sep)
// [ '', 'test', 'dir', 'file.md' ]
```

## [fs](http://nodejs.cn/api/fs.html)
- 异步
    - 最后一个参数是回调函数
    - 不能保证执行顺序
- 同步
    - 只能用 `try...catch` 捕获异常
### 常用 API
- readFile / readFileSync
- readdir / readdirSync
- readStat / readStatSync

## [querystring](http://nodejs.cn/api/querystring.html)
该模块只有 `4` 个 `API`, 用于解析 / 格式化 `URL` 中的 `querystring`

- parse / stringify

## [http](http://nodejs.cn/api/querystring.html)
### createServer
返回 `http.Server` 实例, 参数作为 `http.Server` 的 `request` 事件回调

```javascript
http.createServer()
    .on('request', (req, res) => {
        // ...
    })
    .listen(8000)
```

### http.Server
[http.Server](http://nodejs.cn/api/http.html#http_class_http_server) 继承自 [`net.Server`](http://nodejs.cn/api/net.html#net_class_net_server)

- 'request' 事件
接收到请求时触发   
回调函数参数:  
    - http.IncomingMessage
        - headers
        - method 
        - url
    - http.ServerResponse
        - end([data][, encoding][, callback])
        - setHeader  
            设置 `cookie`
```javascript
http.createServer()
    .on('request', (req, res) => {
        res.setHeader('Set-Cookie', ['name=测试', 'age=22'])
        res.end()
    })
    .listen(8000)
```
        - statusCode
        - statusCodeMessage
        - getHeader
        - getHeaders
        - getHeaderNames
        - hasHeader
        - removeHeader
        - write(chunk[, encoding][, callback])  
            发送一块响应主体, 可多次调用
        - writeHead(statusCode[, statusMessage][, headers])  
            只能调用一次, `headers` 参数优先级高于 `setHeader`

