## 安装

```bash
sudo cnpm i -g webpack
sudo ln -s /usr/local/nodejs/bin/webpack /usr/local/bin
```

## 工作方式
把项目当作一个整体, 通过指定的入口文件将所有依赖文件使用 `loader` 处理, 最后打包成浏览器可识别的 `js` 文件

## 命令行中使用

```shell
.  
├── hello.bundle.js  
├── hello.js  
├── index.htm  
├── node_modules  
├── package.json  
├── style.css  
└── world.js  
```

**./hello.js**

```javascript
import world from './world'
import style from 'style-loader!css-loader!./style.css'

function hello (str) {
    alert(str)
}

hello('Hello Webpack!')
```

**./index.htm**
```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Test</title>
</head>
<body>
    <h2>test</h2>
    <script src="./hello.bundle.js"></script>
</body>
```

> 需要先安装打包 css 文件所需的 loader

```shell
cnpm i style-loader css-loader --save-dev
webpack hello.js hello.bundle.js
```

## 配置
> webpack 命令默认使用 ./webpack.config.js 作为配置文件  
或者通过 --config example.config.js 指定配置文件

**./webpack.config.js**
```javascript
const path = require('path')

// 不能使用 ES6 的模块语法
module.exports = {
    entry: './src/main.js',
    output: {
        path: path.resolve(__dirname, 'dist/js'),
        filename: 'bundle.js'
    }
}
```

或者在 `./package.json` 中添加命令脚本
```javascript
{
    "script": {
        "webpack-dev": "webpack --config webpack.dev.config.js --progress --display-modules --colors"
    }
}
```

```shell
npm run webpack-dev
```

**打包多个 chunk**
```javascript
const path = require('path')

module.exports = {
    entry: {
        main: './src/script/main.js',
        a: './src/script/a.js'
    },
    output: {
        path: path.resolve(__dirname, 'dist/js'),
        filename: '[name]-[hash].js'
    }
}
```

## 生成 HTML
> 通过 [html-webpack-plugin](https://www.npmjs.com/package/html-webpack-plugin) 插件生成 HTML 文件

```shell
cnpm i html-webpack-plugin --save-dev
```

**webpack.dev.config.js**
```javascript
const path = require('path')
const htmlWebpackPlugin = require('html-webpack-plugin')

module.exports = {
    entry: './src/script/main.js',
    output: {
        // 将 path 改为 dist 目录
        path: path.resolve(__dirname, 'dist/'),
        // 改为 dist/js 目录下
        filename: 'js/[name]-[hash].js'
    },
    plugins: [
        new htmlWebpackPlugin({
            // 相对于 output.path
            filename: 'index-[hash].htm',
            template: 'index.htm',
            inject: 'head'
        })
    ]
}
```

## 核心

> webpack 是一个 JavaScript 应用程序的模块打包器  

```javascript
// webpack.config.js
const webpack = require('webpack')
const path = require('path')
module.exports = {
    entry: './path/to/my/entry/file.js',
    output: {
        path: path.resolve(__dirname, 'dist'),
        filename: 'my-first-webpack.bundle.js'
    },
    loader: {
        rules: [
            {
                test: /\.(js|vue)$/,
                use: 'eslint-loader'
            }
        ]
    },
    plugins: [
        new webpack.optimize.UglifyJsPlugin()
    ]
}
```

* webpack 处理应用程序 
    - 递归的创建依赖关系树(dependency graph), 其中包含应用程序需要的每个模块
    - 将这些模块打包成 bundle

* 入口 entry
> entry 是依赖关系树的入口文件， entry 告诉 webpack 从哪里开始

* 出口 output
> 描述在哪里打包应用程序

* loader
> 在文件被添加到依赖图中时, 将其转换为模块

* plugins
> 一般用于在 compilation / chunk 的生命周期执行操作和自定义功能
