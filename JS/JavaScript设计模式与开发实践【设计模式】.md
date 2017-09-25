# 二 设计模式
---------------------------------
## 单例模式
### 1.用代理实现单例模式
```javascript
    // 1. 创建一个普通的创建 Div 的类
    var CreateDiv = function(html){
        this.html = html;
        this.init();
    }
    CreateDiv.prototype.init = function(){
        var div = document.getElement('div');
        div.innerHTML = this.html;
        document.body.appendChild(div);
    }
    // 2. 引入代理类
    var ProxySingletonCreateDiv = (function(){
        var instance;
        return function(html){
            if (!instance) {
                 instance = new CreateDiv(html);   
            }
            return instance;
        }
    })();
    // 只执行了一次构造函数
    var a = new ProxySingletonCreateDiv('sven1');
    var b = new ProxySingletonCreateDiv('sven2');
    console.log(a === b);
```
### 2. js 中的单例模式
> 全局变量不是单例模式，但经常会把全局变量当作单例来使用  
应该尽量减少全局变量的使用

* 使用命名空间
```javascript
    var namespace = {
        a: 0,
        b: function(){}
    }
```
* 使用闭包封装私有变量
```javascript
    var user = (function(){
        var _name = 'sven', _age = 21;
        reutrn {
            getUserInfo: function(){
                return _name + '-' + _age;
            }
        }
    })();
```

### 3.惰性单例
**通用的惰性单例**  
> 基于类的单例模式在 JavaScript 中并不适用  
在面向对象语言中, 需要从类中创建对象, JavaScript 中没有类, 创建对象更加简单  
单例模式的核心是 **确保只有一个实例, 并提供全局访问**

将管理单例的代码抽象出来
```javascript
    var obj;
    if (!obj) {
        obj = xxx;
    }
```
将逻辑封装在 getSingle 函数内部
```javascript
    var getSingle = function(fun){
        var result;
        return function(){
            return result || (result = fn.apply(this, arguments));
        }
    }
```
```javascript
    var createLoginLayer = function(){
        var div = document.createElement('div');
        div.innerHTML = '登陆浮窗';
        div.style.display = 'none';
        document.body.appendChild(div);
    }
    var createSingleLoginLayer = getSingle(createLoginLayer);
    ducument.getElementById('loginBtn').onclick = function(){
        var loginLayer = createLoginLayer();
        loginLayer.style.display = 'block';
    };
    // 还可以创建其他标签, 且互不影响
```
## 策略模式
> 定义一系列算法并封装起来, 使它们可以互相替换  

### 1. 按绩效计算奖金
*最初的代码实现*
```javascript
    /**
     *  按绩效发放年终奖
     *      bonus = salary * n
     */
    var calculateBonus = function(performanceLevel, salary){
        switch (performanceLevel) {
            case 'S': return salary * 4;
            case 'A': return salary * 3;
            case 'B': return salary * 2;
        }
    }
    caculateBonus('S', 3500);
    caculateBonus('B', 6500);
```
使用策略模式重构代码
> 策略模式的目的就是将算法的使用和算法的实现分离  
策略模式至少由两部分组成:   
策略类 strategy: 封装具体算法, 负责具体的计算过程  
环境类 context: 接收到请求之后把请求委托给一个策略类, 所以环境类中要维持对某个策略对象的引用

```javascript
    // 策略类
    var PerformanceS = function(){};
    PerformanceS.prototype.calculate = function(saraly){
        return saraly * 4;
    }
    var PerformanceA = function(){};
    PerformanceA.prototype.calculate = function(saraly){
        return saraly * 3;
    }
    var PerformanceB = function(){};
    PerformanceB.prototype.calculate = function(saraly){
        return saraly * 2;
    }
    
    // 环境类
    var Bonus = function(){
        this.salary = null;
        this.strategy = null;
    }
    Bonus.prototype.setSalary = function(salary){
        this.salary = salary;
    }
    Bonus.prototype.setStrategy = function(strategy){
        this.strategy = strategy;
    }
    Bonus.prototype.getBonus = function(){
        return this.strategy.calculate(this.salary);
    }
    
    // 通过策略模式计算年终奖
    var bonus = new Bonus();
    bonus.setSalary( 3500 );
    bonus.setStrategy( new PerformanceS() );    // 设置策略对象
    console.log(bonus.calculate());
```

