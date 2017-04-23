# 连接查询
    -- 交叉连接
        查询结果为笛卡尔积连接结果
            select A.naem,b.address from test A,test1 B;
            select A.naem,b.address from test A cross join test1 B;
    -- 内连接
        从左表中取出每条记录, 与右表中每条记录匹配, 条件是某个字段值相等
            select A.id,B.address from test A inner join test1 B on A.id = B.id;
    -- 外连接
        从某张表取出所有数据, 与另一张表中每条记录匹配, 不管指定字段是否匹配, 如果不匹配就置空另一张表的数据
        -- 左外连接
            select A.id,B.address from test A left join test1 B on A.id = B.id;
        -- 右外连接
            select A.id,B.address from test A right join test1 B on A.id = B.id;
    -- 自然连接
        从某张表取出所有数据, 与另一张表中每条记录匹配, 条件是所有同名字段相等
            select A.id,B.address from test A natural [left/right] join test1 B;

# 外键
    -- 前提
        MyISAM 不支持外键约束, 需要切换到 InnoDB 引擎
        alter table test engine=InnoDB;
    -- 创建
        -- 新建表时创建
            create table test(
                id int(7) not null auto_increment,
                name varchar(7) not null,
                class_id int comment '班级 ID',
                primary key(id),
                foreign key(id) references class(id)                -- 外键要求本身是一个索引, 如果没有就会创建索引
            )charset utf8;
        -- 创建表后新增外键
            第一个 class_id 是外键名称
            第二个 class_id 是外键字段
            class(id) 是外键引用
            alter table test add constraint class_id foreign key(class_id) references class(id);
    -- 更新/删除
        外键可以有多个, 更新时必须先删除后新增
        删除后还是会保留外键字段的索引
        alter table test drop foreign key class_id;             -- class_id 是外键名称
    -- 约束
        -- district 严格模式(默认)
            1. 对于子表, 如果新增或者修改的记录中外键字段值在父表中没有匹配到, 就会操作失败
            2. 对于父表, 如果某条记录对应的外键字段值已经被子表引用, 那么对于外键字段的删除和更新操作都会失败
        -- cascade 级联模式
            父表更新/删除, 子表也更新/删除
        -- set null 置空模式
            父表更新/删除, 子表对应外键字段值置空, 此时外键字段必须允许为空
        -- 合理做法
            删除时置空, 更新时级联
            foreign key(class_id) references class(id) on delete set null update cascade;

# 联合查询
    将多次 select 结果拼接
    -- 前提
        字段名和字段数量一致, 数据类型可以不一致
        select * from test
        union [all]                                         -- 加 all 表示不去重
        select * from test1;
    -- 意义
        1. 查询针对同一张表, 但需求不同(如男生身高升序, 女生身高降序)
            (select * from test where sex='男' order by height limit 99999)
            union 
            (select * from test where sex='男' order by height limit 99999)
        2. 多张表的结构完全一致(如腾讯qq号码分表查询)

# 子查询
    -- 标量子查询
        子查询结果为 1 行 1 列
            # 查询某班所有学生的信息
                select * from student where class_id = (select id from class where id=101);
    -- 列子查询
        查询结果为多行, 每行一列
            # 查询所有在读班级的学生
                select * from student where calss_id in(select id from class where is_new=1);
    -- 行子查询
        查询结果是 1 行, 有多列
            # 查询年龄最大且身高最高的学生
                select * from student where (age,height) = (select max(age),max(height) from student);
    -- 表子查询
        查询结果是多行多列的二维表
            # 查询每个班最高的学生
                select class_id,username from 
                (select class_id,username from student order by height) as student 
                group by class_id;
    -- exists 子查询
        查询结果是 0 和 1
            # 如果4班存在就查询4班的所有学生信息
                select * from student where exists(select * from class where id=4); 

# 视图
    -- 创建
        -- 单表视图
            create view test as select * from student;
        -- 单表视图
            create view test as select * from student STU inner join class CLA on STU.class_id = CLA.id;
    -- 查看
        查看视图的结构
        show tables/show create view xxx/desc xxx


























