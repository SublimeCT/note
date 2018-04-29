# CSS 笔记

## 自适应

### [`@media` 查询](https://www.cnblogs.com/baiyii/p/6973437.html)
**语法**
```css
@media mediaType and|not|only (media feature) {
    /*CSS-Code;*/
}
```

- `mediaType`
    - `all` 用于所有设备
    - `print`	用于打印机和打印预览
    - `screen` 用于电脑屏幕，平板电脑，智能手机等。（最常用）
    - `speech` 应用于屏幕阅读器等发声设备

**先设置 `<meta>`**

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
```
- 宽度等于当前设备宽度
- 初始缩放比例 1.0 (不缩放)
- 不允许用户手动缩放

**兼容 IE8**
```html
<!--[if lt IE 9]>
　　<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
　　<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
```

**设置 IE 渲染方式为最高**
```html
<meta http-equiv="X-UA-Compatible" content="IE=Edge，chrome=1">
```

**`max-width` 和 `min-width`**

- 文档宽度小于 600px 时应用该样式
```css
@media screen and (max-width: 600px) {
    ...
} 
```


