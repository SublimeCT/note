# web3.js note

## [创建](https://web3js.readthedocs.io/en/1.0/include_package-core.html?highlight=ipc)

运行时报错

`
Uncaught Error: The module '/Users/sy/projects/mist-electron/node_modules/scrypt/build/Release/scrypt.node'
was compiled against a different Node.js version using
NODE_MODULE_VERSION 57. This version of Node.js requires
NODE_MODULE_VERSION 54. Please try re-compiling or re-installing
the module (for instance, using `npm rebuild` or`npm install`).
`

设置 `web3` 版本 `package.json`
```json
"web3": "^0.18.4"
```
```bash
npm i --registry=https://registry.npm.taobao.org
```