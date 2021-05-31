intl_util
====
这个包提供了从Intl包的翻译消息提取和代码生成。

这个包是基于“intl_translation”，并进行了轻微的修改，使之可以兼容大多数flutter项目环境。

## 提取和使用翻译后的消息

当您的程序包含需要翻译的消息时，您必须从程序源中提取它们，将它们发送给人工翻译人员，并合并结果。

以下所有命令均在flutter项目的根目录下运行(使用的git bash命令行工具做测试)
```
// 提取信息
flutter pub pub run intl_util:extract_to_arb --output-dir=i18n-arb lib/i18n/localization_intl.dart
```

这将在i18n-arb目录下生成"**intl_messages.Arb**"文件，这是一个[ARB][ARB]格式文件。
intl_messages.Arb内容是增量添加的，所以不需要担心上次的内容被清空。

下一步就是我们自己把intl_messages.Arb文件翻译为多个副本保存到项目根目录/i10n-arb下
例如：

```
/i10n-arb/intl_zh_CN.arb
/i10n-arb/intl_ar_SA.arb
/...
```
这里提供一个方便的工具使用：https://download.csdn.net/download/z_ml118/19269525

翻译文件准备完毕之后，接着执行如下命令
```
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n --no-use-deferred-loading lib/i18n/localization_intl.dart i10n-arb/intl_*.arb
```
这将在lib/i18n目录下生成多个语言版本的dart文件，例如：

```
lib/i18n/intl_zh_CN.dart
lib/i18n/intl_ar_SA.dart
/...
```
每个区域都会有一个对应的dart文件，其中包含已翻译的版本。您的程序中可以导入名为`<prefix>messages_all.dart`的主文件，然后调用特定区域设置的初始化。完成后，在该区域设置的上下文中进行的任何[Intl.message][Intl.message]调用都将自动打印翻译后的版本。

```
import "my_prefix_messages_all.dart";
...
initializeMessages("dk").then(printSomeMessages);
```


一旦从初始化调用返回的Future完成，消息数据就可用了。
