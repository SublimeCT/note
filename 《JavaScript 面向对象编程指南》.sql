# 基本数据类型
    -- 数据类型
        -- 基本类型
            number/string/boolean/undefined/null[null 被认为是空的 object]
        -- 对象
            object
    -- typeof 操作符
        -- 返回值 
            number/string/boolean/undefined/object/function/
    -- number 类型
        -- 进制表示
            var num1 = 0377;            // 八进制
            var num2 = 0xff;            // 十六进制
        -- 指数表示
            var num = 1e1;              // 10
            var num = 1e3;              // 1000
            var num = 1e+3;             // 1000
        -- Infinity
            Infinity 表示最大数
            -Infinity 表示最小数
            将 1e308 改为 1e309 就超出了JavaScript 能够处理的最大值
            任何数除以 0 也是 Infinity
            >>> Infinity-Infinity           // NaN
            Infinity 与任何其他数值运算结果都是 Infinity
        -- NaN
            NaN 表示非数值, 但仍然属于 number 类型
            >>> 1+'a'                       // 返回NaN, 当 number 类型值运算失败, 就会返回 NaN
            >>> NaN === NaN                 // false, NaN 不等于任何东西, 包括它自己
    -- string 类型
        -- 自动类型转换
            >>> var a = '3';
            >>> a+3                         // 33[在JS中 + 表示字符串连接, 会将 3 转换为 '3']
            >>> a*3                         // 9
            >>> typeof a++                  // number
        -- 特殊字符串
            \'  \"  \\  \n  \r[回车]  \t[制表符]    \u[unicode 码]   \b[退格符]    \v[纵向制表符]   \f[换页符]   '
    -- boolean
        -- 将其它类型值转换为boolean
            除了 ''/null/undefined/0 外其他值转换 boolean 类型都返回true
    -- array
        -- 删除元素
            >>> var a = [1,33,4];
            >>> delete a[0];
            >>> a.length                        // 3, delete 操作符只是将 a[0] 设置为 undefined, 数组长度不变
        -- 数组方式访问字符串
            >>> var a = '只有你';
            >>> a[1];                           // 有
    -- 检测变量是否存在
        >>> if(typeof a !== 'undefined'){console.log('a is defined');}

# 函数
    -- 预定义函数
        parseInt/parseFloat/isNaN/encodeURIComponent/decodeURIComponent/eval/ ...
        -- parseInt
            转换成功返回数值, 失败时返回 NaN
        -- isNaN
            通过 isNaN() 判断是否是 NaN 类型值
    -- 作用域
        -- 全局变量
            // 不建议使用全局变量
            >>> function test(){local=1;}
            >>> local                                   // 报错
            >>> test();
            >>> local                                   // 1
        -- 作用域链
            // 在函数内部声明函数, 可以访问函数内部和作用域中的变量, 从而实现作用域链
            var a1 = 1;
            function x(){
                var b1 = 2;
                function xx(){
                    var c1 = 3;
                    function xxx(){
                        var d1 = 4;
                        console.log(b1);                // 2
                    }
                    xxx();
                }
                xx();
            }
            x();
        -- 删除变量
            >>> function fun(){alert('test');}
            >>> delete fun;
        -- 闭包
            # demo 1
                function test(){
                    var a = 1;
                    return function(){
                        return a;
                    }
                }
                var fun = test();
                fun();
            # demo 2
                var n;
                function test(){
                    var a = 1;
                    n = function(){             // 并且在 test 重复声明后可以访问 test 作用域
                        return a;
                    }
                }
                test();                         // 执行 test 方法, 将 n 修改为全局函数
                n();                            // 1
            # 循环中的闭包
                function f(){
                    var a = [];
                    var i;
                    for(i=0;i<3;i++){
                        a[i] = function(){
                            return i;           // 这里的函数并没有执行
                        }
                    }
                    return a;
                }
                >>> var a = f();
                >>> a[0]                        // 执行完 f() 时 i 的值已经变成 3
                >>> a[1]
                >>> a[2]
            # 迭代器
                function setup(arr){
                    var i = 0;
                    return function(){
                        return arr[i++];
                    }
                }
                var next = setup(['a','b','c']);
                >>> next();                     // 执行闭包函数实现访问数组下一项
                >>> next();
                >>> next();

# 对象
    -- 声明
        // 关键字/空格和特殊符号/以数字开头
        var o = {name:sc};
        var o = {'name':sc};
        var o = {"name":sc};
    -- 属性
        >>> window.jsidfio                      // 如果访问的对象的属性不存在, 会返回undefined, 不会报错
    -- this
        var o = {
            name:'sc',
            sayName:function(){
                return this.name;
            }
        };
        o.sayName();
    -- 构造函数
        function Test(name){
            this.name = name;
            this.sayName = function(){
                return this.name;
            };
        }
        var test = new Test('sc');
        
















