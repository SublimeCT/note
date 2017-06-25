1 面向对象的 JavaScript
    1 多态
        1 js 中的多态实现
            var Duck = function(){};
            var Chicken = function(){};
            Duck.prototype.say = function(){
                console.log('嘎嘎嘎');
            }
            Chicken.prototype.say = function(){
                console.log('咯咯咯');
            }
            var makeSound = function(animal){
                animal.say();
            }
            makeSound(new Duck());
            makeSound(Chicken.prototype);
        2 java 中的多态实现
            public abstract class Animal{
                public void makeSound();
            }
            public class Duck extends Animal{
                public void makeSound(){
                    System.out.println('咯咯咯');
                }
            }
            public class Chicken extends Animal{
                public void makeSound(){
                    System.out.println('嘎嘎嘎');
                }
            }
            public class AnimalSound{
                public void makeSound(Animal animal){
                    animal.makeSound();
                }
            }
            public class Test{
                public static void main(String[] args) {
                    Duck duck = new Duck();
                    Duck chicken = new Chicken();
                    AnimalSound animaSound = new AnimalSound();
                    animaSound.makeSound(duck);
                    animaSound.makeSound(chicken);
                }
            }
        3 区别
            动态语言直到执行时才确定数据类型, 所以多态的实现不需要使用 Java 多态中向上转型技术
        4 作用
            把过程化的条件分支语句转换为对象的多态性, 从而取消条件分支语句
    2 封装
        1 封装数据
            // 除了 ECMAScript 6 中的 let 之外, 一般通过函数作用域模拟 private 访问权限
            var myObject = (function(){
                var _name = 'sc';
                return {
                    getName : function(){
                        return _name;
                    }
                };
            })();
        2 封装实现
            对象与对象之间通过暴露的API接口实现通信, 使得对象之间的耦合变得松散
        3 封装类型
            静态语言中通过抽象类和接口实现类型的封装
        4 封装变化
            把系统中稳定不变的部分和变化的部分隔离开, 把容易变化的部分封装起来, 可以最大限度的提高稳定性和可扩展性
    3 原型模式
        通过克隆来创建对象, 是克隆 Object.prototype 而得到的对象
        0 创建对象
            var o = {};
            var o = new Object();
            var o = Object.prototype;
            // 或者通过构造函数创建对象
            function Test(){
                this.name = 'sc';
                this.age = 18;
            }
            var test = new Test();                  // test 
        1 获取对象的原型对象
            var a = new Object();
            var b = {};
            var c = Object.create(a);               // ECMAScript5 中实现继承的方法y
            // ECMAScript 5
            >>> Object.getPrototypeOf(a) === Object.prototype;          // true
            >>> Object.getPrototypeOf(b) === Object.prototype;          // true
            >>> Object.getPrototypeOf(c) === Object.prototype;          // false, c的原型是a
            // __proto__属性获取 c 对象的原型对象, 也就是被克隆的对象
            // 与 Object.getPrototypeOf() 作用相同
            >>> c.__proto__ === a;                                      // true
        2 通过原型链克隆对象
            // 兼容
            Object.create = Object.create || function(obj){
                var O = new Object();
                O.prototype = obj;
                return new O();
            }
            var aObj = Object.create(bObj);
        3 prototype 属性
            prototype 属性指向函数的原型对象
            __proto__ 属性指向该对象对应的构造函数的 prototype 属性
            1 创建对象时的属性指向
                var test = new Object();
                console.log(test.__proto__ === Object.prototype);
                console.log(Object.prototype.__proto__ === null);

                var test = new Test();
                console.log(test.__proto__ === Test.prototype);
                console.log(Test.prototype.__proto__ === Object.prototype);
        4 new 关键字
            function Person(name){
                this.name = name;
            }
            var objectFactory = function(){
                var obj = new Object(),                         // 从 Object.prototype 克隆一个空对象
                Constructor = [].shift.call(arguments);         // 获取该构造方法的第一个参数, 也就是构造函数 Person
                obj.__proto__ = Constructor.prototype;          // 构造原型链
                var ret = Constructor.apply(obj, arguments);    // 借用构造函数设置属性
                return typeof ret === 'object' ? ret : obj;     // 确保构造器总是返回一个对象
            }
            // 等同于 new Person('sc');
            var p = objectFactory(Person, 'sc');
        5 ECMAScript6 面向对象语法
            class Aniaml{
                constructor(name){
                    this.name = name;
                }
                getName(){
                    return this.name;
                }
            }
            class Dog extends Aniaml{
                construct(name){
                    super(name);
                }
                speak(){
                    return '25252525252525';
                }
            }
            var dog = new Dog('Fat kim');
            console.log(dog.getName()+' says '+dog.speak());

