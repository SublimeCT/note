# eslint note
> [eslint](http://eslint.cn/)(中文) 是一个代码检查工具, 用于统一团队编码风格

## links
- [官网](https://eslint.org/) (English)
- [cli](http://eslint.cn/docs/user-guide/command-line-interface)
- [rules](http://eslint.cn/docs/rules/)

## start [doc](http://eslint.cn/docs/user-guide/getting-started)
### 安装
全局安装并加入 `devDependencies`
```bash
➜  note git:(master) ✗ yarn global add eslint
➜  note git:(master) ✗ yarn add -D eslint
```

## 配置
### 配置文件
> Vue 项目在创建时有默认生成的配置  

选择自定义配置
```bash
➜  egg-blog-front git:(master) ✗ eslint --init
? How would you like to configure ESLint? Answer questions about your style
? Are you using ECMAScript 6 features? Yes
? Are you using ES6 modules? Yes
? Where will your code run? Browser
? Do you use CommonJS? No
? Do you use JSX? No
? What style of indentation do you use? Spaces
? What quotes do you use for strings? Single
? What line endings do you use? Unix
? Do you require semicolons? No
? What format do you want your config file to be in? JavaScript
Successfully created .eslintrc.js file in /home/xxx/projects/egg-blog-front

```


```bash
# vue 项目安装后默认 2 个空格缩进
# 首先配置为改为 4 空格缩进
➜  egg-blog-front git:(master) yarn run eslint --fix
```

### 配置细节
- [`env`](http://eslint.cn/docs/user-guide/configuring#specifying-environments) 全局环境变量  
    这些配置项不互斥, 可以设置多个
- plugins
- [规则严重程度](http://eslint.cn/docs/user-guide/configuring#configuring-rules)    
    - off / 0 关闭
    - warn / 1 开启, 警告级别错误, 不会停止程序执行
    - error / 2 开启， 错误级别, 导致退出程序  
当参数为数组时第一项为严重程度
```json
{
    "rules": {
        "eqeqeq": "off",
        "xxx": "warn",
        "quotes": [
            "error",
        ]
    }
}
```
- [开启推荐规则](http://eslint.cn/docs/user-guide/configuring#configuring-rules)  
```json
{
    "extends": [
        "eslint:recommand"
    ]
}
```

可以使用 `./.eslintrc` 或 `package.json` 的 `eslintConfig` 字段作为配置对象

## 规则
> 默认禁用所有规则, 设置 `"extends": "eslint:recommended",` 开启[推荐的配置](http://eslint.cn/docs/rules/)



