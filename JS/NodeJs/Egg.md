# Egg 框架学习笔记

## Links
- [官网](https://eggjs.org/zh-cn/intro/index.html)

## 简介
- 设计原则  
    约定优于配置, (`hapi` 为配置优于编码，业务逻辑必须和传输层进行分离...)
- Egg2
    Egg2 基于 Koa2, 只支持 NodeJs 8.x
- Koa2
    - 洋葱圈模型  
        ![洋葱圈模型](https://camo.githubusercontent.com/d80cf3b511ef4898bcde9a464de491fa15a50d06/68747470733a2f2f7261772e6769746875622e636f6d2f66656e676d6b322f6b6f612d67756964652f6d61737465722f6f6e696f6e2e706e67)
        ![洋葱圈模型](https://raw.githubusercontent.com/koajs/koa/a7b6ed0529a58112bac4171e4729b8760a34ab8b/docs/middleware.gif)
    - 异常处理
```javascript
async function onerror(ctx, next) {
    try {
        await next();
    } catch (err) {
        ctx.app.emit('error', err);
        ctx.body = 'server error';
        ctx.status = err.status || 500;
    }
}
```

## Koa2 常用 API
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


