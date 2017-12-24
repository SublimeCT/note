# [Sass](https://www.sass.hk/)
> Sass 是一款强化 CSS 的辅助工具，它在 CSS 语法的基础上增加了变量 (variables) 嵌套 (nested rules) 混合 (mixins) 导入 (inline imports) 等高级功能  
这些拓展令 CSS 更加强大与优雅 使用 Sass 以及 Sass 的样式库（如 Compass）有助于更好地组织管理样式文件，以及更高效地开发项目

## [安装](https://www.sass.hk/install/)
- ruby
    - [使用 gem install 安装报错问题](http://blog.csdn.net/qq_35160701/article/details/52728965)
- webpack plugin & node modules
    - [安装 node-sass 时被墙](https://www.cnblogs.com/savokiss/p/6474673.html)  
        ```bash
        phantomjs_cdnurl=http://cnpmjs.org/downloads
        sass_binary_site=https://npm.taobao.org/mirrors/node-sass/
        registry=https://registry.npm.taobao.org
        ```
    - 需要安装 `node-sass & sass-loader`

## 语法格式
[两种语法格式](http://sass-lang.com/documentation/file.INDENTED_SYNTAX.html)

## 使用
> [所有配置项](http://sass-lang.com/documentation/file.SASS_REFERENCE.html#options)

*当文件没有扩展名时编辑方式为 sass, 添加 `--scss` 改为 scss*
```bash
sass input.scss output.css
```

*监听单个文件*
```bash
sass --watch input.scss:output.css
```

*监听目录*
```bash
sass --watch app/abc:app/def
```

## 功能扩展

### 嵌套
```scss
#main {
    color: #00ff00;
    // 父选择器
    &:hover {
        background-color: #ff0000;
    }
    // 属性嵌套
    font 20px/24px {
        size: 20px;
        weight: bold;
    }
}
```

### 变量
```scss
#main {
    $color: #EEE;
    // 声明为全局变量
    $width: 600px !global;
}
#box {
    width: $width;
}
```

### 数据类型
- 数字
- 字符串
    - 有引号字符串
        ```scss
        @mixin firefox-message($selector) {
            // 使用插值 #{} 时有引号字符串将被编译为无引号字符串
            body.firefox #{$selector}:before {
                content: "Hi, Firefox users!";
            }
        }
        @include firefox-message(".header");
        ```
    - 无引号字符串
- 颜色
- 布尔
- null
- 数组
> 数组本身没有太多功能, 但 [Sass list functions](http://sass-lang.com/documentation/Sass/Script/Functions.html#list-functions) 赋予了数组更多新功能 
- map

### 运算
```scss
p {
    font: 10px/8px;             // Plain CSS, no division
    $width: 1000px;
    width: $width/2;            // Uses a variable, does division
    // 使用插值语句包裹避免运算
    $font-size: 12px;
    $line-height: 30px;
    font: #{$font-size}/#{$line-height};
    p:before {
        // 连接字符串, 带引号字符串在 + 左侧, 运算结果有引号, 反之无引号
        content: "Foo " + Bar;
        font-family: sans- + "serif";
        // 在字符串中插值语句可以添加动态的值
        content: "I ate #{5 + 10} pies!";
    }
}
```
编译为
```css
p {
    font: 10px/8px;
    width: 500px;
    font: 12px/30px;
    p:before {
        content: "Foo Bar";
        font-family: sans-serif;
        content: "I ate 15 pies!";
    }
}
```

### 插值语句
```css
$name: box;
$attr: border;
p.#{$name} {
    #{$attr}-color: blue;
}
```

### 变量定义
定义变量时使用 `!default`, 只在变量 `未定义` 或 `null` 或 `空值` 时使用该值, 变量已存在时使用已定义的值
```css
$content: "First content";
$content: "Second content?" !default;
$new_content: "First time reference" !default;

#main {
  content: $content;
  new-content: $new_content;
}
```

### @import
将 sass / SCSS 文件导入  
```css
@import "foo.scss" "other.scss";
```

作为 css 原生的 `@import`
- `@import` 的文件扩展名为 `.css`
- `http://` 开头
- `url()` 开头
- 包含 `media queryies`

### @media

sass 中的 `@media` 允许在 `css规则` 中嵌套

```css
.sidebar {
    width: 300px;
    @media screen and (orientation: landscape) {
        width: 500px;
    }
}
```

编译为

```css
.sidebar {
    width: 300px;
}
@media screen and (orientation: landscape) {
    .sidebar {
        width: 500px;
    }
}
```

### @extend

`@extend` 的作用时将重复使用的样式 `.error` 延伸(`extend`)给需要包含这个样式的特殊样式 `.seriousError`

```css
.error {
    border: 1px #f00;
    background-color: #fdd;
}
.error.intrusion {
    background-image: url("/image/hacked.png");
}
a .error {
    color: red;
}
.seriousError {
    @extend .error;
    border-width: 3px;
}
```

`.seriousError` 将继承 `.error` 的所有样式, 包括 **包含 `.error` 的样式**, 编译为

```css
.error, .seriousError {
    border: 1px #f00;
    background-color: #fdd;
}
.error.intrusion, .seriousError.intrusion {
    background-image: url("/image/hacked.png");
}
a .seriousError {
    color: red;
}
.seriousError {
    border-width: 3px;
}
```