**JavaScript 版本的策略模式**
> 将 strategy/context 对象从各个对象上创建是面向对象语言的实现  
在 JavaScript 中更简单直接的是把 strategy/context 直接定义为函数

```javascript
    var strategy = {
        'S': function(salary){
            return salary * 4
        },
        'A': function(salary){
            return salary * 3
        },
        'B': function(salary){
            return salary * 2
        }
    }
    var calculate = function(level, salary){
        return strategy[level](salary);
    }
```

### 2. 使用策略模式实现表单校验

*一个简单的注册表单验证*
```javascript
    var registerForm = docuemnt.getElementByid('reg');
    registerForm.onsubmit = function(){
        if (registerForm.userName.value = '') {
            alert('用户名不能为空');
            return false;
        }
        // 更多验证逻辑 ...
    }
```
存在的问题:
- 验证逻辑可能会越来越庞大
- 缺乏弹性, 违反开放-封闭原则
- 复用性差

**开放-封闭原则**
> 1988 年 Bertrand Meyer 提出了开放-封闭原则  
软件实体(类/模块/函数等)应该对扩展开放, 对修改关闭

> **面向扩展开放**  
模块的行为是可以被灵活地扩展的

> **面向修改关闭**  
不允许修改已有源码

**用策略模式重构表单验证**
```javascript
    var validateFun = function(fm){
        var validator = new Validator();
        validator.add( fm.userName, 'isNonEmpty', '用户名不能为空' );
        validator.add( fm.passwotd, 'minLength:6', '密码长度不能小于 6 位' );
        validator.add( fm.userName, 'isMobile', '手机号码格式不正确' );
        var errorMsg = validator.start();
        return errorMsg;
    }
    
    var registerForm = docuemnt.getElementByid('reg');
    registerForm.onsubmit = function(){
        var errorMsg = validateFun();
        if (errorMsg) {
            alert(errorMsg);
            return false;
        }
    }
    
    // 分离策略类
    var strategies = {
        isMonEmpty: function(value, errorMsg){
            if (value === '') return errorMsg; 
        },
        minLength: function(value, length, errorMsg){
            if (value.length < length) return errorMsg;
        },
        isMobile: function(value, erorrMsg){
            if (!/^1[3|5|6|7|8|9][0-9]{9}$/) return errorMsg;
        }
    }
    
    // 环境类
    var Validator = function(){
        // 保存校验规则
        this.cache = [];
    };
    Validator.prototype.add = function(dom, rule, errorMsg){
        var arr = rule.split(':');                      // 将参数和策略分开
        this.cache.push(function(){
            var strategy = arr.shift();                 // 获取策略
            arr.unshift(dom.value);                     // 加入 value
            arr.push(errorMsg);                         // 加入 errorMsg
            return strategies[strategy].apply(dom, ary);
        });
    }
    Validator.prototype.start = function(){
        for (var i=0, validatorFun; validatorFun=this.cache[i++];) {
            var msg = validatorFun();
            if (msg) {
                return msg;
            }
        }
    }
```

## 代理模式
> 为一个对象提供一个代用品或占位符, 以便控制对他的访问

### 虚拟代理实现图片预加载

**单一职责原则**
> 就一个类(包括对象和函数), 应该仅有一个引起它变化的原因  
面向对象设计鼓励将行为分布到细粒度的对象中

**图片预加载**
> 先用一张 loading 图片占位, 然后异步加载图片, 加载完成后再填充到 img 节点里

*普通的图片预加载*
```javascript
    // 未使用代理模式
    var MyImage = (function(){
        var imgNode = document.createElement('img')
        document.body.appendChild(imgNode)
        var img = new Image
        img.onload = function(){
            imgNode.src = img.src
        }
        return {
            setSrc: function(src){
                imgNode.src = 'http://images.cnitblog.com/blog/494657/201311/12200755-7bf95e92e806470297186fb629df366c.png'
                img.src = src
            }
        }
    })();

    MyImage.setSrc('http://ogtz66v5z.bkt.clouddn.com/images/tech/nodejs.png');
```
> 实际上需要的只是给 img 节点设置 src 属性, 预加载图片只是一个锦上添花的功能  
可以通过代理模式把预加载图片放到代理对象中, 待预加载完成后再把请求重新交给本体 MyImage  


