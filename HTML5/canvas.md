# Canvas note

## links
- [MDN canvas API 文档](https://developer.mozilla.org/zh-CN/docs/Web/API/Canvas_API)
- [【canvas】一个少女心满满的例子带你入门 canvas](http://cherryblog.site/canvas-star.html)

## 简介
`<canvas>` 相当于一个画布, 通过 `js` 绘制图形

`<canvas>` 默认宽度为 `300 * 150`, 必须通过 `width` / `height` 设置宽高, 否则会根据默认尺寸放大 / 缩小

## 获取上下文
[文档](/Users/test/test/canvas.html)

```javascript
const testCanvas = document.getElementById('test')
// 检测浏览器是否支持 canvas
const support = typeof testCanvas.getContent === 'function'
const testContext = testCanvas.getContext('2d')
```
所有的绘制功能都在 `context` 中

## 栅格
canvas 的画布以左上角为原点, 横向为 x 轴, 纵向为 y 轴

## CanvasRenderingContext2D API
### fillStyle
设置填充颜色或渐变 [doc](https://developer.mozilla.org/zh-CN/docs/Web/API/CanvasRenderingContext2D/fillStyle)
```javascript
ctx.fillStyle('blue')
ctx.fillStyle('rgba(23, 45, 67, 0.2)')
// ...
```

### 绘制矩形
```javascript
ctx.fillRect(10, 10, 100, 100); // 绘制填充矩形
ctx.strokeRect(10, 10, 100, 100); // 绘制矩形边框
ctx.clearRect(10, 10, 100, 100); // 清除矩形区域
```

### 绘制圆形
`beginPath()` 系统默认将 `beginPath` 作为绘制的第一个开始点, 如果没有指定 `beginPath`, 则将上一次的 `beginPath` 作为开始点

*圆形*

`ctx(x, y, radius, startAngle, endAngle[, anticlockwise])`  
从起始点到终点绘制圆弧, 起始点单位为 **弧度** 默认为顺时针  
radius 半径 / anticlockwise `true: 逆时针` `false: 顺时针`  
```javascript
ctx.beginPath()
ctx.arc(300, 300, 250, 0, Math.PI * 2)
ctx.stroke() // 绘制边框
ctx.fill() // 填充
```

绘制笑脸
```javascript
// this.radius = 300
ctx.beginPath()
// 脸
ctx.arc(this.radius, this.radius, this.radius / 2, 0, Math.PI * 2)
ctx.stroke()
// 眼睛
const leftEyePosition = this.radius - (this.radius * 0.18)
const rightEyePosition = this.radius + (this.radius * 0.18)
ctx.beginPath()
ctx.arc(leftEyePosition, leftEyePosition, 20, 0, Math.PI * 2)
ctx.stroke()
ctx.beginPath()
ctx.arc(rightEyePosition, leftEyePosition, 20, 0, Math.PI * 2)
ctx.stroke()
// 嘴
ctx.beginPath()
ctx.arc(this.radius, this.radius * 1.05, this.radius / 4, 0, Math.PI)
ctx.stroke()
```

*直线*

`lineTo(x, y)`

绘制三角形
```javascript
ctx.beginPath()
ctx.moveTo(300, 300)
ctx.lineTo(250, 350)
ctx.lineTo(350, 350)
ctx.fill()
```

*心形*

使用 `贝赛尔曲线` 绘制心形, [三次贝塞尔曲线](https://www.cnblogs.com/joyho/articles/5817170.html)

![贝赛尔曲线](https://mdn.mozillademos.org/files/223/Canvas_curves.png)
![三次贝赛尔曲线](https://images2015.cnblogs.com/blog/385229/201608/385229-20160829104858933-1753348065.gif)

...

*矩形*

```javascript
ctx.rect(200, 200, 300, 300)
ctx.fill()
```

### 绘制颜色
- fillStyle = `color 值`
- strokeStyle = `color 值`
- globalAppha = `0.0 - 1.0 {number} 透明度`, 通过 `rgba()` 同样可以实现透明效果
- lineWeight = `{number} 线宽`

### 绘制文本
[doc](https://developer.mozilla.org/zh-CN/docs/Web/API/Canvas_API/Tutorial/Drawing_text)
- fillText(text, x, y, maxWitdh)
- strokeText(text, x, y, maxWitdh)
- measureText(text) [预测量文本宽度](https://developer.mozilla.org/zh-CN/docs/Web/API/Canvas_API/Tutorial/Drawing_text#预测量文本宽度)

### 绘制图片
- drawImage(image, x, y[, width, height]) 指定尺寸
- drawImage(image, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight) [裁剪图片](https://developer.mozilla.org/zh-CN/docs/Web/API/Canvas_API/Tutorial/Using_images#Slicing)


## Path2D 对象
可以使用 `Path2D` 对象缓存或记录路径

使用路径绘制图形
```javascript
// 创建矩形路径
const rectPath = new Path2D()
rectPath.rect(100, 250, 200, 100)
// 创建圆形路径
const arcPath = new Path2D()
arcPath.arc(400, 300, 100, 0, Math.PI * 2)
// 填充路径
ctx.fill(rectPath)
ctx.stroke(arcPath)
```




