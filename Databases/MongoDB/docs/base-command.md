# 基本命令整理

## 所有命令
DB methods
```bash
db.help()
```
All commands
```bash
help
```

## 数据库
### 创建
通过 `use [database name]` 指定后并向这个数据库中的 `collection` 插入数据即可创建改数据库
```bash
use noteTest
db.user.insert({userId: '0000001', name: 'xxx', age: 99, email: 'tester@test.com'})
```
### 删除
删除当前数据库
```bash
> db
noteTest2
> db.dropDatabase()
{ "dropped" : "noteTest2", "ok" : 1 }
> show dbs
```

### 重命名
```bash
> use admin
switched to db admin
> db.runCommand({renameCollection: 'noteTest2.user', to: 'noteTest3.user'})
{ "ok" : 1 }
> show dbs
admin      0.000GB
config     0.000GB
local      0.000GB
noteTest   0.000GB
noteTest2  0.000GB
noteTest3  0.000GB
```

## 文档
### [SQL => MongoDB Shell 完整映射表](http://www.mongoing.com/docs/reference/sql-comparison.html#sql-to-mongodb-mapping-chart)
### [insert](http://www.mongoing.com/docs/tutorial/insert-documents.html)
- `db.dbName.insertOne(doc)`
- `db.dbName.insertMany(docArray)`
- `db.dbName.insert(doc | docArray)`
```bash
> db.user.insert({userId: "kjalkjdlkfadf"})
WriteResult({ "nInserted" : 1 })
> db.user.find()
{ "_id" : ObjectId("5a7c17bb534c9917fa65b055"), "userId" : "lkjakjdlkf" }
{ "_id" : ObjectId("5a7cefd0d2e901b5b865f12d"), "userId" : "kjalkjdlkfadf" }
```

- 使用变量插入
```bash
> var testDoc = {userId: 'lkajkljfdjs'}
> testDoc
{ "userId" : "lkajkljfdjs" }
> db.user.insert(testDoc)
WriteResult({ "nInserted" : 1 })
```

### [select](http://www.mongoing.com/docs/tutorial/query-documents.html)
查询条件
- $eq
- $ne
- $lt
- $lte
- $gt
- $gte
- $in
- $nin

逻辑运算符
- $and
- $or
- $not
- $nor  
```bash
> db.user.find()
{ "_id" : ObjectId("5a7c16df534c9917fa65b053"), "userId" : "iuioweuir" }
{ "_id" : ObjectId("5a7d488f62e8c226bbf9ce6f"), "userId" : 1 }
{ "_id" : ObjectId("5a7d488f62e8c226bbf9ce70"), "userId" : 2 }
{ "_id" : ObjectId("5a7d488f62e8c226bbf9ce71"), "userId" : 3 }
> db.user.find({'$nor': [{userId: 1}, {userId: 3}]})
{ "_id" : ObjectId("5a7c16df534c9917fa65b053"), "userId" : "iuioweuir" }
{ "_id" : ObjectId("5a7d488f62e8c226bbf9ce70"), "userId" : 2 }
```

字段
- $exists
- $type