2 this call 和 apply
    1 this 
        this 在总是执行一个对象, 这个对象是运行时的函数执行环境动态绑定的
        1 作为对象的方法被调用时, this 指向该对象
            var Obj = {name:'sc',sayName:function(){return this.name}}
            obj.sayName();                          // sc
        2 作为普通函数调用
            var name = 'global';
            var myObjName = Obj.sayName;
            console.log(myObject());                // global
        3 构造函数调用
            // 构造函数和普通函数相同, 只是在 new 操作时 this 指向返回的这个对象
            function Person(){this.name='sc'}
            var p = new Person();
            console.log(p);
        4 call / apply
            // 动态地改变传入的 this
    2 call / apply 
        ECMAScript3 中 Function.prototype 中定义了两个方法 call和apply
        call 和 apply 在函数式风格代码和设计模式中应用广泛
        0 作用
            执行函数并设置函数体内的 this 指向
        1 区别
            /*
             *  接收两个参数
             *      第一个参数是函数体内 this 的指向
             *          如果传入 null 则 this 指向宿主对象 window [严格模式下是函数体内的 this 为 null]
             *      第二个参数
             *          call:   依次传入参数
             *          apply:  传入参数数组
             */
            var fun = function(a, b, c){alert([a, b, c]);}
            fun.apply(null, [1, 2, 3]);
            fun.call(null, 1, 2, 3);
        2 用途
            1 改变 this 指向
                document.getElementById('box').onclick = function(){
                    console.log(this.id);
                    var fun = function(){
                        console.log(this.id);               // 匿名函数中 this 指向 window
                    };
                    fun();                                  // undefined
                    fun.call(this);                         // 将 this 指向 box 节点对象, 返回 box
                }
            2 Function.prototype.bind() 
                // 指定了函数内部的 this 指向
                Function.prototype.bind = function(obj){
                    var self = this;
                    return function(){
                        self.apply(obj, arguments);         // obj 借用该函数
                    }
                }
                var obj = {name: 'sc'};
                var fun = function(){
                    console.log(this.name);
                }.bind(obj);
                fun();
            3 借用其他对象的方法
                var Animal = function(name){this.name = name;};
                var Dog = function(){
                    Animal.apply(this, arguments);          // 借用父类构造函数实现继承
                };
                Dog.prototype.getName = function(){return this.name;}
                var dog = new Dog('Fat Kim');
                console.log(dog.getName());

                // arguments 当作数组操作
                // arguments 是一个类数组对象, 没有数组对象的方法, 但可以通过借用来实现
                [].shift.call(arguments);                   // 取出数组的第一项

