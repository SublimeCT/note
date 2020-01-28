#!/usr/local/bin/fish

set me "shit"
set message "I am a peace of $me, I am $me"

echo {$message}                                     # I am a peace of shit, I am shit
echo (string length $message)                       # 31
echo (string sub --start 3 $message)                # am a peace of shit, I am shit
echo (string sub --start 3 --length 2 $message)     # am

# fish shell 提供了 string 命令封装了字符串处理功能
# 具体实现可以查看 `string` / `string replace`

string replace -a $me 'me' $message                 # I am a peace of me, I am me
