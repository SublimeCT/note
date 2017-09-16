# 进击的Node.js基础一[慕课网]
----------
## 〇. 准备
### 1.各版本的差别
> 偶数 为稳定版本  
基数 是非稳定版本

> **0.x** 完全不支持 ES6 [*由Joyent公司维护*]  
**4.x** 部分支持ES6特性 [*由 nodejs 基金会维护*]  
**6.x** 支持 98% 的 ES6 特性

### 2. cnpm
```shell
    sudo npm install -g cnpm --registry=https://registry.npm.taobao.org
```

## 一 NodeJS API
> [NodeJS中文文档](http://nodejs.cn/

### *url*

**url.parse(string)**
```shell
> const a = url.parse('https://www.zybuluo.com/mdeditor#886740')
Url {
  protocol: 'https:',
  slashes: true,
  auth: null,
  host: 'www.zybuluo.com',
  port: null,
  hostname: 'www.zybuluo.com',
  hash: '#886740',
  search: null,
  query: null,
  pathname: '/mdeditor',
  path: '/mdeditor',
  href: 'https://www.zybuluo.com/mdeditor#886740' }
```

**url.format(object)**
```shell
> const b = url.format(a);
undefined
> b
'https://www.zybuluo.com/mdeditor#886740'
```

**url.resolve(string, string)**
```shell
> url.resolve('http://a.com/dfa/df', '/ss/ss')
'http://a.com/ss/ss'
> url.resolve('http://a.com/dfa/df', 'ss/ss')
'http://a.com/dfa/ss/ss'
```

**url.parse(string[,bool,[bool]])**
```shell
> url.parse('http://a.com?a=1#kldjfklaj')
Url {
  protocol: 'http:',
  slashes: true,
  auth: null,
  host: 'a.com',
  port: null,
  hostname: 'a.com',
  hash: '#kldjfklaj',
  search: '?a=1',
  query: 'a=1',
  pathname: '/',
  path: '/?a=1',
  href: 'http://a.com/?a=1#kldjfklaj' }
> url.parse('http://a.com?a=1#kldjfklaj', true)
Url {
  protocol: 'http:',
  slashes: true,
  auth: null,
  host: 'a.com',
  port: null,
  hostname: 'a.com',
  hash: '#kldjfklaj',
  search: '?a=1',
  query: { a: '1' },
  pathname: '/',
  path: '/?a=1',
  href: 'http://a.com/?a=1#kldjfklaj' }
```

### *querystring*

**querystring.stringify(object)**
```shell
> querystring.stringify({name:'sven',course:['Tom','Jack'],from:'1'})
'name=sven&course=Tom&course=Jack&from=1'
> querystring.stringify({name:'sven',course:['Tom','Jack'],from:'1'}, ',', ':')
'name:sven,course:Tom,course:Jack,from:1'
```

**querystring.parse(string,...)**
```shell
> querystring.parse('name=sven&course=Tom&course=Jack&from=1')
{ name: 'sven', course: [ 'Tom', 'Jack' ], from: '1' }
```

**querystring.escape(string)**
```shell
> querystring.escape('<哈哈>')
'%3C%E5%93%88%E5%93%88%3E'
```

**querystring.unescape(string)**
```shell
> querystring.escape('<哈哈>')
'%3C%E5%93%88%E5%93%88%3E'
```

## 事件模块

> NodeJS 通过 events 模块实现发布-订阅模式

```javascript
    const EventEmitter = require('events').EventEmitter
    const life = new EventEmitter
    let counter = 0;
    
    // 设置最大监听器数量
    life.setMaxListeners(2)
    
    function test() {
        console.log('= =')
    }
    
    life.on('start', function (who) {
        console.log('It\'s my life'+(++counter))
    })
    life.on('start', function (who) {
        console.log('It\'s my life'+(++counter))
    })
    life.on('start', function (who) {
        console.log('It\'s my life'+(++counter))
    })
    
    life.on('start', test)
    
    // 移除事件函数
    life.removeListener('start', test)
    // life.removeALlListeners('start')
    // life.removeALlListeners()
    
    life.emit('start') //返回是否成功执行事件函数
    // 指定事件的事件函数数量
    console.log(life.listeners('start').length)
```

## HTTP request

> 使用 http 模块发起一个慕课网评论请求

- 先在浏览器发起一个请求, 复制 request header
- 修改 header 中的 Content-Length 为 form-data 长度
- 通过 http.request 发起一个 POST 请求

```javascript
    const http = require('http')
    const querystring = require('querystring')
    
    const postData = querystring.stringify({
        content: '测试一下啊啊啊啊',
        mid: 8837
    })
    
    const options = {
        hostname: 'www.imooc.com',
        port: 80,
        path: '/course/docomment',
        method: 'POST',
        headers: {
            'Accept': 'application/json, text/javascript, */*; q=0.01',
            'Accept-Encoding': 'gzip, deflate',
            'Accept-Language': 'zh-CN,zh;q=0.8',
            'Connection': 'keep-alive',
            'Content-Length': Buffer.byteLength(postData),
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            'Cookie': 'PHPSESSID=m83c0rme8rl3p7bg2kom4bor32; imooc_uuid=77b16437-84ed-4748-b3fa-0e9bae7b451b; imooc_isnew=1; imooc_isnew_ct=1505524003; loginstate=1; apsid=VkYzkxMTYzZjU3NTg2MWNkMDcyZjFlZjZlM2E1YTEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMzM2MzI4OAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABoZXlzdW5jaGl3ZW5AMTYzLmNvbQAAAAAAAAAAAAAAADMzMWZhYmU3ZTcyMzE2MWU0ODgyNzllYWI1M2YyNWM5vXq8Wb16vFk%3DMT; last_login_username=heysunchiwen%40163.com; IMCDNS=0; Hm_lvt_f0cfcccd7b1393990c78efdeebff3968=1505524005; Hm_lpvt_f0cfcccd7b1393990c78efdeebff3968=1505535897; cvde=59bc79239e4f5-89',
            'Host': 'www.imooc.com',
            'Origin': 'http://www.imooc.com',
            'Referer': 'http://www.imooc.com/video/8837',
            'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',
            'X-Requested-With': 'XMLHttpRequest'
        }
    }
    
    const request = http.request(options, function (res) {
        console.log(`status： ${res.statusCode}`)
        console.log(`response header： ${JSON.stringify(res.headers)}`)
        res.setEncoding('utf8')
        res.on('data', (chunk) => {
            console.log(`响应主体: ${chunk}`)
        })
        res.on('end', () => {
            console.log('响应中已无数据。')
        })
    })
    
    request.on('error', function (e) {
        console.error('error: '+e)
    })
    
    request.write(postData)
    request.end()
    
    console.log('???')
```

## Promise
> Promise 是一个为了解决回调函数层层嵌套的解决方案  
[介绍](http://www.jianshu.com/p/063f7e490e9a)

```html
    <style>
        .ball{
            margin-left: 0;
            width: 100px;
            height: 100px;
            border-radius: 50%;
        }
        .ball1 {  background: red;  }
        .ball2 {  background: yellow;  }
        .ball3 {  background: blue;  }
    </style>
    <div class="ball ball1"></div>
    <div class="ball ball2"></div>
    <div class="ball ball3"></div>
```

```javascript
    let [ball1, ball2, ball3] = document.getElementsByClassName('ball')
    const promiseAnimate = function (ball, positionLeft) {
        return new Promise(function (resolve, reject) {
            function _animate() {
                setTimeout(function () {
                    let left = parseInt(ball.style.marginLeft || 0)
                    if (left === positionLeft) {
                        resolve()
                    } else {
                        if (left > positionLeft) {
                            left--
                        } else {
                            left++
                        }
                        ball.style.marginLeft = left+'px'
                        _animate()
                    }
                }, 12)
            }
            _animate()
        })
    }
    promiseAnimate(ball1, 100)
        .then(function () {
            return promiseAnimate(ball2, 200)
        })
        .then(function () {
            return promiseAnimate(ball3, 300)
        })
        .then(function () {
            return promiseAnimate(ball3, 150)
        })
        .then(function () {
            return promiseAnimate(ball2, 150)
        })
        .then(function () {
            return promiseAnimate(ball1, 150)
        })
```

