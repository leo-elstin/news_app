# News App
Please Note :

```sh
flutter --version

Flutter 2.0.1 • channel stable • https://github.com/flutter/flutter.git
Framework • revision c5a4b4029c (4 weeks ago) • 2021-03-04 09:47:48 -0800
Engine • revision 40441def69
Tools • Dart 2.12.0
```
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

## Development
To build and run this project:

1. Get Flutter [here](https://flutter.dev) if you don't already have it
2. Clone this repository.
3. `cd` into the repo folder.
4. run `flutter packages pub run build_runner build`
4. run `flutter run`
