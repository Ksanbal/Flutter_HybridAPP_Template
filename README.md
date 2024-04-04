# Flutter Hybidapp Template

Flutter를 사용한 하이브리드앱 개발을 위한 템플릿입니다.

- Versions
  - flutter 3.19.5 (fvm 설정)
  - flutter_inappwebview 6.0.0

## FVM 설정

- [Sidekick 설치](https://github.com/fluttertools/sidekick/
  releases)
- `.fvm/fvm_config.json`에 작성된 `"flutterSdkVersion": "3.19.5"` 버전으로 다운로드

## Bundle id 설정

### Android

- SEARCH에 `com.example.flutter_hybridapp_template`을 원하는 Bundle ID로 변경

### iOS

- SEARCH에 `com.example.flutterHybridappTemplate`을 원하는 Bundle ID로 변경

## App Label(앱이름)

### Android

- `android/app/src/main/AndroidManifest.xml`에서 `android:label="flutter_hybridapp_template"`을 변경

### iOS

- Xcode `Runner/General/Display Name`을 변경

## Splash Screen 변경

- `flutter_native_splash.yaml` 파일에 설정 파일 작성
- `dart run flutter_native_splash:create`
- [pub.dev](https://pub.dev/packages/flutter_native_splash)

## App icon 변경

- `flutter_launcher_icons.yaml` 파일에 설정 파일 작성
- `assets/` 폴더 하위에 app icon 위치
- `flutter pub run flutter_launcher_icons`
- [pub.dev](https://pub.dev/packages/flutter_launcher_icons)

## WebView 설정

- index url : `lib/controllers/home.controller.dart`의 `initialUrl` 변경
- js interface
  - `lib/controllers/home.controller.dart`의 `jsInterface`함수에 로직 생성
  - `handlerName` : 웹에서 호출할 event 네임
  - `callback`에서 `return`으로 데이터를 반환할 수 있음

## PUSH 설정

- APN 발급 및 service 사용 등록
- 앱 심사는 기능 허용만으로 통과 가능

## Firebase, FCM 설정

- [Fiebase docs](https://firebase.google.com/docs/flutter/setup?hl=ko)
- `firebase_options.dart`가 생성되면 `main.dart`에서 코드 주석 제거
