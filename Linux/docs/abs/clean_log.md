# [清理 log 脚本](https://github.com/SublimeCT/note/tree/master/Linux/docs/abs/clean_log.md)

## 初始版本

```bash
#!/bin/bash

LOG_DIR='/tmp/shell_test'

cd $LOG_DIR # 引用变量时加 $ 符号

cat /dev/null > messages
cat /dev/null > error_log

echo 'Logs cleaned up.'

exit # 这是一种正确的退出脚本的方式
```

## 改良版本
...
