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
db.user.insert({userId: '0000001', name: 'sven', age: 99, email: 'tester@test.com'})
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