计算/匹配
- $mod
匹配字段值对 3 取模，值等于 0 的文档
```bash
> db.user.find({'modTest': {'$mod': [3, 0]}})
{ "_id" : ObjectId("5a7d4c8e62e8c226bbf9ce72"), "modTest" : 0 }
{ "_id" : ObjectId("5a7d4c8e62e8c226bbf9ce75"), "modTest" : 3 }
{ "_id" : ObjectId("5a7d4c8e62e8c226bbf9ce78"), "modTest" : 6 }
{ "_id" : ObjectId("5a7d4c8e62e8c226bbf9ce7b"), "modTest" : 9 }
```
- $regex [doc](http://www.mongoing.com/docs/reference/operator/query/regex.html#regex)
- $text [doc](http://www.mongoing.com/docs/reference/operator/query/text.html#text)
- $where
```bash
> db.user.find({$where: function () {return this.modTest > 6}})
{ "_id" : ObjectId("5a7d4c8e62e8c226bbf9ce79"), "modTest" : 7 }
{ "_id" : ObjectId("5a7d4c8e62e8c226bbf9ce7a"), "modTest" : 8 }
{ "_id" : ObjectId("5a7d4c8e62e8c226bbf9ce7b"), "modTest" : 9 }
```

Array
- $all
- $elemMatch
```bash
db.user.find({ results: { $elemMatch: { $gte: 80, $lt: 85 } } })
```
- $size

其它
- [Geospatial](http://www.mongoing.com/docs/reference/operator/query.html#geospatial)
- [Bitwise](http://www.mongoing.com/docs/reference/operator/query.html#bitwise)
- [Comments](http://www.mongoing.com/docs/reference/operator/query.html#comments)
- [ProjectionOperators](http://www.mongoing.com/docs/reference/operator/query.html#projection-operators)

### udpate [📚](http://www.mongoing.com/docs/reference/method/db.collection.update.html)
- save
> 使用 `save` 并指定 `_id` 时为更新改条数据  
不指定 `_id` 时与 `insert` 相同

```bash
> db.user.save({_id: ObjectId('5a7c17bb534c9917fa65b055'), userId: 'test'})
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
```
- update [📚](http://www.mongoing.com/docs/reference/method/db.collection.update.html#db-collection-update)  
`db.dbName.udpate(query, update, options)`
    - update 参数 [📃](https://docs.mongodb.com/manual/reference/operator/update/)
        - $set
			```bash
			> db.user.update({sliceTest: '???'}, {$set: {abc: 'def'}})
			WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
			> db.user.find()
			{ "_id" : ObjectId("5a7d5e9c1601de4921bc55a2"), "sliceTest" : "???", "abc" : "def" }
			> db.user.update({_id: ObjectId("5a7d4c8e62e8c226bbf9ce74")}, {$set: {'sliceTest.0': 10086}})
			WriteResult({
				"nMatched" : 0,
				"nUpserted" : 0,
				"nModified" : 0,
				"writeError" : {
					"code" : 52,
					"errmsg" : "The dollar ($) prefixed field '$set' in 'sliceTest.$set' is not valid for storage."
				}
			})
			> db.user.find({_id: ObjectId("5a7d4c8e62e8c226bbf9ce74")})
			{ "_id" : ObjectId("5a7d4c8e62e8c226bbf9ce74"), "sliceTest" : [ 10086, 3, 4, 1 ] }
			```
					- $inc
			```bash
			> db.user.update({userId: 2}, {$inc: {userId: 4}})
			WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
			> db.user.find()
			{ "_id" : ObjectId("5a7d488f62e8c226bbf9ce70"), "userId" : 6 }
			```
		- $addToSet  
			表示要插入的值如果存在则不插入
		- ...
	- options 参数
		- upsert  
			如果没有匹配到文档, 则插入
		- multi
		- ...
	- updateOne
	- updateMany
	- replaceOne  
		将匹配到的第一个文档替换  
		```bash
		> db.users.replaceOne(
			{ name: "abc" },
			{ name: "amy", age: 34, type: 2, status: "P", favorites: { "artist": "Dali", food: "donuts" } }
		)
		```

### delete [📚](http://www.mongoing.com/docs/tutorial/remove-documents.html)
> 官方推荐使用更具语义化的 `removeOne` / `removeMany` 方法

- remove  
删除 collection 中的所有记录
```bash
> db.testCollection.remove({})
```

仅删除一条记录
```bash
> db.testUser.find()
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce82"), "testField" : 5 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce83"), "testField" : 6 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce84"), "testField" : 7 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce85"), "testField" : 8 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce86"), "testField" : 9 }
> db.testUser.remove({testField: {$gt: 7}})
WriteResult({ "nRemoved" : 2 })
> db.testUser.find()
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce82"), "testField" : 5 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce83"), "testField" : 6 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce84"), "testField" : 7 }
> db.testUser.remove({testField: {$gt: 5}}, {justOne: 1})
WriteResult({ "nRemoved" : 1 })
> db.testUser.find()
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce82"), "testField" : 5 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce84"), "testField" : 7 }
```

### limit

### skip

### sort
```bash
> db.testUser.find()
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce7d"), "testField" : 0 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce7e"), "testField" : 1 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce7f"), "testField" : 2 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce80"), "testField" : 3 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce81"), "testField" : 4 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce82"), "testField" : 5 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce84"), "testField" : 7 }
> db.testUser.find().limit(5).skip(2).sort({testField: -1})
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce81"), "testField" : 4 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce80"), "testField" : 3 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce7f"), "testField" : 2 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce7e"), "testField" : 1 }
{ "_id" : ObjectId("5a7e6c5562e8c226bbf9ce7d"), "testField" : 0 }
>
```

## 索引
### 创建
- [createIndex](http://www.mongoing.com/docs/reference/method/db.collection.createIndex.html#db.collection.createIndex)
建立唯一索引
```bash
> db.user2.createIndex({random: 1}, {unique: true})
{
	"ok" : 0,
	"errmsg" : "Index with name: random_1 already exists with different options",
	"code" : 85,
	"codeName" : "IndexOptionsConflict"
}
```

## 聚合查询
![](http://img.blog.csdn.net/20160609100534149?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)  

SQL: `select by_user as _id, count(*) as num_tutorial from mycol group by by_user` 转换为 `Mongo Shell`
```bash
> db.mycol.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : 1}}}])
```







