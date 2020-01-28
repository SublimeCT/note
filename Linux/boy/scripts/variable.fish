#!/bin/bash

# command: bash Linux/boy/scripts/variable.sh (seq 11)
# echo "\$0 => $_"                # $0 => Linux/boy/scripts/variable.sh
echo "\$argv[1] => $argv[1]"    # $argv[1] => 1
echo "seq 3 6 => " seq 3 6      # seq 3 6 =>  seq 3 6
echo "\$argv[11] => $argv[11]"  # $argv[11] => 11
echo "\$# => " (count $argv)    # $# =>  11
echo "\$* => $argv"             # $* => 1 2 3 4 5 6 7 8 9 10 11
echo "\$status => $status"      # 0
echo "\$fish_pid => $fish_pid"  # 1942
