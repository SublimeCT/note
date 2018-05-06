# Webpack 笔记

## links
- [慕课网 webpack深入与实战](http://www.imooc.com/learn/802)  
- [webpack 中文文档](https://doc.webpack-china.org/concepts/)
- [入门](https://www.jianshu.com/p/42e11515c10f)
- [慕课网笔记](https://github.com/SublimeCT/note/blob/master/JS/webpack/Webpack.md)

## 简介
当前版本号为 `v4.6.0`

> 本质上，webpack 是一个现代 JavaScript 应用程序的**静态模块打包器**(module bundler)。当 webpack 处理应用程序时，它会递归地构建一个**依赖关系图**(dependency graph)，其中包含应用程序需要的每个模块，然后将所有这些模块打包成一个或多个 bundle

## cli
必须安装 `webpack-cli`
```bash
$ yarn global add webpack webpack-cli
```

`v4.x` 需要指定 `mode`
```bash
$ webpack --mode development
```

## 配置

### 结构
```javascript
module.exports = {
    entry: './src/index.js', // 默认值
    output: { // 默认值
        path: __dirname + '/dist',
        filename: 'main.js'
    },
    mode: 'development', // 4.x 新增, 默认为 production
    module: {
        rules: [
            {test: /\.scss$/, }
        ]
    }
}
```

### 配置文件
默认加载的配置文件是 `webpack.config.js`

## 入口起点
语法: `entry: {[entryChunkName: string]: string|Array<string>}`

### 单入口
```javascript
module.exports = {
    entry: {
        main: './src/index.js'
    }
    // entry: './src/index.js' // 简写形式
}
```

### 多入口
参见 [文档](https://doc.webpack-china.org/concepts/entry-points/#常见场景)

## 输出

### 单入口
```javascript
module.exports = {
    output: {
        filename: 'bundle.js',
        path: '/usr/local/project' // 绝对路径
    }
}
```

### 多入口
应该使用 `占位符` 确保每个文件具有唯一的名称

```javascript
module.exports = {
    entry: {
        app: './src/app.js',
        vender: './src/vender.js'
    },
    output: {
        filename: '[name].js', // 占位符
        path: __dirname + '/dist' // 绝对路径
    }
}
```

### 资源文件引用的目录 [🔗](https://blog.csdn.net/kcetry/article/details/53300331)

