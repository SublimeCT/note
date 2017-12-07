# [Cordova](http://cordova.axuer.com/) note

## 安装
使用 npm 淘宝源安装
```bash
sudo npm i -g cordova --registry=https://registry.npm.taobao.org
```
报错处理:  
    - 删除全局目录下的 `cordova` 模块的 `node_modules` 目录
    - 安装失败时进入 cordova 目录 sudo rm -rf nodeo_modules
```bash
sudo rm -rf /usr/local/nodejs/lib/node_modules/cordova/node_modules/
```
可能还需要使用软连接
```bash
sudo ln -s /usr/local/nodejs/bin/cordova /usr/local/bin
```

## demo
```bash
cordova create MyApp
cd MyApp
cordova platform add browser
cordova run browser
```

## 打包


### 使用 webpack 打包应用程序

打包时忽略原生 `node` 模块
```json
# webpack.cordova.config.js
node: {
    net: 'empty'
}
```

创建 cordova 项目目录并将打包后的 www 目录复制进来
```bash
cordova create testCordova
```

## Android 环境

安装 add-apt-repository
```bash
sudo apt-get install python-software-properties
sudo apt-get update
sudo apt install software-properties-common 
sudo apt-get update
```

通过 ppa 方式安装
```bash
sudo add-apt-repository ppa:webupd8team/java
```
