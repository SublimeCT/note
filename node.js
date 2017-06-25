1 各版本差别 [http://cnodejs.org/topic/5762549a50312f1107e615d7]
    0.x         完全不支持 ES6 [由Joyent公司维护]
    4.x         部分支持ES6特性 [由 nodejs 基金会维护]
    6.x         支持 98% 的 ES6 特性

2 配置 Sublime 开发环境 
    [https://my.oschina.net/ximidao/blog/413101]
    [http://www.jianshu.com/p/3cb5c6f2421c]
    1 安装 Nodejs 插件
    2 配置插件
    3 添加新编译环境

3 cnpm [https://npm.taobao.org/]
    1 使用 npm 淘宝镜像
    2 安装模块
        cnpm install -g xxx
        1 全局安装
            安装在 \AppData\Roaming\npm\node_modules 目录下
        2 本地安装
            安装在当前路径

4 使用 nodemon 自动重启 node
    nodemon xxx.js

5 模块与包管理工具
    Commonjs 规范

6 模块
    1 创建模块
        mkdir school
        // student.js | teacher.js
        function add(student){
            console.log('Add Student: '+student);
        }
        exports.add = add;
        // klass.js
        var student = require('./student.js');
        var teacher = require('./teacher.js');
        var add = function add(teacher, students) {
            teacher.add(teacher);
            students.forEach(function(item, index){
                student.add(item);
            });
        }
        // index.js
        var klass = require('./klass');
        klass.add('Teacher', ['student1', 'student2']);

7 API
    














    