#!/bin/bash

me="shit"
message="I am a peace of $me, I am $me"

echo ${message}                  # I am a peace of shit, I am shit
echo ${#message}                 # 31
echo ${message:0}                # I am a peace of shit, I am shit
echo ${message:2:2}              # am
# 从字符串开头开始删除最短匹配的子串
echo ${message#*am}              # a peace of shit, I am shit
# 从字符串开头开始删除最长 ...
echo ${message##*am}             # shit
# 从字符串结尾开始删除最短匹配的子串
echo ${message%am*}              # I am a peace of shit, I
# 从字符串结尾开始删除最长 ...
echo ${message%%am*}             # I

# 替换匹配到的第一个子串
echo ${message/$me/me}           # I am a peace of me, I am shit
# 替换匹配到的所有 ...
echo ${message//$me/me}          # I am a peace of me, I am me

