# 基础
    -- 目录结构
        5.0的部署建议是public目录作为web目录访问内容,其它都是web目录之外
    -- 开发规范
        -- 目录和文件
            除了类文件以外所有的文件和目录采用小写+下划线命名
        -- 函数/类/属性命名
            函数          小写字母+下划线
            方法/属性     驼峰法


# 架构
    -- URL访问
        5.0取消了URL模式的概念，并且普通模式的URL访问不再支持
        -- URL大小写
            URL不区分大小写
            URL里面的模块/控制器/操作名会自动转换为小写
            控制器在最后调用的时候会转换为驼峰法处理
            -- 如果要访问驼峰法的控制器类,则需要使用这种格式,模块名和操作名会直接转换为小写处理
                http://localhost/index.php/Index/blog_test/read     -- BlogTest
            -- 严格区分大小写[关闭URL中控制器和操作名的自动转换]
                'url_convert'    =>  false,                         -- 这种情况下使用blog_test方式依然有效
    -- 模块设计
        -- 目录结构
            模块目录全部采用小写和下划线命名[ThinkPHP5 命名规范]
        -- 模块和控制器隐藏
            define('BIND_MODULE','index');
            define('BIND_MODULE','index/index');                    -- 绑定到index模块的Index控制器
    -- 命名空间
        -- 如果调用PHP内置的类库/第三方没有使用命名空间的类库,必须在实例化类库的时候加上 \
            $class = new \stdClass();
            $xml   = new \SimpleXMLElement($xmlStr);
        -- 5.0默认的目录规范是小写,类文件命名是驼峰法,并且首字母大写
        -- 自动注册根命名空间(类库包)
            把类库包目录放入EXTEND_PATH目录(extend目录)就可以自动注册对应的命名空间
        -- 手动注册根命名空间内
            # 入口文件
                \think\Loader::addNamespace([
                    'my'  => '../application/extend/my/',
                    'org' => '../application/extend/org/',
                ]);
            # 或者应用的修改配置文件
                'root_namespace' => [
                    'my'  => '../application/extend/my/',
                    'org' => '../application/extend/org/',
                ]
    -- API友好
        -- 数据输出
            return xml($data);
            return json($data);

# 路由
    -- 路由模式
        -- 普通模式
            'url_route_on'  =>  false,                  -- 关闭路由,完全使用PATH_INFO 模式
        -- 混合模式
            'url_route_on'  =>  true,
            'url_route_must'=>  false,                  -- 可以通过PATH_INFO 和已经定义的路由规则来访问
        -- 强制模式
            'url_route_on'  =>  true,
            'url_route_must'=>  true,                   -- 必须定义路由规则才能访问
    -- 注册路由规则
        -- 动态注册
            use think\Route;
            Route::rule('new/:id','index/News/read');
        -- 配置文件注册
            # rote.php
                return [
                    'test/[:id]' => ['index/Index/test', ['method'=>'get'], ['id'=>'\d+']],
                ];
    -- MISS 路由
        -- 全局MISS 路由
            # 在没有匹配到所有的路由规则时可以使用MISS路由功能
                return [
                    '__miss__' => 'index/Index/test',
                ];
    -- 闭包支持
        retrun ['test/:id'=>function($id){echo $id;}];

# 控制器
    -- 控制器定义
        -- 5.0中控制器可以不继承任何基础类,也可以继承 \think\Controller
            # 控制器中渲染模版
                use \think\View;
                ...
                // 没有继承Controller类
                $view = new View();
                return $view->fetch('index');
                // 继承Controller类后,可以直接调用think\View think\Request类的方法
                $this->assign('domain', $this->request->url(true));
                return $this->fetch('index');
            -- 渲染输出
                一般情况下控制器中的输出使用 return 方式
    -- 控制器初始化
        -- init初始化方法,在调用该控制器的方法之前执行
            public function _initialize(){}             // 必须继承Controller 类
    -- 前置操作
        -- 设置 $beforeActionList 属性实现前置操作
            protected $beforeActionList = [
                'first',                                // 在所有操作之前执行
                'second' => ['except'=>'hello'],        // 除了hello操作
                'third' => ['only'=>'hello,hi'],        // 只在hello/hi操作之前执行
            ];
    -- 跳转和重定向
        $this->redirect('go', ['param'=>'1']);
    -- 多级控制器
        /application/index/controller/one/Go.php
        # 访问
            http://tp5.com/index/one.Go/go
        # 路由定义
            \think\Route::get('go', 'index/one.Go/go');
    -- 分层控制器
        /application/index/event/Go.php
        # 分层控制器不能被URL访问到,只能在控制器/模型类/视图文件中调用
        -- 实例化分层控制器
            \think\Loader::controller('Go', 'event');
            \think\Loader::controller('Admin/Go', 'event');     // 跨模块调用
        -- Widget
            # 利用分层控制器机制,可以实现widget(在模版中调用分层控制器)
            -- 在模版文件中调用分层控制器
                {:action('Go/hello', '', 'widget')}
                {:action('Go/hi', ['name' => 'think'], 'widget')}
            -- widget助手函数
                {:widget('Go/hello')}
                {:widget('Go/hi', ['name' => 'think'])}
    -- 自动定位控制器
        # 实际上是简化多级控制器的URL
            'controller_auto_search' => true,
        # 访问
            http://tp5.com/index/one/Go/go
    -- 资源控制器

