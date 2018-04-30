# 网页兼容性笔记

## IF
**兼容 IE8**
```html
<!--[if lt IE 9]>
　　<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
　　<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
```

## 渲染方式
**设置 IE 渲染方式为最高**
```html
<meta http-equiv="X-UA-Compatible" content="IE=Edge，chrome=1">
```