> **代理模式** 并没有改变或新增 MyImage 的接口, 而是将两个功能分隔到两个对象中, 它们之间互不影响  

```javascript
    // 使用代理模式
    var MyImage = (function(){
        var imgNode = document.createElement('img')
        document.body.appendChild(imgNode);
        return {
            setSrc: function(src){
                imgNode.src = src
            }
        }
    })();
    var ProxyImage = (function(){
        var img = new Image
        img.onload = function(){
            MyImage.setSrc(this.src)
        }
        return {
            setSrc: function(){
                MyImage.setSrc('http://images.cnitblog.com/blog/494657/201311/12200755-7bf95e92e806470297186fb629df366c.png');
                img.src = src
            }
        }
    })();
    ProxyImage.setSrc('http://ogtz66v5z.bkt.clouddn.com/images/tech/nodejs.png')
```
*代理和本地接口的一致性*
> **代理模式的关键是代理对象和本体都对外提供了 setSrc 属性**  
如果以后不需要预加载, 只需改变请求本体

### 虚拟代理合并 HTTP 请求
*在 WEB 开发中, 也许最大的开销就是网络请求*  
*频发的网络请求会带来很大的开销*
> 可以通过一个代理函数 proxySynchronousFile 来收集一段时间内的请求, 最后一次性发送

**代理模式实现合并 HTTP请求**
```javascript
    /**
     *  网盘中点击 checkbox 同步文件
     */
    var synchronousFile = function(id){
        console.log('开始同步文件');
    }
    var proxySynchronousFile = (function(){
        var cache = [];
            timer;
        return function(id){
            // 将文件id 缓存
            cache.push(id);
            if (timer) {
                return;
            }
            timer = setTimtout(function(){
                synchronousFile(cache.join(','));
                clearTime(timer);
                timer = null;
                // 清空 cache
                cache.length = 0;
            }, 2000);
        }
    })();
    var checkbox = document.getElementByTagName('input');
    for (var i=0,c; c=checkbox[i++];) {
        c.onclick = function(){
            if (this.checked === true) {
                proxySynchronousFile(this.id);
            }
        }
    }
```
**缓存代理**
> 可以为一些开销比较大的运算结果或AJAX请求提供暂时存储, 如果传递进来的参数跟之前一致, 直接返回缓存

## 迭代器模式

> 提供一种方法顺序访问一个聚合对象中的各个元素, 而又不暴露该对象的内部表示

### 内部迭代器
> 内部迭代器已经定义好了迭代规则, 完全接受整个迭代过程, 外部只需一次调用即可

```javascript
    var each = function(arr, callback){
        for (var i=0,len=arr.length; item=arr[i++];) {
            callback(arr[i], i);
        }
    }
```
### 外部迭代器
> 外部迭代器必须显式地请求迭代下一个元素, 外部迭代器可以控制迭代顺序和过程, 增加了迭代的灵活性

```javascript
    var Iterator = function(obj){
        var current = 0;
        var next = function(){
            current += 1;
        }
        var isDone = function(){
            return current >= obj.length;
        }
        var getCurrentItem = function(){
            return obj[current];
        }
        return {
            current: current,
            isDone: isDone,
            getCurrentItem: getCUrrentItem
        }
    }
```

### 根据不同浏览器获取相应上传对象
> 按照自定义顺序迭代所有上传对象, 所有获取上传对象的方法都返回对象或 false  
> 如果再加入 webkit/html5 上传对象, 只需增加对应获取方法

```javascript
    // 获取 IE 上传控件, 有相应对象就返回, 没有就返回 false
    var getActiveUploadObject = function(){
        try{
            return new ActiveXObject("...");
        } catch(e) {
            return false;
        }
    }
    var getFlashUploadObject = function(){
        // flash 上传
    }
    var getFormUploadObject = function(){
        // 表单上传
    }
    
    var iteratorUploadObject = function(){
        for (var i=0,fun; fun=arguments[i++]) {
            var obj = fun();
            if (obj !== false) {
                return obj;
            }
        }
    }
    
    var obj = iteratorUploadObject(getActiveUploadObject, getFlashUploadObject, getFormUploadObject);
```