# 请求
    -- 请求信息
        $request->domain();                 // 包含协议的域名
        $request->baseFIle();               // 入口文件
        $request->url(true);                // 包含协议/域名/query string的完整URL地址
        $request->baseUrl();                // 同上,不含 query string
        $request->path();                   // PATH_INFO 信息

        $request->module();                 // 模块/控制器/操作名称
        $request->controller();             
        $request->action();                 

        $request->method();                 // 请求方法 GET/POST
        $request->isAjax();                 // 是否是ajax请求

        $request->route();                  // 路由信息
    -- 输入变量
        -- 检测变量是否设置
            $request->has('id','GET');
        -- 变量获取
            -- param
                $request->param();              // 获取(经过过滤的)当前请求类型的参数/PATH_INFO参数/GET参数
                $request->param(false);         // 原始数据(未经过滤的)
                $request->param(true);          // 包含上传文件
                $request->param('name');        // name 变量
            -- get/post/put/request
                $request->get(false);           // 获取(未经过滤的)GET数据
            -- cookie/session
                $request->cookie('name');
                $request->session('name');
        -- 变量过滤
            # 配置文件
            'default_filter'         => 'htmlspecialchars',

            $request->filter('strip_tags');
            $request->filter(['strip_tags','htmlspecialchars']);
            $request->post('username', 'strip_tags,htmlspecialchars');
            $request->post('username', 'app\index\widget\StringFilter::safeHTML');
        -- 获取部分变量
            $request->only(['username','password'], 'get');
        -- 排除部分变量
            $request->except(['username','password'], 'get');
    -- 更改变量
        $request->get(['username'=>'Sc']);                  // 不能使用param()更改
    -- 请求类型
        # 获取请求类型
            $request->isPost();
            $request->isAjax();
            $request->isMobile();                   // 判断是否为手机请求
    -- 伪静态
        # 伪静态通常是为了满足更好的SEO优化
        'url_html_suffix' => 'html|shtml|xml',      // 设置伪静态后缀
        'url_html_suffix' => false,                 // 不使用伪静态
    -- 参数绑定
        -- 按顺序绑定
            'url_param_type'         => 1,          // 可以省略 tp5.com/test/username/Sc/age/21 中的username/age
    -- 依赖注入
        
    -- 请求缓存
        \think\Route::get('test', 'index/Index/test', ['cache'=>60]);

# 数据库
    -- 基本使用
        Db::query('SELECT * FROM tp5_user WHERE name=?', ['Sc']);               // 查询(参数绑定)
        Db::query('SELECT * FROM tp5_user WHERE name=:name', ['name'=>'Sc']);   // 占位符绑定
        Db::execute('SELECT 1+1;');          // 写入
    -- 查询构造器
        -- 基本查询
            # find()/select()
                // table(全名)/name(不带表前缀的表名)
                Db::table('tp_user')->where(['email'=>'test@test.com'])->find();        // 如果结果不存在返回null
                Db::table('tp_user')->where(['email'=>'test@test.com'])->select();      // 结果不存在返回空数组
            # column()
                Db::table('tp_user')->where([])->value('username');             // 查询一条数据(指定一个字段)
                Db::table('tp_user')->where([])->column('username');            // 查询所有(指定字段)
        -- CURD 操作
            -- insert
                # insert() 添加一条数据
                    Db::table('tp_user')->insert(['username'=>'Sc','age'=>21]);             // 返回1(受影响条数)
                    // 获取新增数据的主键值
                    Db::table('tp_user')->getLastInsID();
                # insertAll() 添加多条数据
                    Db::table('tp_user')->insertAll($data);                                 // 返回受影响条数
            -- update
                # update()
                    Db::table('tp_user')->where(['id'=>1])->update(['username'=>'Sc']);     // 返回受影响条数
                    -- 使用SQL函数或其他字段
                        Db::table('tp_user')->update([
                            'create_time' => ['exp','now()'],
                            'login_time'  => ['exp','create_time+1'],
                        ]);
            -- delete
                # delete()
                    Db::table('tp_user')->delete([1,3,5]);
                    Db::table('tp_user')->where(['username'=>'Sc'])->delete();
        -- 条件查询
            # where() AND条件查询
                Db::table('tp_user')->where('id', 1)->where('username', 'Sc');
            # whereOr() OR条件查询
                Db::table('tp_user')->where('id', 1)->whereOr('age', 21);
            # 混合查询
                // SELECT * FROM tp_user WHERE (id=1 OR id=2) OR (name LIKE 'think' OR name LIKE 'thinkphp')
                $result = Db::table('tp_user')->where(function ($query) {
                    $query->where('id', 1)->whereor('id', 2);
                })->whereOr(function ($query) {
                    $query->where('name', 'like', 'think')->whereOr('name', 'like', 'thinkphp');
                })->select();
        -- 获取表结构信息
            Db::getTableInfo('tp_user');


