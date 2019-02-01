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

## 操作符

- `is` 类型判断
```dart
if (user is Person) {
    user.firstName = 'Bob
}
```

- `as` 类型转换
```dart
(user as Person).firstName = 'Bob'
```

- `??=` 赋值操作符
```dart
const DEFAULT_VAL = 0;
val ??= DEFAULT_VAL; // val == null 时将其赋值为 DEFAULT_VAL
```

- `??` null 合并运算符
```dart
String toString() => msg ?? super.toString(); // msg == null 则返回 super.toString()
```

- `?.` 条件成员访问
```dart
foo.bar(); // foo == null 时抛出异常
foo?.bar(); // foo == null 时返回 null
```

## 异常
> `Dart` 提供了 `Exception` 和 `Error` 两种异常类型, 可以抛出非 `null` 的所有类型的异常

```dart
throw 'error messages ...';
```

- `catch`

```dart
try {
    // ...
} on OutOfLlamasException {
    // 只捕获 OutOfLlamasException 类型异常
} on Exception catch (e) {
    // 捕获 Exception 类型异常
    print('Unknow Expection: $e');
} catch (e, s) {
    // 捕获所有异常: e 为异常对象, s 为堆栈信息 StackTrace 对象
    rethrow; // 将捕获的异常重新抛出
}
```

## Classes
> `Dart` 是一个基于 `Mixins` 的面向对象的编程语言

### 构造函数
- 如果未定义构造函数, 会调用超类的没有参数的构造函数
- 子类不会继承超类的构造函数
- 执行顺序
    1. 初始化参数列表
    2. 超类的无名构造函数
    3. 主类的无名构造函数

```dart
class Point {
    num x; // initially null
    num y = 7;
    num get total => x + y;
    num set total(num val) => print(val);
    Point (this.x, this.y); // 通过语法糖设置成员变量
    // 命名构造函数
    Point.fromJson(Map<String, int> json) {
        x = json['x'];
        y = json['y'];
    }
    // 初始化列表, 表达式无法访问 this
    Point.formJson2(Map<String, num> json) : x = json['x'], y = json['y'] {
        print('In Point.formJson2(): ($x, $y)');
    }
    // 重定向构造函数
    Point.alongXAxis(num x) : this(x, 0);
}

// 超类中没有无名构造函数时需要手动调用超类构造函数
class Foo extends Point {
    Foo (num x, num y) : super (x, y) {
        print('in Foo');
    }
}
```

使用初始化列表初始化 `final` 实例属性

```dart
class Point {
    final num x; // initially null
    final num y;
    Point (x, y) : x = x, y = y;
}

void main() {
    var point = new Point(123, 345);
    print(point);
}
```

通过常量构造函数创建一个状态不变的对象, 需要定义一个 `const` 构造函数并声明所有成员变量为 `final`

```dart
class ImmutablePoint {
    final num x;
    final num y;
    const ImmutablePoint(this.x, this.y);
}
```

- [隐式接口](http://dart.goodev.org/guides/language/language-tour#implicit-interfaces%E9%9A%90%E5%BC%8F%E6%8E%A5%E5%8F%A3), 如果要创建类 `A` 实现类 `B` 的接口而不继承 `B` 的实现, 可以使用 `implements` 实现一个或多个接口
- [工厂函数](http://dart.goodev.org/guides/language/language-tour#factory-constructors%E5%B7%A5%E5%8E%82%E6%96%B9%E6%B3%95%E6%9E%84%E9%80%A0%E5%87%BD%E6%95%B0)
- [复写操作符](http://dart.goodev.org/guides/language/language-tour#overridable-operators%E5%8F%AF%E8%A6%86%E5%86%99%E7%9A%84%E6%93%8D%E4%BD%9C%E7%AC%A6)

## 枚举

```dart
enum Colors {
    Red,
    Green,
    Blue
}
void main () {
    const List<Colors> colors = Colors.values;
    print(colors); // [Colors.Red, Colors.Green, Colors.Blue]
}
```

## 泛型
```dart
T first<T>(List<T> ts) {
    T tmp;
    tmp ??= ts[0];
    return tmp;
}
void main() {
    print(first([1, 2]));
}
```

## 延迟载入库
> 使用库标识符的 `loadLibrary()` 来加载库

```dart
import 'package:deferred/hello.dart' deferred ad hello;

greet() async {
    await hello.loadLibrary();
}
```

## 可当做函数调用的类
```dart
class Point {
    call(int x, int y) => '$x, $y';
}
void main () {
    Point p = new Point();
    print(p(1, 2));
}
```

## typedef 方法类型别名

```dart
typedef int Calc(int x, int y);

int add (int x, int y) => x + y;

void main () {
    print(add is Calc);
}
```

## [元数据](http://dart.goodev.org/guides/language/language-tour#metadata%E5%85%83%E6%95%B0%E6%8D%AE)



