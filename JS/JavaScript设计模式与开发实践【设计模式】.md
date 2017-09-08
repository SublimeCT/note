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
    



































