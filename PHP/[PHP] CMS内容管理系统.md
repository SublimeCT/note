第二十五章 CMS内容管理系统
<?php 
    1.[简介、安装、创建(1)]
    2.[首页框架布局]
    
        在IE6/7中a>img会有边框,要将边框设为none,img设置为block

    3.[头部导航设计]
    4.[会员信息设计]
    5.[左侧新闻设计]
    6.[新闻列表设计]
    7.[图文、页脚设计]
    8.[分离头尾]

        /*
         *  在index.tpl文件里引入header.tpl / footer.tpl 没有意义
         *  因为解析后只是include,并没有解析引入的tpl文件
         *  应该将header.tpl / footer.tpl解析后引入
         *  引入Paser.class.php 时可能出现解析多个页面的情况,所以只让解析类被声明一次
         *  修改_display() 的参数控制是否生成缓存文件,实现是生成index.tpl.html
         */
        
    9.[创建后台]
    10.[创建后台框架]
        /*
         *  框架引入不是include,每个页面都是独立的,所以注入变量必须在本页进行
         *  HTML5 中不支持<frameset> / <frame>
         *  <iframe>    属性：frameborder / scrolling[yes/no/auto] / width / height
         *  在所有的<iframe>文件中引入admin.css文件
         *  设置浮动 / 取消边框解决间距问题
         *  
         */

         background-repeat: no-repeat / repeat-x / repeat-y         //在x轴或y轴上平铺
         
    11[三层架构]

        表现层/业务逻辑层/数据访问层


         界面部分                                     数据层模型                                       数据库
        Manage.php ——————————————→ Manage.class.php ←—————————————→ Model.class.php ←—————————————— DB.class.php
            |                            ↑
            |                            |
            |                            |
            |                            |
            ↓→↑←↘↗↖↙                 ↓              业务流程控制器
        Manage.tpl              ManageAction.class.php ←—————————————→ Action.class.php

    12[获取管理员数据]

        按引用传递:
            /**
             *  php中的函数中的参数都是按值传递的
             *  按引用传递需要在参数前加&
             *  
             *  在$mysqli = null; 时,$mysqli如果不是对象会报错,应先判断是否是对象
             *  
             *  
             */

    13[创建管理员实体类]

        创建model文件夹,用于存放所有实体类,实体类是所有模块的数据层操作

    14[新增管理员和工具类]

        返回受影响的行数
            mysqli->affected_rows

    15[自动加载类及瘦身]

        前台部分:
            将解析类中的引入文件功能修改为内部载入:
                source:
                    $this->_tpl = preg_replace($_pattern,'<?php require_once("\1"); ?>',$this->_tpl);

                update:
                    ...
                    $this->_tpl = preg_replace($_pattern,'<?php $this->_display("\1"); ?>',$this->_tpl);

                // 修改后只能引入tpl文件

        后台部分: 

            将admin-left的静态部分转换为html文件

    16[后台登录页面设计]

        验证码异步加载: 直接修改元素代码

            // 实现点击图片加载验证码
            $('img.validateCodeIamge').click(function(e) {
                $(this).attr('src','../config/validateCode.php?'+Math.random());
            });

    17[等级与管理员细节处理]

        获取客户端ip 
            $_SERVER['REMOTE_ADDR']


    18[网站导航二级子类]

        mysqli对象属性:
            $field_count        获取列的数量
            $num_rows           获取行的数量

    19[创建上传文件类]

        [设置文件大小限制]
            upload_max_filesize = 8M;   // 上传文件的最大值,应小于post_max_size
            post_max_size = 10M;        // post提交时表单所有数据的最大值
            memory_limit = 20M;         // 最大的存储限制

            设置后重启apache

        [弹出新窗口]
            window.open('../templates/upfile.html','newwindow','height=100,width=400,top='+height+',left='+width+',toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no');

        [设置允许的文件类型]
            ['image/jpeg','image/pjpeg','image/png','image/x-png','image/gif']              // png jpg gif

        [检测接收文件的路径是否可用]
            is_dir();               // 如果文件名存在,并且是目录就返回true,否则返回false

        [脚本中设置时区]
            date_default_timezone_set('Asia/Shanghai');

    20[获取网站根目录]

        // 网站根目录
        $_SERVER['DOCUMENT_ROOT']           D:/wamp/www/

        // 获取前后台通用的路径
        $_SERVER['SCRIPT_NAME']             /CMS/includes/uploadFile.class.php


    21[创建文件上传类]

        [后端向前端页面传值]
        echo '<script type="text/javascript">opener.document.getElementById("uploadPic").src="'.$path.'";</script>';

        [配置ckeditor]

            // 部署ckeditor
            <script type="text/javascript">$.getScript('../ckeditor/ckeditor.js');</script>
            <textarea rows="30" cols="50" name="content"></textarea>

            // 配置ckeditor,在此配置优先级高
            <script type="text/javascript">
                CKEDITOR.replace('content',{
                    uiColor : '#FFF',
                    language : 'zh-cn',
                    filebrowserImageUploadUrl : '../confog/ckeditorUpload.php?type=img',
                    image_previewText : ' ',
                });
            </script>

    22[创建图像处理类]

        [缩略图]
        imagecopyresampled($img1,$img2,0,0,0,0,100,100,200,200);        
            //把$img2拷贝到$img1上,将原大小200*200的图像调整到100*100

    23[创建文档表及发布文档]

        input[type=select],input[type=checked],input[type=radio]是在form中使用jQuery serialize/serializeArray不能被选的元素
        
        [jQuery选择器选择单选框和复选框]
            $('form input:checked');        // 选择单选框和复选框
            $('form input:selected');       // 选择下拉菜单内容

    24[前后端验证文档发布]

        获取CKEDITOR 中的内容(html代码)
            CKEDITOR.instance.content[<textarea> 的name值].getData();

    25[注册及验证会员]

        在创建数据表的时候,密码字段如果要使用md5加密,字段显示长度应该>=32字符,否则密码字段值会不完整








