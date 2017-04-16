# 数据库基础
    -- 数据库分类
        数据库基于存储介质的不同,分为关系型数据库(SQL)/非关系型数据库(NoSQL: Not Only SQL)
    -- 数据库阵营
        关系型数据库:
            大型:
                Oracle/DB2
            中型:
                SQL-SERVER/MySQL
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
    # 匹配规则中 _ 代表单个字符, % 代表任意数量字符, 使用反斜线转义
    # \g 表示 ;
    ````````````````````````````````````````````````````````````````````````````````````````````````````
    -- 数据库操作
        -- 新增
            create database `database` charset utf8;                  -- 如果不指定字符集会默认使用utf8
            set names gbk;create database 中国 charset utf8;          -- 新建中文数据库
        -- 查询
            show databases;
            show databases like 'abc\_%'
            show create database `database` charset utf8;             -- 查看数据库属性
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
            show create table `think`\g                               -- 表属性信息
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
    -- 数据操作
        -- 新增
            insert into think_user(username, password) values('Sc', '123456'),('Cs', '123456');
        -- 查询
            select * from think_user;
        -- 更新
            update think_user set username='ss';
        -- 删除
            delete from think_user where user_id=123;

# 中文数据问题
    -- 查看所有字符集
        show character set;
    -- 查看服务器对外处理的字符集
        show variables like 'character_set%';
    -- 修改服务器端认为客户端数据的字符集
        set character_set_client = gbk;
    -- 修改服务器端返回数据的字符集为gbk
        set character_set_result = gbk;
    -- 直接修改
        set names gbk;          -- 修改了character_set_client/character_set_result/character_set_connection

# 校对集
    数据的比较方式
    只有数据比较的时候校对集才生效
    校对集只能在没有存入数据之前修改好, 否则无效
    -- 格式
        _bin        二进制比较, 取出二进制位,区分大小写
        _cs         大小写敏感, 区分大小写
        _ci         大小写不敏感, 不区分大小写

# 数据类型
    -- 整数类型
        TINYINT/SMALLINT/MEDIUMINT/INT/BIGINT(8字节)
        -- 对应列属性
            UNSIGNED/INT(3)[显示长度, 长度不够时补全]/ZEROFILL[填充0]
    -- 小数类型
        -- 浮点型
            精度有限, 整数部分不能超出长度,小数部分超出长度会四舍五入
            float(最大精度7位左右)
            double(最大精度15位左右)
            ``````````````````````````````````````````````````
            float(10,2)         总长度10, 小数部分长度2             
        -- 定点型
            精度固定, 整数部分不能超出长度,小数部分超出长度会报错
            decimal(M,D)
            M最大65, D最大30
            ``````````````````````````````````````````````````
            decimal(10,2)       总长度10, 小数部分长度2   
    -- 时间/日期类型
        datatime                YYYY-mm-dd HH:ii:ss             1000-9000 年
        date                    YYYY-mm-dd
        time                    HH:ii:ss                        时间段, -时间到+时间
        timestamp               YYYY-mm-dd HH:ii:ss             从1970-01-01 开始的时间, 当记录被修改时自动更新为当前时间
        year                    YYYY                            1901 到 2155
    -- 字符串类型
        char(定长字符串)/varchar/text/blob/enum/set
        -- 定长字符串
            char(n)
                最大长度 255
                在定义结构时就确定了长度, 用空格填充
                char(3)在utf8下中文实际存储 3*3 个字符
        -- 变长字符串
            varchar(n)
                最大长度 65536
                在存储时会多出 1 到 2 个字节确定长度
                如果长度超过 255 , 使用text类型存储
                varchar(3)在utf8下中文实际存储 3*3+1 个字符
        -- 文本字符串
            text                存储文字
            blob                存储二进制数据
                长度超过 255 就会自动使用文本字符串存储
        -- 枚举字符串
            enum('男','女','保密')
                最大长度 65535
                插入数据时可以使用整数表示数据
                实际用整数(1[,2,3,...])存储
        -- 集合字符串
            set('篮球', '足球', '排球', '网球')
                集合中每个元素对应一个二进制位,选中为 1 ,不选择为 0
                    选择 排球/网球 或 12, 对应存储为二进制数 1100
    -- 记录的实际存储长度
        utf8    21844 字节            (65534-2)/3
        gbk     32766 字节            (65534-2)/2
            其中文本字符串类型的字段额外存储, 但需要占用 10 个字节存储数据地址和长度
            允许为空的字段需要额外占用 1 个字节
# 列属性
    -- 空属性
        null/not null
    -- 列描述
        comment '描述'
    -- 默认值
        default '默认值'
    -- 主键
        primary key
        -- 复合主键
            create table test(
                id int(7),
                name varchar(10),
                age int(3),
                primary key(id,name)
            )charset utf8;
        -- 为已创建表增加主键
            alter table test modify id int(7) primary key;
            alter table test add primary key (id);
        -- 主键约束
            主键值不允许重复
        -- 更新/删除主键
            只能先删除再更新主键
            alter table tset drop primary key;
        -- 主键分类
            1. 业务主键
                使用真实业务(学号/课程号)数据作为主键
            2. 逻辑主键
    -- 自增长
        auto_increment
            -- 前提
                1. 自动增长字段必须是索引(key)
                2. 必须是整型数据
                3. 一张表只能有一个自动增长字段
            -- 触发
                insert into test values ('Sc');
                insert into test values (default, 'Sc');
                insert into test values (null, 'Sc');
            -- 修改
                -- 修改自增长字段
                    必须先删除后增加
                -- 修改自增长值
                    alter table test auto_increment = 4;
                -- 查看系统对应的自增长变量
                    show variables like 'auto_increment%';
            -- 删除
                alter table tset modify id int(7);                      -- 字段是主键时不能加 primary key 属性 
    -- 唯一
        unique key
            -- 属性
                唯一字段允许(多条)为空, 且为空时不参与唯一性比较
                唯一字段允许允许有多个
            -- 设置
                aaa int(7) not null unique;
                aaa int(7) not null unique key;
                create table test(
                    id int(7) primary key,
                    aaa int(7) not null,
                    unique key(aaa)
                )charset utf8;
                alter table test add unique key (aaa);
            -- 更新
                可以直接设置唯一索引
                    alter table test add unique key(aaa);
                    # 查看表结构时如果没有设置主键, 且唯一索引字段设置为 not null, 唯一索引字段就会显示 primary key
            -- 删除
                alter table test drop index `aaa`               -- aaa 是索引名, 可通过show create table 查看

