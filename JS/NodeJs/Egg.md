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

## 约定
### 目录结构
`
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
`

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

## Request / Response

## Controller
### 属性
- ctx
- app
- config
- service
- logger

## Service

## Helper

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


