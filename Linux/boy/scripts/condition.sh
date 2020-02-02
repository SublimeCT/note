#!/bin/bash

# 服务对应的可执行文件存放路径
SERVER_RELATIVE_PATH=condition_receivers

# 打印提示信息
print_nemu() {
    cat <<END
1. install lamp
2. install lnmp
3. exit

please input the num you want:
END
}

print_nemu
read index

# 检测用户输入
[[ $index =~ ^[1-3]$ ]] || {
    echo "the num you input must be {1|2|3}"
    echo "Input Error"
    exit 1
}

# 退出
[[ $index == 3 ]] && {
    echo 'exit.'
    exit 2
}

# 运行对应服务
serve_name=$(test $index == 1 && echo 'lamp' || echo 'lnmp')
serve_exec_path=$SERVER_RELATIVE_PATH/$serve_name
# 检查是否安装对应服务
[[ -x $serve_exec_path ]] || {
    echo "$serve_name($serve_exec_path) does not exists or can not be exec."
    exit 3
}

# 最终执行对应文件启动服务
source $serve_exec_path

exit $?