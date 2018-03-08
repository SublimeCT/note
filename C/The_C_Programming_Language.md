# The C Programming Language 学习笔记

# Hello World
```c
// 包含标准库信息(输入输出库)
#include <stdio.h>

/**
 * 华氏温度与摄氏温度对照表
 * 每个函数都以 main 函数为起点开始执行
 */
int main()
{
    float fahr, celsius;
    int lower, upper, step;
    lower = 0;
    upper = 300;
    step = 20;

    fahr = lower;
    while (fahr <= upper)
    {
        celsius = (5.0 / 9.0) * (fahr - 32.0); // 运算符中的所有操作数中有个一为浮点数则运算结果为浮点数
        // celsius = 5* (fahr - 32) / 9; // 整数与整数运算后的结果为整数
        printf("%3.0f\t%6.1f\n", fahr, celsius);
        fahr += step;
    }
    return 1;
}
```

## printf()
`printf` 是标准库中的一个函数
`%6.1f` 按浮点数打印, 至少占 `6` 个字节宽, 小数点显示两位

## 符号常量
```c
#include <stdio.h>

#define STEP 100 /* 定义符号常亮, 不需要加分号 */

int main ()
{
    printf("%3d", STEP);
    return 1;
}
```