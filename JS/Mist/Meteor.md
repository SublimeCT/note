# Meteor Note For v1.6

***[官方文档](https://www.meteor.com/tutorials/blaze) (Blaze 版本)项目笔记***

## Blaze
> 官网项目中的视图层基于 `Blaze` [官方文档](http://blazejs.org/)

## imports 目录
> `imports` 目录外的文件将在 `Meteor服务器` 启动时自动加载，而 `imports` 目录中的文件只有在使用 `import` 语句加载时才会加载

## [集合](https://guide.meteor.com/collections.html) 
> Meteor 中的数据库可以在服务器端和客户端同时访问, 且提供了完全一致的 `MongoDB API`

### 创建集合
```javascript
# 在服务器端执行时创建了一个 Test 数据库
# 在客户端通过 Minimongo 库将服务器端的数据缓存到客户端
Test = new Mongo.collection('Test')
# 创建本地集合
Test = new Mongo.collection(null)
Test2 = new Mongo.collection('Test', {connection: null})
```





