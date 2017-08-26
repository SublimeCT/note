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
            if (!/^1[3|5|6|7|8|9][0-9]{9}$/.test(value)) return errorMsg;
        }
    }
    
    // 环境类
    var Validator = function(){
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




























