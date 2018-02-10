# MongoDB Notes

## links
- marks
    - [中文文档](http://www.mongoing.com/docs)
    - [NodeJS Driver](http://mongodb.github.io/node-mongodb-native/2.2/)
    - [mongoose](https://github.com/Automattic/mongoose)
- posts
    - [mongo学习笔记0](https://github.com/qianjiahao/MongoDB)
    - [mongo学习笔记1](https://segmentfault.com/a/1190000011063248)
    - [mongo学习笔记2](http://blog.csdn.net/xqzhang8/article/details/72588278)

## 启动
```bash
mongod -f /usr/local/etc/mongod.conf
```

## 与 SQL 中的概念对比
> MongoDB 不支持表连接, 将 `_id` 作为主键

SQL | MongoDB 
-- | -- 
database | database 
table | collection 
row | document
column | field
index | index
table joins | 无
primary key | primary key

## [mongo shell](https://github.com/SublimeCT/note/blob/master/MongoDB/docs/base-command.md)

## 数据库

## 文档
文档的存储格式是 `BSON`, 是一种类似 `JSON` 的二进制形式的存储格式, 简称 `Binary JSON`


