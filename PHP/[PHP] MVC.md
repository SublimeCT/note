<?php 
MVC

    [组成]

        Controller
            创建模型类和视图类，将模型取得的数据通过视图进行显示
        Model
            获取相应数据并进行处理，返回数据
        View
            将取得的数据进行组织、美化等，最终输出

    [实现步骤]

        用户向控制器发出指令
        控制器选取合适的模型
        模型按控制器指令取相应数据
        控制器选取合适的视图
        视图把数据进行显示

    [规范]

        入口文件[index.php]

            单一入口机制
                所有请求都指向同一脚本文件 
            入口文件规范
                1) 统一入口文件为首的URL格式
                    URl:index.php?controller=xxx&method=xxx
                2) 入口文件...
                    引入建议调用函数
                    定义允许的controller 和 method[controllerAllow/methodAllow]
                    获取controller 和 method
                    对controller 和 method 进行判断
                    调用controller
                    // 在controller 类内部调用 M() / V() 来实例化model和view类
                    // 在methodAllow 中加入show()

        目录规范

            MVC Project
                libs
                    Controller
                        testController.class.php
                    Model
                        testModel.class.php
                    View
                        testView.class.php
                    ORG
                        ...
                config.php
                index.php

        简易调用函数等

            控制器调用函数 C()
            模型调用函数 M()
            视图调用函数 V()
            转义函数 daddslashes()
                function daddslashes($str){
                    return get_magic_quotes_gpc() ? $str : addslashes($str);
                }
            
                1) 控制器的方法一般是不带参数的
                2) 使用字符串方式实例化类时应省略后面的(),否则将按照函数执行

    [视图引擎]

        Smarty 
            
















