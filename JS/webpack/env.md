# 基于 Webpack 从零开始搭建开发环境

## 资源
- [教程](https://blog.csdn.net/cvchihzhza/article/details/79028082)

## plugins
### [html-webpack-plugin](https://blog.csdn.net/xiaowoniuqiren/article/details/78568739)
用于打包 html 文件

### copy-webpack-plugin
复制静态文件

### extract-text-webpack-plugin
将内容(一般为 scss/css)抽离, 防止加载到 js 中

## 安装
```bash
yarn add -D html-webpack-plugin copy-webpack-plugin extract-text-webpack-plugin clean-webpack-plugin
```

## 配置文件
```javascript
const path =require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const ExtractTextPlugin = require("extract-text-webpack-plugin")
const extractCSS = new ExtractTextPlugin('css/[name]-css.css')
const extractSASS = new ExtractTextPlugin('css/[name]-sass.css')
//构建前删除dist目录  
const CleanWebpackPlugin = require('clean-webpack-plugin')  
  
module.exports={
    entry:'./src/js/index.js',//入口JS  
    output:{
        filename:'bundle.js',
        path:path.resolve(__dirname,'./dist')  
    },
    module:{
        rules:[  
            {
                test:/\.css$/,
                use: extractCSS.extract({                     
                      use: "css-loader",
                      fallback: "style-loader"  
                })
            },
            {
                test:/\.scss$/,
                use: extractSASS.extract({
                    use: [  
                        {loader: "css-loader"}, 
                        {loader: "sass-loader"}  
                    ],
                    fallback: "style-loader"  
                })  
            },
            {
                test: /\.js$/,
                exclude: /(node_modules|bower_components)/,
                use: {
                    loader: 'babel-loader',
                    options:{
                        cacheDirectory:true//缓存  
                    }  
                }  
            },
            { //打包css里的图片  
               test: /\.(png|jpg|gif|jpeg)$/,
               use: [  
                 {
                   loader: 'url-loader',
                   options: {
                     limit: 8192,//小于8KB,就base64编码  
                     name:'img/[name].[ext]',   //在哪里生成  
                     publicPath:'../'    //在生成的文件引用,前面加  
                   }  
                 }  
               ]  
             }  
        ]  
    },
    plugins: [  
        new HtmlWebpackPlugin(  
        {          
            template: './src/index.html',// 模板文件            
            filename: 'index.html'  
        }  
        ),
        new CopyWebpackPlugin([  
            {from:'./src/img',to:'./img'}  
        ]),
        extractCSS,
        extractSASS,
        new CleanWebpackPlugin(['dist','build'],{
            verbose:false,
            exclude:['img']//不删除img静态资源  
        })
    ]
}
```

