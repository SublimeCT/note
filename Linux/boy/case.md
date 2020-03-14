# 8-分支语句

<!-- tabs:start -->

#### ** bash **

```bash
num=3
case $num in
    1)
        echo num is one;;
    2|3)
        echo num is two or three;;
    *)
        echo num is not knew;;
esac
```

#### ** fish **

```bash
set num 4
switch $num
    case 1
        echo num is 1
    case 2 3
        echo num is 2 or 3
    case '*'
        echo num is not knew
end
```

<!-- tabs:end -->

