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
            throw new \Exception("Error Processing Request", 1);
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

# 配置
    -- 读取配置
        \think\Config::get('sex');
        \think\Config::get('sex.0');
        \think\Config::get('sex.0')[1];
        config('sex.0');
    -- 动态设置配置(临时)
        \think\Config::set(['sex'=>['女'], ['男'], ['保密']]);

# 路由
    -- 路由模式
        -- 普通模式
            'url_route_on'  =>  false,                  // 关闭路由,完全使用PATH_INFO 模式
        -- 混合模式
            'url_route_on'  =>  true,
            'url_route_must'=>  false,                  // 可以通过PATH_INFO 和已经定义的路由规则来访问
        -- 强制模式
            'url_route_on'  =>  true,
            'url_route_must'=>  true,                   // 必须定义路由规则才能访问
    -- 注册路由规则
        -- 动态注册
            use think\Route;
            Route::rule('new/:id','index/News/read');
        -- 配置文件注册
            # rote.php
                return [
                    'test/[:id]' => ['index/Index/test', '*', ['id'=>'\d+']],           // * 表示所有请求
                    'aaa' => ['index/Index/aaa', ['method'=>'get']];
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
        -- 初始化方法,在调用该控制器的方法之前执行
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

        $request->path();                   // 获取PATH_INFO 信息,不含后缀

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
            # 指定过滤函数
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
                Db::table('tp_user')->select(3);                    // 按主键id查询
                Db::table('tp_user')->select(false);                // 直接返回SQL语句
            # column()
                Db::table('tp_user')->where([])->value('username');                 // 查询一条数据(指定一个字段)
                Db::table('tp_user')->where([])->column('username');                // 查询所有(指定字段)
            # field()
                Db::table('tp_user')->where([])->field(['id','username'])->select();        // 查询所有(指定字段)
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
            # 批量AND查询
                Db::table('tp_user')->where([
                    'id' => ['GT', 2],
                    'username' => ['LIKE', 'Sc%'],
                    ...
                ]);
        -- 获取表结构信息
            Db::getTableInfo('tp_user');
        -- 聚合查询
            # count()/max()/min()/svg()/sum()
                Db::table('tp_user')->count();
        -- 表达式查询
            Db::table('tp_user')->where('id', 'exp', 'IN (1,3,4)');
        -- 区间查询
            # 同一字段多个条件查询的简化写法
                // SELECT * id,column FROM tp_user WHERE 
                // (username LIKE 'Sc%' AND username <> 'Sc001') AND 
                // (id<10 OR id>5)
                Db::table('tp_user')
                    ->where('username', ['LIKE', 'Sc%'], ['NEQ', 'Sc001'])
                    ->where('id', ['LT', '10'], ['GT', '5'], 'OR')
                    ->field(['id', 'username'])
                    ->select();
        -- 子查询
            # fetchSql() 只构建SQL语句而不执行,可以支持所有的CURD查询
        -- 事务操作
            // 开启事务(数据库引擎必须是InnoDB)
            Db::startTrans();
            try{
                Db::table('tp_user')->delete(2);
            }catch(\Exception $e){
                Db::rollback();
            }

# 模型
    -- 定义
        # 具体的模型类要继承\think\Model 类
    -- 模型调用
        -- 静态调用
            $user = User::get($condition);
            $user->name = 'Sc';
            $user->save();
        -- 实例化调用
            $user = new User();
        -- Loader 类实例化(单例)
            Loader::model('User');
    -- 初始化
        # 通过重写 protected function initialize(){parent::initialize();}/pretected static init()实现初始化
        # init() 只在第一次实例化的时候执行
    -- CURD操作
        -- 新增
            # save() 新增数据,返回写入的记录数量
                $user->save(['username'=>'Sc', 'age'=>21]);
                $user->allowField(true)->save($data);                       // 过滤表中不存在的字段
                $user->allowField(['username', 'email'])->save($data);      // 过滤指定字段
            # saveAll() 写入多条,返回模型对象
                $user->saveAll($data);
            -- 静态方法
                # create() 新增一条数据,返回模型对象
                    User::create($data);
        -- 更新
            # save() 更新
                User::get(2)->save(['username'=>'蛤蟆']);             // 查询后更新
                $user->save(['username'=>'蛤蟆'], ['id'=>2]);         // 按条件更新
                $user->save(['id'=>1, 'username'=>'蛤蟆']);
            -- 静态方法
                # update() 更新一条数据
                    User::where($condition)->update($data);           // 数据库对象操作
        -- save() 多次新增
            # 调用save() 后再执行就会视为更新数据,需要显式地指定更新还是新增
                $user->save($data1);
                $user->isUpdate(false)->save($data2);       // 指明新增
        -- 删除
            # delete()
                $user->where($condition)->delete();
            -- 静态方法
                # destory()
                    User::destory($condition);
        -- 查询
            -- 静态方法
                # get() 查询一条
                    User::get($condition);
                # all() 查询多条
                    User::all($condition);
                    // 使用闭包方式可以支持连贯操作
                    User::all(function($query){
                        $query->where($condition)->order('id', 'DESC')->limit(10);
                    });
    -- 聚合

    -- 获取器
        # 获取字段值的时候对其进行处理后再输出
            public function getStatusAttr($value){
                $attributes = ['富强','民主','文明','和谐'];
                return $attributes[$value];
            }
            // 获取原始数据
            User::get(2)->getData('username');
    -- 修改器
        # 更新/新增前对其进行处理
            public function setStatusAttr($value){
                return strtolower($value);
            }
            // 必须使用具体的模型对象更新才有效
            (new User())->save($data, $condition);
    -- 只读字段
        # 使指定字段值不被修改
            protected $readOnly = ['create_time'];
    -- 自动完成
        # 设定修改器在更新还是新增时触发
            protected $auto = ['username','email'];             // 更新和新增时都触发修改器
            protected $insert = ['create_time'=>time()];
            protected $update = [];

# 视图
    -- 动态设置模版引擎参数
        $this->view = new View();             // 控制器未继承Controller 类时需要实例化View 类
        $this->view->config('view_path', APP_PATH.'templates/');
    -- 模版赋值
        # assign()
            $this->assign([
                'username' => $username,
                'password' => $password
            ]);
        -- 静态方法
            # share()
                \think\View::share('username','Sc');
    -- 模版渲染
        # fetch()
            $this->view->fetch('/index');           // 5.0.4+ 支持从根目录开始读取
        # dispaly() 直接解析内容,不通过模版文件
    -- 输出替换
        # config.php
            'view_replace_str' => [
                '__PUBLIC__'=>'/public/',
                '__ROOT__' => '/',
            ],
        # Index.php
            return $this->fetch('index', $vars, ['__PUBLIC__'=>'/public/', '__ROOT__' => '/',]);
            return (new View($vars, \think\Config::get('view_replace_str')))->fetch();

# 模版标签
    -- 模版标签
        -- 普通标签
            # 普通标签用于变量输出和模版注释
        -- 标签库标签
            # 用于变量输出/文件包含/条件控制/循环输出... 可以扩展功能
    -- 变量输出
        // 已在配置文件修改开始/结束标签
        <{$username}>
        <{$user['username']}>/<{$user.username}>
        <{$user->username}>/<{$user:username}>
    -- 系统变量
        # 支持$_SERVER/$_ENV/$_POST/$_GET/$_REQUEST/$_SESSION/$_COOKIE
        <{$Think.server.script_name}>               // $_SERVER['SCRIPT_NAME']
    -- 常量输出
        <{$Think.APP_PATH}>
    -- 配置输出
        <{$Think.config.default_module}>
    -- 语言变量
        <{$Think.lang.page_error}>
    -- 请求参数
        <{$Request.get.user.username}>              // 对应$request->get('user.username')/只支持传一个参数
    -- 函数
        <{$username|substr=0,21|strtolower}>
    -- 默认值
        <{$username|strtolower|default="暂无"}>
    -- 运算符
        <{$count++}>
    -- 注释
        <{// test}>
        <{/*test*/}>
    -- 模版布局
        -- 直接配置实现布局
            -- 开启模版布局
                'template'  =>  [
                    'layout_on'     =>  true,
                    'layout_name'   =>  'layout',               // 布局模版文件名(相对于模目录的路径)
                    'layout_item'   =>  '<{__REPLACE__}>'       // 替换字符串
                ]
            # 先渲染模版文件目录中的layout[.tpl]文件,将<{__CONTENT__}>替换为渲染的模版文件内容
                # layout.tpl
                    <{include file="layout/header"}>
                    <{__CONTENT__}>
                    <{include file="layout/footer"}>
        -- 模版标签实现布局
            <{layout name="layout"}>
    -- 包含文件
        <{include file="layout/header"}>
    -- 内置标签
        # foreach
            <{foreach name="userInfo" key="user_id" item="user"}>
            <{/foreach}>
        # if
            <{if strtolower($framework)==='thinkphp5'}>
            This is tp5
            <{else}>
            Other framework
            <{/if}>
        # php
            <{php}>
            PHP code ...
            <{/php}>

# 错误和调试
    -- 异常处理
        -- 设置错误报错级别
            # common.php(公共函数文件或配置文件)
                error_reporting(E_ERROR | E_PARSE);

# 验证
    -- 验证器
        # ThinkPHP5.0使用独立的\think\Validate 类或验证器进行验证
            -- 验证器
                1. 定义\app\index\validate\User 类并继承\think\Validate 类
                    pretected $rule = [
                        'name'  =>  'require|max:21',
                        'email' =>  'email'
                    ];
                2. 使用验证器进行验证
                    $data = [
                        'name'=>'Sc',
                        'email'=>'hellosc@qq.com'
                    ];
                    $validate = Loader::validate('User');
                    if(!$validate->check($data)){
                        dump($validate->getError());
                    }
    -- 验证规则
        -- 定义错误提示信息
            protected $message = [
                'name.require' => '名字不能为空'
            ];
        -- 自定义验证规则
            protected $rule = [
                'name' => 'checkName:ruleName'
            ];
            pretected function checkName($value, $rule[, $data, ...]){
                reutrn (strpos('系统', $value)===false ? true : '用户名中不能包含敏感字符');
            }
            # 验证类设置验证规则
                $validate = new \think\Validate(['name' => 'checkName:test']);
                // 添加规则
                $validate->rule('user_id', '/^\d{6}$/');
                // 添加场景
                $validate->scene('edit', ['name', 'email']);
                // 添加闭包验证函数
                $validate->scene('edit')->extend('checkName', function($value, $rule, $data){
                    # ...
                });
                // batch() 显示所有错误信息
                $isPass = $validate->batch()->check($this->request->post());
                if(!$isPass){
                    foreach($validate->getError() as $error){
                        echo $error;
                    }
                }
    -- 验证场景
        protected $scene = [
            'edit' => [
                'name', 
                'age'=>'require|number|between:1,120'           // 也可以重新设置规则
            ]
        ];

        Loader::validate('User')->scene('edit')->check($data);
    -- 控制器中验证
        // 如果控制器继承了\think\Controller 类
        $this->validate($data, 'User.edit');                    // edit是场景
    -- 使用模型验证
        $user = new User();
        // 自动使用当前模型类对应的验证器类进行验证,可以指定验证器类名称'User.edit'
        $result = $user->validate(true)->save($data);
        if(false === $result){
            dump($User->getError());
        }
    -- 内置规则
        require/number/email
        in:1,2,3/
        notIn:1,2,3/
        between:1,100/
        notBetween:1,100/
        length:1,21
        max:21
        ...

# 缓存
    -- 设置缓存
        Cache::set('name', $value, 3600);
    -- 获取缓存
        Cache::get('name', $value, 3600);
    -- 删除缓存
        Cache::rm('name', $value, 3600);

# 分页
    # controller file
        $users = Db::name('user')->where('is_delete', 0)->paginate(5);
        $this->assign('userInfo', $users);
        return $this->fetch('index');
    # template file
        <{// 分页div数据}>
        <{$this->render()}>

# 上传文件
    # template file
        <form action="/index/Index/upload" enctype="multipart/form-data" method="post">
            <input type="file" name="goods_thumb" /> <br> 
            <input type="submit" value="上传" /> 
        </form>
    # controller file
        public function upload(){
            $rule = ['size'=>204800, 'ext'=>'png,jpg'];
            $uploadsPath = ROOT_PATH.'public'.DS.'uploads/goods/goods_thumb';
            $fileName = $_SESSION['goods_id'].'.png';
            $goodsThumb = $this->request->file('goods_thumb');
            if(!$goodsThumb){
                $this->error('上传失败');
            }
            // 验证后移动
            $goodsThumbInfo = $goodsThumb->validate($rule)->move($uploadsPath, $fileName);
            if ($goodsThumbInfo) {
                dump($goodsThumbInfo);
            }else{
                dump($goodsThumb->getError());
            }
        }

# 验证码
    # 使用Composer 安装 think-captcha 扩展包
        D:\phpStudy\WWW\TP5>php composer.phar require topthink/think-captcha
        Using version ^1.0 for topthink/think-captcha
        ./composer.json has been updated
        Loading composer repositories with package information
        Updating dependencies (including require-dev)
        Nothing to install or update
        Writing lock file
        Generating autoload files
    # template file
        <div><img src="<{:captcha_src()}>" alt="captcha" /></div>
    # config file
        'captcha'  => [
                // 验证码字符集合
                'codeSet'  => '2345678abcdefhijkmnpqrstuvwxyzABCDEFGHJKLMNPQRTUVWXY', 
                // 验证码字体大小(px)
                'fontSize' => 20, 
                // 是否画混淆曲线
                'useCurve' => false, 
                // 验证码图片高度
                'imageH'   => 45,
                // 验证码图片宽度
                'imageW'   => 150, 
                // 验证码位数
                'length'   => 4, 
                // 验证成功后是否重置        
                'reset'    => true
        ],
    # controller file
        -- 直接使用Captcha 类进行验证
            if ($this->request->post('captcha_code')) {
                $captcha = new \think\captcha\Captcha();
                if ($captcha->check($this->request->post('captcha_code'))) {
                    echo '验证通过';
                }else{
                    echo '验证失败';
                }
            }
        -- 使用验证器
            if ($this->request->post('captcha_code')) {
                $validate = new Validate();
                $captcha = new Captcha();
                $validate->rule('captcha_code', function($value) use($captcha) {
                    return $captcha->check($value) ? true : '验证码错误';
                });
                if ($validate->check($this->request->post())) {
                    echo '验证通过';
                }else{
                    echo '验证失败';
                }
            }
# 图像处理

# 文件处理

# 扩展
    -- 类库
        ┏━━━━━━━━━━━━━━━━━━
        ┃使用Composer 安装依赖 
        ┗━━━━━━━━━━━━━━━━━━
            # [例]安装(yii)项目
                // 设置依赖, 也可通过composer.json 设置
                composer global require "fxp/composer-asset-plugin:^1.2.0"
                // 安装yii 库
                php composer.phar create-project --prefer-dist yiisoft/yii2-app-basic basic
                // create-project 强制使用压缩包
                // 安装过程中可能需要输入token, 访问Head to后面的URL, 设置token
            -- composer.json
                {
                    "require":{
                        // "包名称":"包版本"
                        // ~1.2.3 表示 >=1.2.3 且 <1.3
                        "monolog/monolog":"~1.2.3"
                    }
                }
            # 安装依赖包
                // 通过composer.json 或composer require 配置好依赖后执行命令安装依赖包
                php composer.phar install
                // 安装后可以将安装的依赖包在.gitigonre 中设置为不提交
                // 安装后将创建一个包含安装时的确切版本号的composer.lock 到根目录
                // 每次install 时都会优先使用compoesr.lock 中的版本号
                // 将composer.lock 提交到git 可以避免协同开发时的版本错误引起的问题
            # 删除依赖包
                php composer.phar remove "endroid/QrCode"

        ┏━━━━━━━━━━━━━━━━━━━━━
        ┃使用Composer 安装QRcdoe 类库
        ┗━━━━━━━━━━━━━━━━━━━━━
            php composer.phar require "SimpleSoftwareIO/simple-qrcode:~1.5"
            # controller file
                use SimpleSoftwareIO\QrCode\BaconQrCodeGenerator;
                ...
                $path = ROOT_PATH.'public'.DS.'static'.DS.'qrcode'.DS.'qrcode.png';
                $qrcode = new BaconQrCodeGenerator;
                // 输出为<svg>
                return $qrcode->size(250)->color(150,90,10)->margin(0)->generate('Make me a QrCode!');
                // 或直接保存为图片
                return $qrcode->format('png')
                            ->size(250)
                            ->color(150,90,10)
                            ->margin(0)
                            ->generate('Make me a QrCode!', $path);

    -- 行为
        # 行为既可以独立调用,也可以绑定到某个标签中进行侦听
        -- 添加行为标签位[钩子]
            $params = '测试输出';
            \think\Hook::listen('register_begin', $params);             // 参数只能有一个,引用传值,必须是变量
        -- 定义行为类
            namespace app\index\behavior;
            class Test{
                public function run(&$params){// 行为入口方法 ...}
                public function printLog(&$params){// code ...}
            }
        -- 行为绑定
            # tags.php
            return [
                'print_log' => [
                    'app\\index\\behavior\\Test'
                ]
            ];
        -- 直接执行行为
            Hook::exec('app\\index\\behavior\\Test', 'printLog', $params);

# 命令行
    -- 命令格式
        php think [指令] [参数]
    -- 常用指令
        bulid/make:controller/make:model/
    -- 自动生成目录结构
        1. 定义APP_PATH 下的 build.php
            return [
                // 应用下的公共文件
                '__file__' => ['common.php', 'config.php', 'database.php', 'build.php'],
                // 应用下的目录
                '__dir__' => ['templates'],
                // 应用下的模块
                'test'     => [
                    '__dir__'    => ['behavior', 'controller', 'model'],
                    'controller' => ['Index', 'Supplier'],
                    'model'      => ['User', 'Supplier'],
                ],
                // 其他更多的模块定义
            ];
        2. php think build
    -- 生成控制器/模型
        php think make:controller index/User
        php think make:model index/User