3 闭包和高阶函数
    1 闭包
        1 变量的作用域
            使用 var 关键字声明的变量是局部变量, 未使用 var 的变量是全局变量
        2 变量的生存周期
            局部变量在函数执行结束之后会被立即销毁, 全局变量不会被销毁
            var fun = function(){
                var a = 1;
                return function(){
                    a++;
                    alert(a);
                }
            }
            /*
             *  该赋值操作实现了闭包, 闭包可以访问 function 中的局部变量
             *   
             *  fun() 返回了一个匿名函数的引用, 它可以访问 fun() 被调用时所在的作用域
             *  变量 a 在该匿名函数所处的作用域中
             *  该作用域中的 a 就没有被销毁, 可以被外界访问
             *  所以 a 就不会被销毁, 实现常驻内存
             */
            var f = fun();
            f();                // 2
            f();                // 3
            f();                // 4
            // 点击 div*5 弹出递增数字的 demo
            var nodes = document.getElementsByTagName('box'); 
            for (var i=0,len=nodes.length; i<len; i++) {
                /*
                 *  循环中的闭包只能获取循环后的变量的值
                 */
                nodes[i].onclick = function(){
                    alert(i);
                }
            }
            /*
             *  解决方案:  
             *       把 i 封闭起来(此时的 i 按值传递)
             *       当闭包执行中查找 i 值时, 会先找到被封闭在闭包环境中的 i
             */
            for (var i=0,len=nodes.length; i<len; i++) {
                (function(i){
                    nodes[i].onclick = function(){
                        alert(i);
                    };
                })(i);
            }            
        3 闭包的作用
            1 封装变量
                /*
                 *  封装计算乘积的操作, 并支持缓存
                 *      通过闭包将一下小函数和属性封装起来, 提高了代码的复用率, 避免了全局中变量被修改引发的错误
                 *  
                 */

                var mult = (function(){
                    // 缓存数据对象
                    var cache = {};
                    // 分离计算乘积的函数
                    var calculate = function(){
                        var a = 1;
                        // 计算所有传入参数的乘积
                        for (var i=0, l=arguments.length; i<l; i++) {
                            a = a * arguments[i];
                        }
                        return a;
                    }
                    return function(){
                        // 将数组转换为字符串, 检测是否缓存对应乘积
                        var args = Array.prototype.join.call(arguments, ',');
                        if (args in cache) {
                            return cache[args];
                        }
                        // 使用 apply() 为 calculate() 传参, 直接传入 arguments 会在 calculate 中读取为一个数组对象
                        return cache[args] = calculate.apply(null, arguments);
                    }
                })();
                console.log(mult(2,3,5));
            2 延续局部变量寿命
        4 闭包和面向对象设计
            /*
             *  通常用面向对象能实现的功能, 用闭包也能实现
             *  在 JS 的祖先语言 Scheme 中, 甚至没有提供面向对象的原生设计, 但可以用闭包构建
             *  可以用闭包来实现一个完整的面向对象系统
             *  
             */
            1 闭包写法
                var extent = (function(){
                    var value = 0;
                    return {
                        call: function(){
                            return ++value;
                        }
                    }
                })();
                console.log(extent.call());
                console.log(extent.call());
            2 面向对象写法
                // 字面量对象
                var extent = {
                    value: 0,
                    call: function(){
                        return ++this.value;
                    }
                }
                console.log(extent.call());
                console.log(extent.call());
                // 声明对象
                function Extent(){
                    this.value = 0;
                    if (typeof Extent.prototype.call !== 'function') {
                        Extent.prototype.call = function(){
                            return ++this.value;
                        }
                    }
                }
                console.log(extent.call());
                console.log(extent.call());
        5 用闭包实现命令模式
            /*
             *  命令模式的意图是将请求封装成对象
             *  将命令的发起者和执行者分离
             */
            1 面向对象版本
                // button#execute+button#undo
                var Tv = {
                    open: function(){
                        console.log('打开电视');
                    },
                    close: function(){
                        console.log('关闭电视');
                    }
                }
                var OpenTvCommand = function(receiver){
                    this.receiver = receiver;
                }
                Open.prototype.open = function(){this.receiver.open();}
                Open.prototype.close = function(){this.receiver.close();}
                var setCommand = function(command){
                    document.getElementById('execute').onclick = function(){command.open();}
                    document.getElementById('undo').onclick = function(){command.close();}
                }
                setCommand(new OpenTvCommand());
            2 闭包实现命令模式
                // 将 OpenTvCommand 改为普通函数, 用闭包封闭命令的接受者(执行者)
                var createCommand = funciton(receiver){
                    var execute = function(){
                        receiver.open();
                    }
                    var undo = function(){
                        receiver.close();
                    }
                    return {
                        open: execute,
                        close: undo,
                    }
                };
        6 闭包与内存管理
            1 JS 中的垃圾回收机制
                1 标记清除
                    垃圾收集器在运行的时候会给存储在内存中的所有变量都加上标记, 
                    然后它会去掉环境中的变量的标记和被环境中的变量引用的变量的标记, 
                    此后, 如果变量再被标记则表示此变量准备被删除。 
                    2008年为止，IE，Firefox，opera，chrome，Safari的javascript都用使用了该方式；
                2 引用计数
                    跟踪记录每个值被引用的次数, 
                    当声明一个变量并将一个引用类型的值赋给该变量时，这个值的引用次数就是1, 
                    如果这个值再被赋值给另一个变量，则引用次数加1 
                    相反，如果一个变量脱离了该值的引用，则该值引用次数减1
                    当次数为0时，就会等待垃圾收集器的回收

            2 内存泄漏
                内存泄漏是指我们已经无法再通过js代码来引用到某个对象, 
                但垃圾回收器却认为这个对象还在被引用，因此在回收的时候不会释放它, 
                导致了分配的这块内存永远也无法被释放出来。如果这样的情况越来越多, 
                会导致内存不够用而系统崩溃。

        7 高阶函数
            1 条件
                /*
                 *  可以作为参数被传递
                 *  或
                 *  可以作为返回值输出
                 */
            1 函数作为参数被传递
                1 回调函数
                2 Array.prototype.sort
                    // 从小到大
                    [1, 2, 3].sort(function(a, b){return a-b;});
                    // 从大到小
                    [1, 2, 3].sort(function(a, b){return b-a;});
            2 函数作为返回值输出
                /* 
                 *  在函数式编程中应用广泛
                 *  让函数返回一个可执行的函数, 意味着运算过程是可持续的
                 */
                1 判断数据的类型
                    var isType = function(type){
                        return function(obj){
                            // 根据数据类型返回 [object xxx] 格式的字符串
                            return Object.prototype.toString.call(obj) === '[object '+type+']';
                        }
                    }
                    var isArray = isType('Array');
                    var isString = isType('String');
                    var isNumber = isType('Number');
                    console.log(isNumber(1));
                    // 也可以使用 for 来批量注册
                    var Type = {};
                    for (var i=0, type; type = ['String', 'Array', 'Number'][i++];) {
                        (function(type){
                            Type['is'+type] = function(obj){
                                return Object.prototype.toString.call(obj) === '[object '+type+']';
                            }
                        })(type);
                    }
                    console.log(Type.isArray([]));
                2 getSingle
                    // 单例模式
                    var getSingle = function(fn){
                        var ret;
                        return function(){
                            return ret || (ret = fn.apply(this, arguments));
                        }
                    }
                    var getScript = getSingle(function(){
                        return document.createElement('script');
                    });
                    var script1 = getScript();
                    var script2 = getScript();
                    console.log(script1 === script2);
            3 高阶函数实现 AOP
                /*
                 *  AOP 面向切面编程
                 *      将一些与业务逻辑无关的功能模块分离出来
                 *      如日志统计 / 异常处理
                 *  JS 中的 AOP 实现是一种特别的装饰者模式的实现
                 */
                Function.prototype.before = function(beforefn){
                    var __self = this;                                      // 保存原函数引用
                    return function(){
                        beforefn.apply(this, arguments);                    // 执行前置方法
                        return __self.apply(this, arguments);               // 实现链式调用
                    }
                }
                Function.prototype.after = function(afterfn){
                    var __self = this;
                    return function(){
                        var ret = __self.apply(this, arguments);
                        afterfn.apply(this, arguments);
                        return ret;                                         // 实现链式调用
                    }
                }
                var func = function(){console.log(2);}
                // 返回的 function 中在 func 前执行前置方法
                func = func.before(function(){console.log(1);}).after(function(){
                    // 先执行 before 返回的 function, 然后执行后置方法
                    console.log(3);
                });
                func();                                                     // 1 2 3
            4 其他应用
                1 currying
                    /*
                     *  curring 又称部分求值
                     *      先将参数在闭包环境中保存起来, 不会立即求值
                     *      到真正需要求值的时候再将之前传入的参数一次性求值
                     */
                    var cost = (function(){
                        var args = [];
                        return function(){
                            if (arguments.length === 0) {
                                var money = 0;
                                for (var i=0, len=args.length;i<len;i++) {
                                    money += args[i];
                                }
                                return money;
                            }else{
                                /*
                                 *  arguments 并不是 Array 类型, 而是包含参数集合的 类数组对象  
                                 *  使用 apply 可以将 arguments 转换为参数数组传递给 push 方法
                                 */
                                [].push.apply(args, arguments);
                            }
                        }
                    })();
                    cost(2);cost(2);console.log(cost());                    // 4
                    /*
                     *  为 cost 创建公共的 currying 化函数
                     *  
                     */
                    var currying = function(fn){
                        var args = [];
                        return function(){
                            if (arguments.length === 0) {
                                return fn.apply(null, args);
                            }else{
                                [].push.apply(args, arguments);
                                return arguments.callee;
                            }
                        }
                    };
                    var cost = (function(){
                        var money = 0;
                        return function(){
                            for (var i=0, len=arguments.length;i<len;i++) {
                                money += arguments[i];
                            }
                            return money;
                        };
                    })();
                    // 将函数 currying 化
                    var cost = currying(cost);
                    cost(21)(21);cost(21);console.log(cost());








