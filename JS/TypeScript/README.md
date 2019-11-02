# TypeScript

## links
- [doc](https://www.tslang.cn/docs/home.html)
- [test page](http://www.typescriptlang.org/play/index.html)
- [配置 vscode launch.json](https://segmentfault.com/a/1190000011935122#articleHeader10)

## 简介
`TypeScript` 是 `JavaScript` 的一个超集, 主要提供了类型系统和对 `ES6` 的支持

- `typescript` 提供了 `tsc` 脚手架命令, 用于编译 `ts` 文件
- `ts-node` 提供了 `ts-node` 命令, 以支持实时编译并执行

## 起步

```bash
# 安装
yarn global add typescript
# 生成配置文件 tsconfig.json
yarn --init
```

配置 `vscode` 的 `launch.json` 配置文件

```bash
# 安装开发依赖
yarn add -D typescript ts-node
```

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Current TS File",
            "type": "node",
            "request": "launch",
            "program": "${workspaceRoot}/node_modules/ts-node/dist/bin.js",
            "args": [
                "${relativeFile}"
            ],
            "cwd": "${workspaceRoot}",
            "protocol": "inspector"
        }
    ]
}
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

