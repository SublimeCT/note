# 安装与环境
> GOPATH 必须设置, 可以有多个路径

fish 配置
```bash
# Set path for Go
set -x GOPATH /home/xxx/project/go_demo
set -x GOROOT /usr/local/go
set -x GOARCH amd64
set -x GOOS linux
set -x PATH $GOROOT/bin $GOPATH/bin $PATH
```

创建项目, (`GOPATH` 为 `/home/xxx/project/go_demo`)

```bash
# $GOPATH/src/公司名/开发者/项目名称
$ mkdir /home/xxx/project/go_demo/src/company_name.com/developer_name/project_name
```
