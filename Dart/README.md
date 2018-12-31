# Dart

## links
- [dart articles](http://www.cndartlang.com/dart)
- [dart syntax](http://dart.goodev.org/guides/language/language-tour)
- [Dart China](https://www.dart-china.org/t/topic/541)
- [flutter china](https://flutterchina.club/get-started/install/)
- [flutter-io.cn](https://flutter-io.cn/#section-keynotes)
- [codelabs](https://codelabs.flutter-io.cn/codelabs/first-flutter-app-pt1-cn/index.html#0)
- [IMooc video](http://www.imooc.com/learn/1035)
- [post-1 环境配置](https://blog.csdn.net/Calvin_zhou/article/details/80499462)

## install [doc](https://www.dartlang.org/tools/sdk#install-a-debian-package)
使用 `deb` 包安装

## 运行模式
> 在 `webstorm` 中可通过 `Run—>Edit Configurations` 开启/关闭检查模式

- `checked mode` 检查模式 - 进行类型检查
- `production mode` 生产模式 - 忽略类型声明和 `assert`

## var / const / final
- `var` 变量
- `final` 常量
- `const` 编译时常量, 同时也是 `final`

```dart
void main () {
    final time = DateTime.now(); // OK
    const time = DateTime.now(); // Error, const 声明的只能是编译时常量
    print(time);
}
```

```dart
void main () {
    const a = 0.1;
    const b = a + 0.2; // 数字字面量为编译时常量, 算数表达式中只要操作数是常量, 则结果也是常量
    print(a + b);
}
```

## 数据类型
- numbers
- strings
- booleans
- lists
- maps
- runes
- symbols

### syntax
#### String
> `String` 是 `UTF-16` 编码的字符序列

```dart
void main() {
    // 相邻字符串编译时自动连接
    String text = 'Hello' ' ' 'World'; // 'Hello World'
    // 多行字符串 / 插值表达式
    String text1 = '''text: $text or ${text}
    end;''';
    // 加入 r 前缀创建原始字符串
    String text2 = r'$abc';
    // 仅在 checked mode 执行
    assert(text == 'Hello World');
    print(text);
    print(text1);
    print(text2);
}
```

#### Number
```dart
void main() {
    const a = 1;
    // 如果一个数带小数点，则其为 double
    const b = 1.0;
    print(a);
    print(b);
}
```

```dart
void main() {
    final a = int.parse('123'); // string => int
    final b = double.parse('1.23'); // double => int
    print(a);
    print(a.toString()); // int => string
    print(b);
    print(b.toStringAsFixed(1)); // double => string
}
```

#### Booleans
> `Dart` 中只有 `true` 被认为是 `true`, 其他都是 `false`; 开发者应该显式地判断

```dart
void main () {
    var num = 0.1 + 0.2;
    var str = ''
    var nullVal
    var n = 100 / 0;
    print(num.isNaN);
    print(str.isEmpty);
    print(nullVal == null);
    print(n.isNaN);
}
```

#### List
```dart
void main () {
    var arr = const[1,2,3];
    arr.add(4); // Error, arr 是一个编译时常量
    print(arr);
}
```

#### Map
> `Map` 的键和值都是任意类型

```dart
void main () {
    const map = {
        'name': 'sven',
        'age': 17.5
        123: 456
    }
    print(map);
}
```

#### Runes
> `Runes` 代表字符串的 `UTF-32 code points`; 使用 `\uXXXX` / `\u{XXXX}` 表示

#### Functions
```dart
// 箭头函数
isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
```

可选命名参数
```dart
void method ({String title, double size, bool debug = true}) {
    print('title: ${title}');
    print('size: ${size}');
    print('debug: ${debug}');
}

void main () {
    method(title: 'Hello', size: 200.0);
}
```

可选位置参数
```dart
method('Hello');
method('Hello', 200);
```

```dart
void method (title, [size]) {
    // ...
}
```

级联调用: *在一个对象上执行多个操作*
```dart
void main() {
    querySelector("#sample_text_id")
        ..text = "Click me!"
        ..onClick.listen(reverseText);
}
```


