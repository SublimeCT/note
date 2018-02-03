# [cross-env](https://npm.js.cn/package/cross-env)

## 简介

`cross-env` 能够跨平台地设置及使用环境变量

```json
{
    "scripts": {
        "build": "cross-env NODE_ENV=production webpack --config build/webpack.config.js",
        “parentScript”: "cross-env GREET=\"sven\" npm run childrenScript",
        "childrenScript": "echo \"hello $GREET\""
    }
}
```

## NODE_ENV
通过 `NODE_ENV` 的值对区分生产环境和开发环境, 默认为 `development`

### 设置
- Linux/Mac `export NODE_ENV=production`
- Windows `set NODE_ENV=production`

```javascript
if (process.env.NODE_ENV === 'production') {
    // just for production code ...
}
```
