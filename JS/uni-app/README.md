# uni-app
> 可以通过 `vue-cli` 创建 `TypeScript` 项目

## 1. 前言
由于 `uni-app` 支持 `TypeScript`, 所以本文基于以下环境(开发方式):

- `TypeScript`: 使用 `vue create -p dcloudio/uni-preset-vue uni-app-ts` 创建项目, 并选择 `TypeScript` 项目, [详见](https://uniapp.dcloud.io/quickstart-cli)
- 优先使用命令行开发和调试(`HBuilder X` 也是要安装的, 并且), 只在打包和从 [插件市场](https://ext.dcloud.net.cn/) 安装 `uni_module` 插件时使用 `HBuilder`
- 使用 `vscode` 开发
- 使用 `yarn` 替代 `npm`
- 使用 `uview-ui` 作为 `UI` 库使用
- 使用 `vue class component API` 编写所有组件, 基于 [vue-class-component](https://github.com/vuejs/vue-class-component) & [vue-property-decorator](https://www.npmjs.com/package/vue-property-decorator)

### 1.1 使用 vue-cli 和 HBuilder X 创建项目的异同

创建方式 | 编译器位置 | 编译器升级方式 | 依赖(插件) | `HBuilder X` 版本要求
--- |--- |--- |--- |---
`vue-cli` | `./node_modules` | 手动使用 `npm / yarn` 更新 | **需要手动安装, 例如 `sass-loader`** | 只需安装标准版
`HBuilder X` | `HBuilder X` 安装目录下的 `plugin` 目录 | 跟随 `HBuilder X` 自动升级 | 从 [插件市场](https://ext.dcloud.net.cn/) 安装依赖 | 完整版

### 1.2 为什么不使用 HBuilder X

- 只在打包时使用 `HBuilder X`
- `vscode` 有很多自定义配置和插件, 而 `HBX` 无法自定义

### 1.3 为什么使用 vue-cli 创建项目

- 使用 `vue-cli` 创建的项目才是标准的 `node` 项目, *`HBX` 创建的不包含 `package.json` / `node_moduels` 等目录*
- 只有使用 `vue-cli` 才能创建 `TypeScript` 项目

## 2. 项目初始化

1. 创建项目, 选择 `TypeScript` 模版

```bash
vue create -p dcloudio/uni-preset-vue uni-app-ts
```

2. 添加必要依赖

```bash
yarn add sass uview-ui
yarn add -D sass-loader@^10.2.0
```

3. 添加 `uni-app` `d.ts` 类型描述文件

```bash
yarn add -D @types/uni-app
```

4. 引入必要依赖

```typescript
Vue.use('uview-ui')
```

5. 配置类型描述文件

```json
{
    "compilerOptions": {
        "typeRoots": ["src/typings"],
    }
}
```

## 3. uni-app 基础

- `src/main.ts` 应用入口文件
- [`src/App.vue`](https://uniapp.dcloud.io/collocation/App) 主组件, **不包含 `<template>`, 不能编写视图元素, 一般用来调用生命周期函数和全局配置**

## 4. 架构

模块 | 选型 | 官方解决方案 | 描述
--- |--- |--- |
全局状态管理 | `vuex` | _ | _

## 5. 原生 APP 配置
> [官方文档](https://nativesupport.dcloud.net.cn/AppDocs/usesdk/android), `uni-app` 只是一个 `webview`, 若要使用原生 `App` 的能力, 就必须使用 [H5 plus](https://ask.dcloud.net.cn/docs/#//ask.dcloud.net.cn/article/89)

## 附1 与标准的 vue 项目的不同之处

- 不能使用 `vuex`, `uni-app` 使用 `pages.json` 作为路由配置, [参考](https://uniapp.dcloud.io/collocation/main)
- 

## 附2 已知问题

### `sass-loader` 依赖版本问题

由于 `uni-app` 使用了 `webpack@4.x`, 所以 `sass-loader` 只能使用 `10.x` 版本, [#2647](https://github.com/dcloudio/uni-app/issues/2647)

### H5 plus 离线打包报错: 未配置appkey或配置错误
[参考](https://ask.dcloud.net.cn/question/126043)

## 附3 参考
- [uni-app APP 离线打包](https://nativesupport.dcloud.net.cn/AppDocs/README)
- [uni-app 官方文档](https://uniapp.dcloud.io/README)
