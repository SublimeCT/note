# Koa2 常用 API
![](http://www.ruanyifeng.com/blogimg/asset/2017/bg2017080801.png)
```javascript
{
    "request": {
        "method": "GET",
        "url": "/?test",
        "header": {
            "x-real-ip": "127.0.0.1",
            "x-forwarded-for": "127.0.0.1",
            "host": "test-node.com",
            "x-nginx-proxy": "true",
            "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36",
            "upgrade-insecure-requests": "1",
            "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
            "accept-encoding": "gzip, deflate",
            "accept-language": "zh-CN,zh;q=0.9"
        }
    },
    "response": {
        "status": 404,
        "message": "Not Found",
        "header": {
            "x-response-data": "[object Object]",
            "content-type": "application/json; charset=utf-8"
        }
    },
    "app": {
        "subdomainOffset": 2,
        "proxy": false,
        "env": "development"
    },
    "originalUrl": "/?test",
    "req": "<original node req>",
    "res": "<original node res>",
    "socket": "<original node socket>"
}
```

## app
- app.env 默认是 `NODE_ENV`
- app.listen()  
```javascript
# Koa
app.listen(8001)
# 对应原生 NodeJS
http.createServer(app.callback()).listen(8001)
```
- app.use()
- app.subdomainOffset 获取子域时的偏移量, 默认为 2

## req / ctxres
NodeJS 的 createServer 中的回调的 request/response
> response 默认必须通过 `ctx.response` 处理, 不可以直接使用 `res` 的 `statusCode` / `writeHead` / `write` / `end`  
可以显式设置 `ctx.respond` 绕过必须使用 `ctx.response` 的限制

## state
推荐的命名空间

## cookies.get(name[,options])
[cookie 模块](https://github.com/jed/cookies)
## cookies.set(name, value[,options])

## throw(status, msg, properties)
[http-errors 模块](https://github.com/jshttp/http-errors)

## request
Koa 封装的 request
- ctx.header / ctx.headers
- ctx.method
- ctx.url  
    `'http://test-node.com'`  
- ctx.origin  
    `'/?username=sven&page=2'`  
- ctx.href  
    `'http://test-node.com/?username=sven&page=2'`  
- ctx.path  
    `'/'`  
- ctx.querystring  
    `'username=sven&page=2'`  
- ctx.host  
    `'127.0.0.1:8001'`  
- ctx.hostname  
    `'127.0.0.1'`  
- **ctx.request.type**  
    `'text/plain'` 可能为空  
- **ctx.request.charset**  
    `'utf-8'` 可能为空  
- ctx.query  
    `{ username: 'sven', page: '2' }`  
- ctx.protocol  
    `'http'`  
- ctx.subdomains  
将子域返回为数组  
> 如果域名为 `sven.email.example.com`  
默认返回 `['email', 'sven']`  
设置 `app.subdomainOffset` 为 3， 则返回 `['sven']`  


## response
Koa 封装的 response
- ctx.status  
默认 404  
- **ctx.response.header** / **ctx.response.headers**  
- ctx.message  
- ctx.body  
    设置后 `status` 将被设置为 200  
- ctx.set(name, value)  
```javascript
ctx.set('Cache-Control', 'no-cache')
ctx.set({
    'Cache-Control': 'no-cache',
    'Etag': 123
})
```
- ctx.remove(name)
- ctx.type
```javascript
// 不含 chartset
console.log(ctx.type)   // 'image/png'
ctx.type = 'text/plain; charset=utf-8'
```
- ctx.redirect

## 所有被挂在到 ctx 上的 request/response 属性
- [request](https://koa.bootcss.com/#request-)
- [response](https://koa.bootcss.com/#response-)
