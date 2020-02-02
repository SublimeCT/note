# 服务对应的可执行文件存放路径
set SERVER_RELATIVE_PATH condition_receivers

# 打印提示信息
function print_nemu
    echo '
1. install lamp
2. install lnmp
3. exit

please input the num you want:'
end

print_nemu
read -p "" index

# 检测用户输入
if not string match -r '^[1-3]$' $index
    echo "the num you input must be {1|2|3}"
    echo "Input Error"
    exit 1
end

# 退出
if test $index = 3
    echo 'exit.'
    exit 2
end

# 运行对应服务
set serve_name (test $index = 1 && echo 'lamp' || echo 'lnmp')
set serve_exec_path $SERVER_RELATIVE_PATH/$serve_name
# 检查是否安装对应服务
if not test -x $serve_exec_path
    echo "$serve_name($serve_exec_path) does not exists or can not be exec."
    exit 3
end

# 最终执行对应文件启动服务
source $serve_exec_path

exit $status