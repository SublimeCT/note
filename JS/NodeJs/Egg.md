# Egg 框架学习笔记

## Links
- [官网](https://eggjs.org/zh-cn/intro/index.html)
- [Koa2 Wiki](https://github.com/koajs/koa/wiki)
- [Koa2 中文文档](https://koa.bootcss.com/)

## 简介
### 设计原则  
    约定优于配置, (`hapi` 为配置优于编码，业务逻辑必须和传输层进行分离...)
### Egg2
    Egg2 基于 Koa2, 只支持 NodeJs 8.x
### Koa2
#### 洋葱圈模型  
![洋葱圈模型](https://camo.githubusercontent.com/d80cf3b511ef4898bcde9a464de491fa15a50d06/68747470733a2f2f7261772e6769746875622e636f6d2f66656e676d6b322f6b6f612d67756964652f6d61737465722f6f6e696f6e2e706e67)
![洋葱圈模型](https://raw.githubusercontent.com/koajs/koa/a7b6ed0529a58112bac4171e4729b8760a34ab8b/docs/middleware.gif)

#### 异常处理
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

## Koa2
[常用 API 整理](https://github.com/SublimeCT/note/blob/master/JS/NodeJs/Koa2.md)

## [快速搭建](https://eggjs.org/zh-cn/intro/quickstart.html#逐步搭建)

### static
Koa 内置 [static](https://github.com/eggjs/egg-static) 插件, 将 `/public/*` 映射到 `app/public/*`



