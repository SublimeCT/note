# 基本概念
1.语句
### switch 语句
            javaScript 中的switch 语句是全等匹配
            # demo 1
                var num = 3;
                switch(num){
                    case 3: console.log(3);
                    case 5: console.log('5 ?');break;               // 前一个 case 如果执行且没有 break 将会贯穿执行
                    case '3': console.log('string');
                }
            # demo 2
                var num = 3;
                switch(true){                                       // 因为 case 返回布尔值, 所以用 true 匹配符合条件的
                    case num<10: console.log('<10');
                        break;
                    case num>0 && num<5: console.log('0~5');
                        break;
                }
    ## 函数
        JavaScript 中没有重载
    ## 变量
        所有函数的参数都是按值传递的
        -- 执行环境
            执行环境中代码执行完毕后该环境会立即销毁, 全局环境直到关闭浏览器才会销毁
    ## 引用类型

    ## OOP
        -- 对象属性
            -- 属性类型
                描述属性的特性, 用于实现 JavaSctipt 引擎[ECMA 262 第五版]
                    1 数据属性
                        [[Configurable]]    能否通过 delete 删除该属性
                        [[Enumerable]]      能否通过 for-in 循环返回属性
                        [[Writable]]        能否 修改 该属性的值
                        [[Value]]           该属性的数据值[默认为 undefined ]
                        -- 属性定义
                            var o = {
                                name: 'sc'              // 直接定义的属性值 前三个属性类型为 true, Value 为'sc'
                            };
                        -- 属性修改
                            var o = {};
                            Object.definedProperty(o, 'name', {
                                writable: false,
                                value: 'Sc'
                            });
                            o.name = 'other';
                            console.log(o.name);        // Sc, 严格模式下赋值会报错
                    2 访问器属性
                        [[Configurable]]    能否通过 delete 删除该属性
                        [[Enumerable]]      能否通过 for-in 循环返回属性
                        [[get]]             读取数据时调用的函数[默认 undefined]
                        [[set]]             修改数据时调用的函数[默认 undefined]
                        -- 属性修改
                            // 访问器属性不能直接定义
                            var o = {
                                _name: 'sc'
                            };
                            Object.defineProperty(o, '_name', {
                                get: function(){
                                    return this._name+'test';           // 严格模式下设置get/set中的一个会报错
                                }
                                set: function(newValue){
                                    this._name = newValue;
                                }
                            });
                    ## 读取属性类型
                        Object.getOwnPropertyDescriptor(o, 'set');
        -- 创建对象
            -- 工厂模式
                function createPerson(name, age){
                    var obj = new Object();
                    obj.name = name;
                    obj.age = age;
                    obj.sayName = function(){return this.name;}
                    return obj
                };
                var person = createPerson('sc', 21);
            -- 构造函数
                function Person(name, age){
                    this.name = name;
                    this.age = age;
                    this.sayName = function(){
                        return this.name;
                    }
                }
                -- new 操作符执行流程
                    /*
                     * new 操作符执行流程
                     *     1. var obj = new Object()
                     *     2. 将构造函数的作用域赋给这个新对象(所以this 指向了新对象obj)
                     *     3. 执行构造函数中的代码[添加属性等]
                     *     4. return obj;
                     */
                    var person = new Person('sc', 21);
                    -- constructor 属性
                        // 每个实例的 constructor 都指向构造函数 Person
                        var person1 = new Person();
                        var person2 = new Person();
                        console.log(person1.constructor === Person);
                        console.log(person2.constructor === Person);
                        // 构造函数可以将实例标识为特定的类型, 工厂模式无法标识
                        console.log(person2 instanceof Person);
                        console.log(person2 instanceof Object);
                -- 缺点
                    /*
                     * 构造函数中的每个方法都要在实例化时创建一次   
                     *     JS中每个函数都是对象, 两种创建方式等价    
                     *         this.sayName = function(){ ... }
                     *         this.sayName = new Function('return this.name;');   
                     *     所以每个实例的同名函数并不相等
                     *         console.log(person1.sayName === person.sayName);
                     */
                    ## 解决方案
                        function Person(name, age){
                            this.sayName = sayName;
                        }
                        function sayName(){
                            return this.name;
                        }
                ## prototype 原型属性
                    /*
                     * 
                     * 
                     * 
                     * 
                     */
































