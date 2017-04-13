# 数据库基础
    -- 数据库分类
        数据库基于存储介质的不同,分为关系型数据库(SQL)/非关系型数据库(NoSQL: Not Only SQL)
    -- 数据库阵营
        关系型数据库:
            大型:
                Oracle/DB2
            中型:
                SQL-SERVER,MySQL
            小型:
                access
        非关系型数据库:
            mongodb/redis

# 关系型数据库
    建立在关系模型上的数据库
    -- 关系模型
        包含 数据结构(数据二维表)/操作指令集合(所有SQL语句)/完整性约束(表内数据约束/外键约束)

# SQL
    Structured Query Language 结构化查询语言
        -- DDL
            Data Definition Language 数据定义语言
                用来维护数据的结构(create/drop/alter)
        -- DML
            Data Manipulation Language 数据操作语言
                操作数据
        -- DCL
            Data Control Language 数据控制语言
                主要负责权限管理

# MySQL服务器对象
    内部分为四层: 系统(DBMS) >> 数据库(DB) >> 数据表(table) >> 字段(field)

# SQL基本操作
    # 如果SQL 中字段名/表名等包含SQL关键字,需要使用 ` 进行转义
    # 匹配规则中 _ 代表单个字符, % 代表多个字符, 使用反斜线转义
    # \g 表示 ;
    ````````````````````````````````````````````````````````````````````````````````````````````````````
    -- 数据库操作
        -- 新增
            create database `database` charset utf8;                  -- 如果不指定字符集会默认使用utf8
            show create database `database` charset utf8;             -- 创建并查看
            set names gbk;create database 中国 charset utf8;          -- 新建中文数据库
        -- 查询
            show databases;
            show databases like 'abc\_%'
        -- 修改
            alter database `think` charset gbk;                       -- 修改仅限于库选项, 不能修改数据库名
        -- 删除
            drop database `think`;                                    -- 对应 /data/think 目录被删除
    -- 表操作
        -- 新增
            # 创建后会在 /data/think 目录下生成对应表文件(跟存储引擎有关)
            create table if not exists `think`.`think`(               -- 数据库名.表名, 如果不加数据库名需要先 use think;
                username char(20),                                    -- 字段名 数据类型
                password char(20)
            )engine Innodb;                                           -- 表选项
        -- 查询
            show tables;
            show tables like 'think%';
            show create table `think`\g
            desc/describe/show columns from `think`                   -- 查看表结构
        -- 修改
            -- 修改表
                rename table think to my_think;                       -- 重命名
                alter table think charset utf8;
                alter table think engine Innodb;
            -- 修改字段
                -- 新增
                    alter table 表名 add [column] 字段名 数据类型 [列属性] [位置]            -- 位置: first/after 字段名
                    ````````````````````````````````````````````````````
                    alter table `think` add age int(3) not null after password;
                -- 修改
                    alter table `think` modify student_id char(20) first;
                -- 重命名
                    alter table 表名 change 旧字段名 新字段名 数据类型 [列属性] [位置] 
                    ````````````````````````````````````````````````````
                    alter table `think` change student_id sid char(30) after name;
                -- 删除
                    alter table `think` drop sex;






    






















