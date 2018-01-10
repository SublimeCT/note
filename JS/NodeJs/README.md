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
