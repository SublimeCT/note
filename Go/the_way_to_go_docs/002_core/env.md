# 环境变量
> 环境变量最好在安装 `Go` 之前就设置好  
> `GOPATH` 必须设置, 可以有多个路径

fish 配置
```bash
# Set path for Go
set -x GOPATH /home/xxx/project/go_demo # 包含源码文件`src` / 包文件`pkg` / 可执行文件`bin`
set -x GOROOT /usr/local/go # 安装路径
set -x GOARCH amd64
set -x GOOS linux
set -x PATH $GOROOT/bin $GOPATH/bin $PATH
```

创建项目, (`GOPATH` 为 `/home/xxx/project/go_demo`)

```bash
# $GOPATH/src/公司名/开发者/项目名称
$ mkdir /home/xxx/project/go_demo/src/company_name.com/developer_name/project_name
```
