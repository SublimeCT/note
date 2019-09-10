# Set path for NodeJS
# set -x NODE_HOME /usr/local/node
# set -x PATH $NODE_HOME/bin $PATH

# Set path for Yarn
set -x YARN_HOME /home/sven/.yarn
set -x PATH $YARN_HOME/bin $PATH

# Set path for JAVA
set -x JAVA_HOME /usr/local/jdk
# set -x JRE_HOME $JAVA_HOME/jre
set -x CLASSPATH $JAVA_HOME/lib $JRE_HOME/lib
set -x CLASSPATH ".:$CLASSPATH"
set -x PATH $JAVA_HOME/bin $PATH

# Set path for maven
set -x MAVEN_HOME /usr/local/maven
set -x PATH $MAVEN_HOME/bin $PATH

# Set path for Postgresql
set -x PGUSER sven

# Set path for Go
set -x GOPATH /home/sven/project/go_demo
set -x GOROOT /usr/local/go
set -x GOARCH amd64
set -x GOOS linux
set -x PATH $GOROOT/bin $GOPATH/bin $PATH

# Set path for Dart
set -x DART_PATH /usr/lib/dart
set -x PATH $DART_PATH/bin $PATH

# Set path for flutter
set -x PUB_HOSTED_URL https://pub.flutter-io.cn
set -x FLUTTER_STORAGE_BASE_URL https://storage.flutter-io.cn
set -x FLUTTER_HOME /usr/local/flutter
set -x PATH $FLUTTER_HOME/bin $PATH

# Set options to fuck GFW
set -x ELECTRON_MIRROR https://npm.taobao.org/mirrors/electron/

# Set options to pack Electron App
set -x npm_config_target 3.1.6
set -x npm_config_arch x64
set -x npm_config_target_arch x64
set -x npm_config_disturl https://npm.taobao.org/mirrors/electron/
set -x npm_config_runtime electron
set -x npm_config_build_from_source true

# Set path for Rust
set -x RUSTUP_DIST_SERVER https://mirrors.ustc.edu.cn/rust-static
set -x RUSTUP_UPDATE_ROOT https://mirrors.ustc.edu.cn/rust-static/rustup
set -x PATH $HOME/.cargo/bin $PATH

# Set Http/Https proxy
# set -x http_proxy http://127.0.0.1:12333
# set -x https_proxy http://127.0.0.1:12333
