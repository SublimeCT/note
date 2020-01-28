#!/bin/bash

# command: bash Linux/boy/scripts/variable.sh {1..11}
echo "\$0 => $0"                # $0 => Linux/boy/scripts/variable.sh
echo "\$1 => $1"                # $1 => 1
echo "\${3..6} => " \${3..6}    # ${3..6} =>  $3 $4 $5 $6
echo "\$11 => ${11}"            # $11 => 11
echo "\$# => $#"                # $# => 11
echo "\$* => $*"                # $* => 1 2 3 4 5 6 7 8 9 10 11
echo "\$@ => $@"                # $@ => 1 2 3 4 5 6 7 8 9 10 11
echo "\$? => $?"                # 0
echo "\$$ => $$"                # 1889

# $* 在使用双引号时会将所有参数拼接为一个字符串
for i in "$*"; do echo ">>$i";done      # >>1 2 3 4 5 6 7 8 9 10 11
