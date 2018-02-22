# mongoose 扩展

## 简介
`mongoose` 是在 `NodeJS` 环境下对 `mongodb` 进行便捷操作的对象模型工具

## links
- marks
    - [文档](http://mongoosejs.com/docs/guide.html)
- posts
    - [API 详解](https://segmentfault.com/a/1190000010688972)
    - [简要 API](https://segmentfault.com/a/1190000008366129)
    - [教程](https://github.com/alsotang/node-lessons/tree/master/lesson15)

## 操作
### Connect
指定用户连接
```javascript
mongoose.connenct('mongodb://username:password@127.0.0.1:27017/darabaseName'[, optins, callback])
```

连接多个数据库
```javascript
mongoose.connect('mongodb://127.0.0.1:27017/db1,mongodb://127.0.0.1:27017/db2', {mongos: true})
```

### Schema
> `Schema` 是对 `Collection` 结构的定义, 每个 `Schema` 映射一个 `Collection`, 不具备数据库的操作能力

创建
```javascript
const mongoose = require('mongoose')
const ObjectId = mongoose.Types.ObjectId
const ArticleSchema = new mongoose.Schema({
    type: {
        type: String,
        required: true
    },
    contents: String,
    category: {
        type: String,
        ref: 'Category' // 关联 Category 表的 _id
    },
    createTime: {
        type: Date,
        default: Date.now
    },
    field_1: {
        type: Array,
        index: true // 索引
    }
}, {
    connect: 'Article' // 集合名称
})
```

字段类型
- String
- Number
- Date
- Buffer
- Boolean
- Mixed
- ObjectId
- Array

### Model
> `Model` 是由 `Schema` 编译而成的假想构造器, 具有抽象属性和行为, `Model` 的每一个实例就是一个 `document`

创建一个名为 `Article` 的 `Model`
```javascript
const ArticleModel = mongoose.model('Article', ArticleSchema)
```

#### 扩展
- Model 实例
```javascript
Article.methods.methodName = () => {}
```
- Model 静态方法
```javascript
Article.statices.methodName = () => {}
```

#### 创建
model/Article.js
```javascript
const ArticleSchema = require('./schema/Article.js')
module.exports = mongoose.model('Article', ArticleSchema)
```

#### 扩展
demo.js
```javascript
Model.find(condition[, fields, options, callback])
```














