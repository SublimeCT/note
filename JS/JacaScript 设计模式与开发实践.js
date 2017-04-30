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
            var c = Object.create(a);
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
                var obj = new Object(),                         // 从 Object.prototype 创建一个空对象
                    Constructor = [].shift.call(arguments);     // 获取该构造方法的第一个参数, 也就是构造函数 Person
                obj.__proto__ = Constructor.prototype;
            }


        









