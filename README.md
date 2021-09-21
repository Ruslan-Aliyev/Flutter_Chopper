# Flutter Chopper

Chopper is used for HTTP requests in Flutter.

Chopper is the equivalent of Android's RetroFit.

Chopper is at a higher level than HTTP and DIO.

## Tutorials

- https://resocoder.com/2019/06/19/chopper-retrofit-for-flutter-basics/
- https://www.raywenderlich.com/10099546-elegant-networking-in-flutter-with-chopper

## Background knowledge

On top of Chopper, some other stuff are alos used in this tutorial, which is better to have basic knowledge of.

### `InheritedWidget`

For easy passage of data from ancestor class to distant-descendant classes.

- https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html

### `Provider`

A wrapper around `InheritedWidget` to make them easier to use.

- https://pub.dev/packages/provider
- https://www.youtube.com/watch?v=K2ampPUTfIQ

### `FutureBuilder` vs `Future`

Flutter’s Dart uses Future Objects to present the results of Asynchronous operations. With Dart’s Future, developers can manage IO without worrying about deadlocks.

FutureBuilder is a widget by Flutter which lets you easily determine the current state of the Future and choose what to show during that state.

- https://walkingtree.tech/futurebuilder-flutter-widget/

### Auth

- https://resocoder.com/2019/06/19/chopper-retrofit-for-flutter-basics/#t-1632229847628

## Potential problems

It's been a while since that tutorial was made. Here are some problems you may encounter if you do it now

### Version incompatibility in regards to Analyzer

- https://github.com/dart-lang/sdk/issues/46687#issuecomment-890667190
- https://stackoverflow.com/questions/63315588/dart-sdk-version-mismatch-while-installing-build-runner/63315768#63315768

Solution
```
dependency_overrides:
  analyzer: 1.7.2
```

### Old Provider syntax

Update
```dart
Provider(
      builder: (_) => PostApiService.create(),
```
to
```dart
Provider(
      create: (_) => PostApiService.create(),
```

### Old Provider error

`Error: The method 'dependOnInheritedWidgetOfExactType' isn't defined for the class 'BuildContext'`

Solution: The general idea is to update `Provider`. Here I explicitly specified a newer version of `Provider`:
```
dependencies:
  provider: ^5.0.0
```

- https://stackoverflow.com/questions/59359741/error-the-method-dependoninheritedwidgetofexacttype-isnt-defined-for-the-cla/66567365#66567365
- https://stackoverflow.com/questions/65749767/error-the-method-inheritfromwidgetofexacttype-isnt-defined-for-the-class-bu/66092545#66092545
    - https://www.flutterclutter.dev/flutter/basics/flutter-channels/2020/860/

#### Check

It may be worth it to start by writing a simple code to check that `Provider` have no problems in your setup.

`main.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => Text('Testing'), // <----- Focus here
      child: MaterialApp(
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}
```

`home_page.dart`
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer'; // <----- Focus here

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text = Provider.of<Text>(context); // <----- Focus here
    log('text: ', error: text.data); // <----- Focus here
    return Scaffold(
      appBar: AppBar(
        title: Text('Chopper Blog'),
      ),
    );
  }
}
```

If that runs without any errors, then you are good to continue without worrying about `Provider` issues.

### Null Safety

That old tutorial is just for introduction. It doesn't take care of null safety very well.
If you are using newer versions of Flutter SDK or have null safety enabled, then it will get in the way of following that tutorial.

Solution: Disable null safety:

One way is to use older SDKs `>=2.11.0`:
```
environment:
  sdk: ">=2.11.0 <3.0.0"
```

- https://www.youtube.com/watch?v=w6WqqFGP_Ck

### Other Errors

- `dependOnInheritedElement() was called before initstate()`: https://stackoverflow.com/questions/60363665/dependoninheritedelement-was-called-before-initstate-in-flutter

---

---

# chopper

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
