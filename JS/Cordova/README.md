# Cordova note

## 安装
```bash
# 安装失败时进入 cordova 目录 sudo rm -rf nodeo_modules
# 必须使用 npm 安装
sudo npm install -g cordova --registry=https://registry.npm.taobao.org
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