# 索引
    根据某种算法将所有数据单独建立一个文件, 可以实现快速匹配数据
    增加索引会产生索引文件, 占用大量磁盘空间
    -- 意义
        1. 提高查询效率
        2. 约束数据属性(如唯一性)
    -- 使用
        1. 作为查询条件的字段, 需要经常使用, 可以定义索引(提高查询效率)
        2. 需要进行有效性约束, 可以定义索引
    -- 分类
        primary key
        unique key
        fulltext index              全文索引
        index                       普通索引

# 关系
    -- 分类
        一对一
        一对多
        多对多

# 范式
    Nomal Format, 满足特定要求的关系规范
    关系模式分为 6 层, 1NF 要求最低,每一层都比上一层更加严格, 若要满足下一层范式, 必须先满足上层范式
    凡是能够通过关系寻找出来的数据, 坚决不再重复存储
    终极目标是为了减少数据冗余
    一般情况下, 只需满足前三种范式
    -- 1NF
        所有字段数据具有原子性, 不可再分
        如果表中某个字段在取出来使用之前还需要额外处理(拆分), 那么就不符合第一范式
        -- 解决方案
            根据具体需求拆分字段
    -- 2NF
        表中字段必须完全依赖全部主键, 不允许出现部分依赖
        如果存在复合主键, 且有字段只依赖与其中部分主键, 不符合第二范式
        -- 解决方案
            1. 每个主键单独成表
            2. 取消复合主键, 使用逻辑主键(增加id 逻辑主键)
    -- 3NF
        表中所有字段都直接依赖所有主键, 不允许出现传递依赖
        如果存在字段依赖某个字段, 这个依赖的字段依赖于主键, 称为传递依赖, 不符合第三范式
        -- 解决方案
            将存在传递依赖的字段取出, 并单独建表, 原表中所依赖的字段值改为新建表的主键值
    -- 逆规范化
        如果某个字段需要从其他表中获取信息, 可以直接将对应主键改为需要的数据信息
        可以避免多表查询, 但会导致数据冗余

# 高级数据操作
    -- 新增数据
        -- 主键冲突
            插入数据时如果主键字段值重复, 会导致主键冲突
            -- 解决方案
                1. 更新主键字段值
                    只更新不插入
                    insert into test values(1, 'sc') on duplicate key update id = 666;
                2. 替换对应记录
                    replace insert into test values(1, 'sc');
        -- 复制表结构/数据
            create table test1 like test;                          -- 创建表时复制数据
            -- 意义
                备份数据表
        -- 蠕虫复制
            insert into test1 select * from test;                  -- 从其他表复制数据
            insert into test1 select * from test1;                 -- 从本表复制数据
            -- 意义
                1. 从原有表中复制数据
                2. 迅速增加记录数量, 测试表的压力以及效率
    -- 更新数据
        -- 限制更新记录
            update test set age = 22 [where id>10 limit 3];
    -- 删除数据
        delete from test where age=22 limit 3;
        truncate test;                                             -- 清空所有数据, 包括auto_increment 属性值
    -- 查询数据
        -- 完整语法
            select [select选项] */字段列表(字段别名) from 数据源 [where 条件子句] [group by 条件子句] [having 子句] 
            [order by 子句] [limit 子句];
        -- select 选项
            all                     默认, 保留所有结果
            distinct                当所有字段值都重复时去除
        -- 字段别名
            select id as 编号 from test;
        -- 数据源
            -- 单表数据源
                select * from test;
            -- 多表数据源
                select * from test,test1;                                   -- 笛卡尔积(交叉连接)
            -- 子查询
                select * from (select * from test1 where id>10) as a;       -- 必须指定别名
        -- where 子句
            -- 判断条件
                -- 比较运算符
                    > < >= <= <> != = like between and in/not in
                -- 逻辑运算符
                    and or not
        -- group by 子句
            -- 意义
                分组是为了统计数据
            -- 统计函数
                count()/max()/min()/avg()/sum()
            -- 排序
                select max(age) from test group by age desc;        -- 降序
            -- 多字段分组
                select class_id,sex,count(*) from test group by class_id,sex;
            -- 对分组中的某个字段对应的所有值进行字符串连接
                # 对应结果  张三,李四,王五
                select class_id,sex,count(*),group_concat(name) from test group by class_id,sex;
        -- having 子句
            -- having 和 where 的区别
                1. 过滤方式
                    where                       逐条从磁盘读取, 判断符合条件后写入内存, 不符合条件忽略
                    having                      先将数据读入内存, 再过滤
                2. 使用别名
                    where                       不能使用别名
                    having                      可以
                3. 统计函数
                    where                       不能使用
                    having                      可以使用
        -- order by 子句
            根据某个字段进行排序, 依赖校对集
            支持多字段排序
        -- limit 子句
            limit length/limit index,count























    
