#!/bin/bash

name=sven

# 若变量为空或未赋值, 则返回指定的默认值
echo ${name:-Jack}
# 若变量有非空值, 则返回指定的默认值
echo ${name:+Jack}
# 若变量为空或未赋值, 则将其赋值为默认值
echo ${name:=Jack}
# 若变量为空或未赋值, 则将作为标准错误输出
echo ${name:?Jack}