## 发布-订阅模式(观察者模式)

> 定义对象见的一对多的依赖关系, 当一个对象状态发生改变, 所有依赖于它都会收到通知

```javascript
    // 将发布-订阅模式提取出来
    var event = {
        clientList: [],
        listen: function(key, fun){
            if (typeof this.clientList[key] === 'undefined') {
                this.clientList[key] = [];
            }
            this.clientList.push(fun);
        },
        tigger: function(){
            var key = Array.prototype.shift.call(arguments),
                funs = this.clientList[key];
            if (typeof funs==='undefined' || funs.length===0) {
                return false;
            }
            for (var i=0,fun; fun=arguments[i++];) {
                fun.apply(this, arguments);
            }
        }
    }
    // 为其他对象动态安装发布-订阅模式
    var installEvent = function(obj) {
        for (var i in event) {
            obj[i] = event[i];
        }
    }
```

## 命令模式

> 命令模式指的时一个执行特定命令的指令  
**应用场景**: 需要向某些对象发送请求, 但不知道请求的接收者是谁, 也不知道被请求的操作是什么。  
此时希望用松耦合的方式设计软件, 使请求的发送者和接收者能够消除彼此见的耦合关系

```javascript
    var setCommand = function(button, func){
        button.onclick = function(){
            command.execute()
        }
    }
    var MenuBar = {
        refresh: function(){
            console.log('刷新菜单页面')
        }
    }
    var RefreshMenuBarCommand = function(receiver){
        return {
            execute: function(){
                receiver.refresh();
            }
        }
    }
    var refreshMenuBarCommand = RefreshMenuBarCommand(MenuBar)
    setCommand(button1, refreshMenuBarCommand)
```

## 组合模式

> 组合模式就是用小的对象构建更大的对象, 这些小的对象本身也许是由更小的对象构建而成的

### 更强大的宏命令
```html
    <button id="btn">超级万能遥控器</button>
    <h3>打开空调/电视/音响/关门/打开电脑/登陆QQ</h3>
    <script>
        // 定义宏命令对象工厂函数
        const MacroCommand = function(){
            return {
                commandsList: [],
                add: function(command){
                    this.commandList.push(command)
                },
                execute: function(){
                    for (let i=0, command; command=this.commandsList[i++];) {
                        command.execute()
                    }
                }
            }
        }
        // 叶对象命令
        const openAcCommand = {
            exevute: function() {
                console.log('打开空调')  
            },
            add: function(){
                throw new Error('叶对象不能添加子节点')
            }
        }
        /*可以用一个组合对象(宏命令)打开电视和音响*/
        const openTvCommand = {
            execute: function() {
                console.log('打开电视')
            }
        }
        const openSoundCommand = {
            execute: function() {
                console.log('打开音响')
            }
        }
        let macroCommand1 = MacroCommand()
        macroCommand1.add(openTvCommand)
        macroCommand1.add(openSoundCommand)
        
        /*关门/打开电脑/登陆qq*/
        const closeDoorCommand = {
            execute: function() {
                console.log('关门')
            }
        }
        const openPcCommand = {
            execute: function() {
                console.log('开电脑')
            }
        }
        const openQQCommand = {
            execute: function() {
                console.log('登陆qq')
            }
        }
        
        let macroCommand2 = MacroCommand()
        macroCommand2.add(closeDoorCommand)
        macroCommand2.add(openPcCommand)
        macroCommand2.add(openQQCommand)
        
        /*把所有命令组合成一个超级命令*/
        let macroCommand = MacroCommand()
        macroCommand.add(openAcCommand)
        macroCommand.add(macroCommand1)
        macroCommand.add(macroCommand2)
        
        document.getElementById('btn').onclick = function(){
            macroCommand.execute()
        }
        
    </script>
```

## 模板方法模式

```javascript
    // JavaScript 模拟抽象类
    var Beverage = function(){}
    /* 1 */
    Beverage.prototypr.init = function(){
        this.test()
    }
    /* 2 */
    Beverage.prototype.test = function(){
        throw new Error('子类必须重写 test 方法')
    }
```

### 钩子方法
> 在父类中封装了子类的算法框架, 但这些算法框架可能不适用于所有子类  

