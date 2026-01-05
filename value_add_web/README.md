# value_add_web

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
关于多语言
- 多语言通过`lib/common/app_translations.dart`来实现，内部的`AppTranslations`类的`key` map返回了所有支持的多语言翻译
- 使用时可以通过`'字符串'.tr`方式来生成

关于图片资源
- 所有的图片资源放置于`assets/images/`目录下，且只保存3x的图，但不要有3x的命名
- 图片放到对应目录后，需要运行`dart run build_runner build`后，会自动在`lib/assets/assets.gen.dart`生成对应的属性，代码中可通过`Assets.images.userLogo.image()`来生成一个Image Widget

项目启动
- flutter run -d chrome --web-port 8080 --web-hostname 0.0.0.0
- flutter run -d chrome --web-port 8080
生成vasApi.g.dart
- # 生成代码（--delete-conflicting-outputs 用于解决文件冲突）
flutter pub run build_runner build --delete-conflicting-outputs