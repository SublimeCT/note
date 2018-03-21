# Canvas note

## links
- [MDN canvas API 文档](https://developer.mozilla.org/zh-CN/docs/Web/API/Canvas_API)
- [【canvas】一个少女心满满的例子带你入门 canvas](http://cherryblog.site/canvas-star.html)

## 简介
`<canvas>` 相当于一个画布, 通过 `js` 绘制图形

`<canvas>` 默认宽度为 `300 * 150`, 必须通过 `width` / `height` 设置宽高, 否则会根据默认尺寸放大 / 缩小

## 获取上下文
```javascript
const testCanvas = document.getElementById('test')
// 检测浏览器是否支持 canvas
const support = typeof testCanvas.getContent === 'function'
const testContext = testCanvas.getContext('2d')
```
所有的绘制功能都在 `context` 中