*饮料类*:  
- 把水煮沸  
- 用沸水冲泡饮料  
- 把饮料倒进杯子  
- 加调料 
 
这 4 个步骤适用于咖啡和茶, 但有些客人是不加调料的  

> 通过 钩子方法 可以解决这个问题, 放置钩子是隔离变化的一种常见手段

```javascript
    /* 饮料类 */
    var Beverage = function(){}
    Berverage.prototype.boilWater = function(){
        console.log('煮沸')
    }
    Berverage.prototype.brew = function(){
        throw new Error('子类必须重写 brew 方法')
    }
    Berverage.prototype.pourInCup = function(){
        throw new Error('子类必须重写 pourInCup 方法')
    }
    Berverage.prototype.addCondiments = function(){
        throw new Error('子类必须重写 addCondiments 方法')
    }
    Berverage.prototype.customerWantsCondiments = function(){
        // 默认需要调料
        return true
    }
    Berverage.prototype.init = function() {
        this.boilWater()
        this.brew()
        this.pourInCup()
        // 判断是否需要调料
        if (this.customerWantsCondiments()) {
            this.addCondiments()
        }
    }
    /* 咖啡类 */
    var CoffeeWithHook = function(){}
    CoffeeWithHook.prototype = new Beverage
    CoffeeWithHook.prototype.brew = function(){
        console.log('沸水冲泡咖啡')
    }
    CoffeeWithHook.prototype.pourInCup = function(){
        console.log('咖啡倒进杯子')
    }
    CoffeeWithHook.prototype.addCondiments = function(){
        console.log('加糖和牛奶')
    }
    CoffeeWithHook.prototype.customerWantsCondiments = function() {
        return false
    }
    (new CoffeeWithHook()).init()
```

### 非继承实现
```javascript
    var Beverage = function(param){
        var boilWater = function(){
            console.log('把水煮沸')
        }
        var brew = param.brew || function() {
            throw new Error('必须传递brew方法')
        }
        // ...
        var F = function(){}
        F.prototype.init = function() {
            boilWater()
            brew()
            // ...
        }
        return F
    }
    var Coffee = Beverage({
        brew: function(){
            console.log('用沸水冲泡咖啡')
        }
        // ...
    })
    (new Coffee()).init()
```

## 享元模式

> 享元模式(flyweight)是一种用于性能优化的模式  
享元模式的核心是运用共享技术支持大量细粒度的对象  
享元模式能很好的解决存在大量对象带来的性能问题

**内部状态与外部状态**
- 内部状态存储于对象内部
- 内部状态可以被一些对象共享
- 内部状态独立于具体的场景, 一般不会改变
- 外部状态取决于具体的场景, 根据场景变化, 外部状态不能被共享

## 职责链模式

> 使多个对象都有机会处理请求, 避免请求的发送者和接收者之间的耦合关系  
将这些对象连成一条链, 并沿着这条链传递请求, 直到有一个对象处理它为止

**用 AOP 实现职责链**

```javascript
    Function.prototype.after = function(fun) {
        var _this = this;
        return function() {
            var ret = _this.apply(this, arguments);
            if (ret === 'next') {
                return fun.apply.(this, arguments);
            }
            return ret;
        }
    }
    var order = order500yuan.after(order200yuan).after(orderNormal);
    order(1, true, 500);
    order(2, true, 500);
    order(1, false, 500);
```

**职责链获取文件上传对象**

```javascript
    var getActiveUploadObj = function(){
        try {
            return new ActiveXObject('...');
        } catch(e) {
            return 'next';
        }
    }
    var getFlashUploadObj = function(){
        if (supportFlash()) {
            var str = '<object type="application/x-shockwave-flash"></object>'
            return $(str).appendTo($('body'));
        }
        return 'next';
    }
    // ...
    var getUploadObj = getActiveUploadObj.after(getActiveUploadObj).after(getFormUploadObj);
    console.log(getUploadObj());
```

## 中介者模式

> 面向对象设计鼓励将行为分布到各个对象中, 把对象划分成更小的粒度, 有助于增强复用性  
但由于细粒度对象间的联系激增, 中介者模式的作用就是接触对象之间的紧耦合关系

> 所有的相关对象都通过中介者对象通信, 而不是相互引用

## 装饰者模式









































