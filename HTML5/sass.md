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

