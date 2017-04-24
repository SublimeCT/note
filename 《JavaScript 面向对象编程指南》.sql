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
        
        






















