# sypress

## links
- [官网](https://docs.cypress.io/zh-cn/guides/overview/why-cypress.html)
    - [使用 chai 断言](https://docs.cypress.io/zh-cn/guides/references/assertions.html#Chai)
    - [最佳实践](https://docs.cypress.io/zh-cn/guides/references/best-practices.html)
- [cypress-file-upload 实现上传文件](https://github.com/abramenal/cypress-file-upload)
- [mocha](https://mochajs.org/)

## Install
```bash
yarn add -D cypress @types/cypress
```

代码补全
```javascript
// 在测试代码中使用 cypress 的类型声明
/// <reference types="Cypress" />
```

## Guide
### 基本概念
- `describe` 块称为 **套件**, 表示一组相关的测试
- `it` 块称为 **测试用例**, 是一个单独的测试, 是测试的最小单位

```javaScript
cy.get('.todo-list li')         // command
    .should('have.length', 2)   // assertion
```

- `command` **命令**
- `assertion` **断言**

### 执行队列
在每一个 `测试用例` 中, 所有的命令都会放入 `队列` 中异步执行, 所以不能使用 `async / await` 写法, 并且会严格按照顺序执行

### 重试机制
> `cypress` 尝试像人类用户那样使用浏览器
> `cypress` 仅重试断言之前的最后一个 `command`

使用 `cy.get(selector)` / `find()` / `contains()` 时, 如果断言失败就会重复断言操作, 直到断言成功或超时; 正因如此, 在 `cypress` 可以忽略异步加载 / 更新 `DOM` 的影响

使用 `cy.get(selector).click()` 时, 会等到该元素变为可操作状态才会执行 `click`

### 支持的测试方式(Mocha) 
![](https://img-blog.csdn.net/20180415160603230)

- `BDD` Behavior Driven Development **行为驱动开发** 是一种敏捷软件开发技术, *它鼓励软件项目中的开发者、QA和非技术人员或商业参与者之间的协作*
- `TDD` Test-Driven Development **测试驱动开发** 是一种测试先于编码的软件开发方式, *在开发功能之前, 先编写测试代码, 测试代码确定了需要开发的功能*

### 元素交互
- 可以通过 `click dblclick type clear check uncheck select trigger` command 与 DOM 元素进行交互
- 元素必须是可见 / 可操作 / 在动画结束时 / 未被覆盖的
- 可以通过 `force: true` 跳过检查

```javascript
// 强制点击这个元素
// 即使此元素 '不可操作'
cy.get('button').click({ force: true })
```

## Usage

### 目录结构
- `cypress`
    - `fixtures` 测试过程中需要用到的外部静态数据
    - `integration` 存放测试代码
    - `plugins` 插件可以使用 `Nodejs API`
    - `support` 存放可重用代码, 如定义 `beforeEach`

### 钩子
执行顺序:

- `before()` *只执行一次*
- `beforeEach()` hook
- 测试代码
- `afterEach()` hook
- `after()` *只执行一次*

### exclude & include
```javaScript
describe('...', function() {
    // ...
    it.only('...', function () {}) // 执行指定的套件(包含嵌套的套件)或测试用例
    it.skip('...', function () {}) // 跳过指定的套件(包含嵌套的套件)或测试用例
})
```

### 别名(context 实现)
```javascript
// 通过别名添加全局变量
cy.get('button').invoke('text').as('text')
```

```javascript
it('...', function() {
    this.text // 可以直接访问, 由于作用于问题, 只能使用 function () {} 写法
})

// 箭头函数风格
it('...', () => {
    cy.get('@text') // 使用 @name 访问上下文环境
})
```

