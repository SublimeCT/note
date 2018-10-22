# TypeScript

## links
- [doc](https://www.tslang.cn/docs/home.html)
- [test page](http://www.typescriptlang.org/play/index.html)

## 简介
`TypeScript` 是 `JavaScript` 的一个超集, 主要提供了类型系统和对 `ES6` 的支持

## 起步
```bash
# 安装
$ yarn global add typescript
# 生成配置文件 tsconfig.json
$ yarn --init
```

## 编译
编译过程中如果报错, 仍然会生成编译后的文件

```bash
$ tsc greeter.ts
```

监听文件变化
```bash
$ tsc -w greeter.ts
```

