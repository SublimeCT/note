# 移动端自适应开发笔记

## 资源
- [@media 查询](https://www.cnblogs.com/baiyii/p/6973437.html)
- [rem 单位教程](https://www.imooc.com/learn/942)

## `@media` 查询
### 语法
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


### `max-width` 和 `min-width`

- 文档宽度小于 360px 时应用该样式
```css
@media screen and (max-width: 360px) {
    /* ... */
} 
```

- 320px - 360px
```css
@media screen and (max-width: 360px) and (min-width: 320px) {
    /* ... */
} 
```

## 布局方式
**静态布局**  
使用 `px` 固定元素尺寸, 将移动端与PC端分开

**自适应布局**
通过 `@media` 创建多个屏幕尺寸下的 `css`

**流式布局**
通过百分比设置元素尺寸

**响应式布局**
将自适应布局与流式布局结合, 为不同尺寸屏幕创建流失布局的 `css`

**弹性布局**
使用 `rem` / `em` 等相对单位定义尺寸


## 单位
### rem 单位
相对于根元素的 `font-size`

### viewport units
> `viewport units` 相对于视口尺寸的单位

**视口**
浏览器内部可视区域

**vw**
`vw = 视口宽度 / 100`

**vh**
`vh = 视口高度 / 100`

**vm**
`vm = 视口宽度和高度中最小的一个 / 100`

## DPR
### 物理像素
屏幕上用肉眼能看到的颗粒

### 逻辑像素
计算机坐标系统中的一个点, 表示可以通过程序使用的虚拟像素

### 像素比 DPR
> DPR = 物理像素 / 逻辑像素  
电脑屏幕的 **DPR === 1**  
移动端 **DPR > 1**

- PC端  
![](https://images2015.cnblogs.com/blog/740839/201605/740839-20160515102843711-1407435940.gif)

- 移动端  
![](https://images2015.cnblogs.com/blog/740839/201605/740839-20160515103300602-1749012296.gif)








