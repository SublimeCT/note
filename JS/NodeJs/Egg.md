# Egg 框架学习笔记

## Links
- [官网](https://eggjs.org/zh-cn/intro/index.html)
- [官网资源列表](https://github.com/eggjs/awesome-egg)
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

## 约定
### 目录结构
```bash
egg-project
├── package.json
├── app.js (可选) 用于初始化
├── agent.js (可选) 用于初始化
├── app
|   ├── router.js
│   ├── controller
│   |   └── home.js
│   ├── service (可选)
│   |   └── user.js
│   ├── middleware (可选)
│   |   └── response_time.js
│   ├── schedule (可选) 内置插件约定的目录: 定时任务
│   |   └── my_task.js
│   ├── public (可选) 内置插件约定的目录: 静态资源目录
│   |   └── reset.css
│   ├── view (可选)
│   |   └── home.tpl
│   └── extend (可选) 扩展目录
│       ├── helper.js (可选)
│       ├── request.js (可选)
│       ├── response.js (可选)
│       ├── context.js (可选)
│       ├── application.js (可选)
│       └── agent.js (可选)
├── config
|   ├── plugin.js 用于配置需要加载的插件
|   ├── config.default.js
│   ├── config.prod.js
|   ├── config.test.js (可选)
|   ├── config.local.js (可选)
|   └── config.unittest.js (可选)
└── test
    ├── middleware
    |   └── response_time.test.js
    └── controller
        └── home.test.js
```

### /app.js
框架入口文件, 通常用于添加生命周期钩子
```javascript
// 加载应用启动必须的数据(例: 城市列表)
module.exports = app => {
    // 应用会等所有钩子执行完才启动
    app.beforeStart(async () => {
        app.cities = await app.curl('http://test.map.com/map.json', {
            method: 'GET',
            dataType: 'json'
        })
    })
}
```

#### 环境变量映射
NODE_ENV | EGG_SERVER_ENV | 说明
-- | -- | --
_ | local | 本地开发环境
test | unittest | 单元测试
production | prod | 生产环境 

## Application
继承自 `Koa.Application`

### 扩展
框架将 `app/extends/application.js` 中的对象和 `Koa.Application.prototype` 合并后的对象作为 `app`

```javascript
const EGG_PROPERTY = Symbol('Application#eggProperty')
module.exports = {
    eggMethod (str) {
        return str
    },
    get eggProperty () { // 扩展计算属性时使用缓存以提高性能
        // this 指向 app
        return this[EGG_PROPERTY] ? this[EGG_PROPERTY] : (this[EGG_PROPERTY] = 123)
    }
}
```

### 事件
在框架[入口文件](https://github.com/SublimeCT/note/blob/master/JS/NodeJs/Egg.md#/app.js)添加钩子  
[实例](http://eggjs.org/zh-cn/basics/objects.html#%E4%BA%8B%E4%BB%B6)

- server `http` 服务启动后触发
- error
- request/response

## Context
### 扩展
框架将 `app/extends/context.js` 中的对象和 `Koa.Context.prototype` 合并后的对象作为 `ctx`

## Request / Response
框架将 `app/extends/request.js` 中的对象和 `Koa.Request.prototype` 合并后的对象作为 `ctx.request`

> 通过 `ctx.request.body` 映射 `POST` 请求

## Controller
负责解析 & 处理请求参数, (通过 Service)返回相应结果

### 属性
- ctx
- app
- config
- service
- logger

### [内置表单验证](https://eggjs.org/zh-cn/basics/router.html#%E8%A1%A8%E5%8D%95%E6%A0%A1%E9%AA%8C)
~~基于 [egg-validate](https://github.com/eggjs/egg-validate) 插件~~, [验证规则](https://github.com/node-modules/parameter#rule)

### [获取上传文件](https://eggjs.org/zh-cn/basics/controller.html#%E8%8E%B7%E5%8F%96%E4%B8%8A%E4%BC%A0%E7%9A%84%E6%96%87%E4%BB%B6)

### cookie
`ctx.cookie.get('xxx')`  
`ctx.cookie.set('xxx', null[, options])`

### session
配置
```javascript
module.exports = {
    key: 'EGG_SESS', // 承载 Session 的 Cookie 键值对名字
    maxAge: 86400000, // Session 的最大有效时间
}
```

### jsonp
内置 `jsonp` 中间件, 客户端请求参数中必须加入 `_callback=xxx`  
[白名单设置](https://eggjs.org/zh-cn/basics/controller.html#referrer-%E6%A0%A1%E9%AA%8C)  
```javascript
// app/router.js
module.exports = app => {
    const jsonp = app.jsonp()
    app.router.get('/api/posts/:id', jsonp, app.controller.posts.show)
}
```

## Service
### 属性
- app
- ctx
- service
- config
- logger

## Helper
框架将 `app/extends/helper.js` 中的对象和 `Koa.Helper.prototype` 合并后的对象作为 `helper`

## Config
### 加载
先加载默认配置 `config.default.js`, 然后根据运行环境加载 `config.*.js`  

### 指定环境变量
- `config/env` 文件
- `EGG_SERVER_ENV` 变量  
```bash
EGG_SERVER_ENV=prod npm start
```

### 获取运行环境
`app.config.env`

### 配置文件
可以使用 `配置对象方式` 和 `function` 方式
```javascript
/**
 * 配置日志文件目录
 * 生产环境为 /home/admin/logs
 * 开发环境为 应用目录/logs
 */
module.exports = appInfo => {
    return {
        logger: {
            dir: path.join(appInfo.root, 'logs')
        }
    } 
}
```

### appInfo 属性
appInfo | 说明
-- | --
pkg | package.json
name | 应用名，同 pkg.name
baseDir | 应用代码的目录
HOME | 用户目录，如 admin 账户为 /home/admin
root | 应用根目录，只有在 local 和 unittest 环境下为 baseDir，其他都为 HOME

### 配置结果
进程 | 最终配置 | 配置属性来源信息
-- | -- | --
Worker | `run/application_config.json` | `run/application_config_meta.json`
Agent | `run/agent_config.json` | `run/agent_config_meta.json`

## Logger

## Subscript

## Middleware
### 位置
位于 `app/middleware`

### 编写
middleware 文件 export 一个 `function`, 参数包含 `app.config[${middlewareName}]` 和 `app`
```javascript
module.exports = (options, app) => {
    return async (ctx, next) => {
        return await options.prefix + (new Date()).toLocaleString()
    }
}
```

### 手动挂载
必须手动挂载中间件才能生效

```javascript
module.exports = {
    middleware: ['getDate'],
    getDate: {
        prefix: 'Now: '
    }
}
```

### 通用配置
- enable
- match  
    参数为 `String` / `Regexp` 时匹配 URL, 为 `Function` 时直接执行
- ignore  
    与 `match` 相反

### 使用 Koa 中间件
```javascript
// config/config.default.js
module.exports = {
    middle: ['webpack', 'koa-compress'],
    bodyParser: {
        enable: false
    },
    webpack: {
        test: 'test'
    },
    myMiddleware: {
        match: ctx => {
            return /iphone|ipad|ipod/.test(ctx.get('user-agent'))
        }
    }
}
// app/middleware/koa-compress.js
module.exports = require('koa-compress')
// app/middleware/webpack.js
const webpackMiddleware = require('some-koa-middleware')
module.exports = options => {
    return webpackMiddleware(options.test)
}
```

## Router
### 定义
`router.verb(['router-name',]'path-match', [middleware1, ... middlewareN, ]app.application.action)`
- `verb` HTTP method
- `router-name` 路由别名
- `path-match` URL
- `middleware` 所有中间件
- `controller`  
格式为 `${directoryName}.${fileName}.${functionName}`

```javascript
// app/router.js
module.exports = app => {
    const {router, controller} = app
    router.get('/search', app.controller.search.index)
    router.get('/search/:id', app.controller.search.details)
    router.get(/^\/package\/([\w-.]+\/[\w-.]+)$/, app.controller.package.details)
    router.redirect('/', '/xxx', 302)
}
// app/controller/search.js
exports.index = async ctx => {
    ctx.body = `search-page: ${ctx.query.page}` // curl http://127.0.0.1:7001/search?page=2
}
exports.details = async ctx => {
    ctx.body = `id: ${ctx.params.id}` // curl http://127.0.0.1:7001/search/91890328
}
// app/controller/package.js
exports.details = async ctx => {
    ctx.body = `package: ${ctx.params[0]}` // curl http://127.0.0.1:7001/package/91890328
}
```

## 插件
### 使用
通常使用 npm 模块方式复用
```bash
npm i egg-mysql --save
```
### 配置
推荐通过 `plugin.${env}.js` 声明
```javascript
// config/plugin.js
exports.mysql = {
    enable: true,
    package: 'egg-mysql', // npm 模块名称
    package: path.join(__dirname, '../lib/plugin/egg-mysql'), // 插件绝对路径, 与 package 互斥
    env: ['prod'] // 指定运行环境 
}
// controller
app.mysql.query(sql)
```

## 定时任务
[文档](https://eggjs.org/zh-cn/basics/schedule.html)

## 框架核心对象扩展
Application / Context / Request / Response / Helper 在 `app/extend/${objectName}[.${envName}].js` 文件中根据运行环境进行扩展

## egg-bin



