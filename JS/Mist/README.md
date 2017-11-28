# Mist for windows

## 链接

- [Mist Github 地址](https://github.com/ethereum/mist)
- [Meteor 入门文档中文翻译](http://zh.discovermeteor.com/chapters/getting-started/)
- [Mist WiKi](https://github.com/ethereum/mist/wiki)
- [ETHFANS](http://ethfans.org/wikis/Mist-Mirror)
- [electron 中文文档](https://wizardforcel.gitbooks.io/electron-doc/content/tutorial/quick-start.html)

## 技术栈
- NodeJs
- Meteor
- Yarn
- electron
- gulp

## 运行环境搭建

- [chocolatey](https://chocolatey.org/install#non-administrative-install)

> 使用 `PowerShell` 安装, 先[设置执行策略](http://www.jb51.net/article/53643.htm)  

- [meteor](https://www.meteor.com/install)

> 安装 `chocolatey` 后执行 `choco install meteor`

> [windows 下载方式](http://blog.csdn.net/qqduxingzhe/article/details/74623542)

- [yarn](https://yarnpkg.com/zh-Hans/docs/install)

- [Python](https://www.python.org/downloads/windows/)

> [安装](http://blog.sina.com.cn/s/blog_15b1ce0210102wbkj.html) [配置环境变量](https://www.cnblogs.com/qiyeshublog/archive/2012/01/24/2329162.html)

- run

> 使用 `meteor` 需要(配置)[https://stackoverflow.com/questions/37185894/meteor-is-stuck-at-downloading-meteor-tool1-3-2-4] `hosts`  

`
54.192.225.217 warehouse.meteor.com
`

```bash
# 首先安装 sha3
yarn add sha3
yarn
cd interface
# 关于 i18n-bundler 的坑 https://github.com/ethereum/mist/issues/2491
# 首先卸载 i18n-bundler
meteor remove tap:i18n-bundler
meteor --no-release-check
# 然后启动
yarn dev:electron
```

## 目录结构

## meteor

> [Meteor 工作原理及优势和不足](http://www.broadview.com.cn/article/44)

**Meteor 目录结构**

> .gitignore  
.meteor/  
client/  在客户端运行  
server/  在服务器端运行  
lib/  
node_modules/  
package.json  
package-lock.json  
public/  
*除了 `/client` 和 `/server` 之外的文件在服务器端和客户端都会运行*

**加载顺序**
/lib > main.* > 其他文件以文件名的字母顺序载入

**Spacebars 模板语言**
> meteor 模板语言 Spacebars

- `{{> postsList}}` 模板的插入点
- `{{#each posts}} ... {{/each}}` 遍历对象
- `{{#if}} ... {{/if}}` 条件语句

**helper**

```javascript
Template.postsList.helpers({
  posts: postsData
})
```

**命令行**
- meteor shell  
    通过 `meteor shell` 启动
- mongo shell
    通过 `meteor mongo` 启动

**基本命令**
- `meteor reset` 清空数据库
- `db.posts.find()` / `Posts.find().fetch()` 查看数据
- `Posts.find()` 返回从动数据源

**集合**
- 服务器端
> 在服务器端，通过 API 操作 Mongo 数据库  
在服务器端的代码, 可以写像 `Posts.insert()` 或 `Posts.update()` 这样的 Mongo 命令对 Mongo 数据库中的 posts 集合进行操作

```bash
meteor mongo
db.posts.insert({title:'A New Post'})
db.find()
```

- 客户端
> 客户端中的 `Posts = new Mongo.Collection('posts')` 实际上是在浏览器缓存中创建了一个 `Mongo` 集合

**发布-订阅**

- 服务器端发布
```javascript
Meteor.publish('posts', author => {
    // 按作者筛选数据并返回部分字段
    return Posts.find({author}, {fields: {content: false}})
})
```

- 客户端订阅
```javascript
Meteor.subscribe('posts', 'sven')
```

**自动发布**
> 使用 `meteor create` 创建项目时系统会自动包含并启用 `autopublish` 包  
它简单地把数据库中所有的数据镜像到客户端
基于这个原因, 自动发布只在你起步阶段且还未考虑发布之前时使用














