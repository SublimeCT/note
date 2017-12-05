# Meteor Note For v1.6

## 资源
- [官网](https://docs.meteor.com/#learning-more)
- [Mongo 文档](https://docs.mongodb.com/)
- [Mongo API](https://mongodb.github.io/node-mongodb-native/2.0/api/)
- [Mongo 中文文档](http://www.mongoing.com/docs/)
- [todo-list blaze](https://www.meteor.com/tutorials/blaze)
- [Meteor 软件包](https://docs.meteor.com/#learning-more)
- [awesome-meteor 软件包列表](https://github.com/Urigo/awesome-meteor)
- [awesome-meteor github 笔记](https://leohxj.gitbooks.io/learning-node/content/meteor/meteor-file-structure.html)

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


