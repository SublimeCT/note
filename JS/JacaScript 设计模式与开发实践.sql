# 1-面向对象的 JavaScript
    -- 多态
        -- js 中的多态实现
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
        -- java 中的多态实现
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
        -- 区别
            动态语言直到执行时才确定数据类型, 所以多态的实现不需要使用 Java 多态中向上转型技术
        -- 作用
            把过程化的条件分支语句转换为对象的多态性, 从而取消条件分支语句
    -- 封装
        -- 封装数据
            // 除了 ECMAScript 6 中的 let 之外, 一般通过函数作用域模拟 private 访问权限
            var myObject = (function(){
                var _name = 'sc';
                return {
                    getName : function(){
                        return _name;
                    }
                };
            })();
        -- 封装实现
            对象与对象之间通过暴露的API接口实现通信, 使得对象之间的耦合变得松散
        -- 封装类型
            静态语言中通过抽象类和接口实现类型的封装
        









