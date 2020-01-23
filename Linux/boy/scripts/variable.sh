#!/bin/bash

# command:
# bash command: bash Linux/boy/scripts/variable.sh {1..11}
# fish command: bash Linux/boy/scripts/variable.sh (seq 11)
echo "\$0 => $0"                # $0 => Linux/boy/scripts/variable.sh
echo "\$1 => $1"                # $1 => 1
echo "\${3..6} => " \${3..6}    # ${3..6} =>  $3 $4 $5 $6
echo "\$11 => ${11}"            # $11 => 11
echo "\$# => $#"                # $# => 11
echo "\$* => $*"                # $* => 1 2 3 4 5 6 7 8 9 10 11
echo "\"\$*\" => $*"            # "$*" => 1 2 3 4 5 6 7 8 9 10 11
