# News App

#### Download : [apk](https://github.com/leoelstin/news_app/raw/master/apk/app-release.apk)
## Features

- BLoc For state management
- Offline presistant with Hive
- Persist data for headlines
- View Interest over time as graph view
- Auto refresh news every 30 seconds
- ability to turn on/off auto refresh

## Plugins used

The Followinf first party plugins are used

| Plugin | README |
| ------ | ------ |
| [Hive](https://pub.dev/packages/hive) | For keeping the data locally |
| [Flutter Bloc](https://pub.dev/packages/flutter_bloc) | For State Management and Bloc Pattern |
| [timeAgo](https://pub.dev/packages/timeago) | A library useful for creating fuzzy timestamps. (e.g. "5 minutes ago") |
| [intl](https://pub.dev/packages/intl) | For Date formating |
| [connectivity](https://pub.dev/packages/connectivity) | to discover network connectivity |
| [syncfusion_flutter_charts](https://pub.dev/packages/syncfusion_flutter_charts) | For interactive charts |

Please Note :
```sh
flutter doctor -v
[✓] Flutter (Channel stable, 2.0.1, on macOS 11.0.1 20B50 darwin-x64, locale en-GB)
    • Flutter version 2.0.1 at /Users/leoelstin/Documents/SDK/flutter
    • Framework revision c5a4b4029c (4 weeks ago), 2021-03-04 09:47:48 -0800
    • Engine revision 40441def69
    • Dart version 2.12.0

[✓] Android toolchain - develop for Android devices (Android SDK version 30.0.2)
    • Android SDK at /Users/leoelstin/Library/Android/sdk
    • Platform android-30, build-tools 30.0.2
    • Java binary at: /Applications/Android Studio.app/Contents/jre/jdk/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 1.8.0_242-release-1644-b3-6915495)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Xcode 12.2, Build version 12B45b
    • CocoaPods version 1.10.0.beta.2

[✓] Chrome - develop for the web
    • Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

[✓] Android Studio (version 4.1)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 1.8.0_242-release-1644-b3-6915495)

[✓] VS Code (version 1.54.3)
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension can be installed from:
      🔨 https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter

[✓] Connected device (3 available)
    • Redmi Note 5 Pro (mobile) • bb86d8a6                             • android-arm64  • Android 10 (API 29)
    • iPhone 11 (mobile)        • 67EDE6E9-45EB-4162-B856-67F48B17D454 • ios            • com.apple.CoreSimulator.SimRuntime.iOS-14-2 (simulator)
    • Chrome (web)              • chrome                               • web-javascript • Google Chrome 89.0.4389.114
    ! Error: Leyo’s iPhone is not connected. Xcode will continue when Leyo’s iPhone is connected. (code -13)

• No issues found!

```
## Development
To build and run this project:

1. Get Flutter [here](https://flutter.dev) if you don't already have it
2. Clone this repository.
3. `cd` into the repo folder.
4. run `flutter packages pub run build_runner build`
4. run `flutter run`
