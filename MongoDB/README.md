# MongoDB Notes

## links
- marks
    - [中文文档](http://www.mongoing.com/docs)
- posts
    - [json与bson的区别](http://blog.csdn.net/xiaojin21cen/article/details/60953980)
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

## [基本命令](https://github.com/SublimeCT/note/blob/master/MongoDB/docs/base-command.md)

