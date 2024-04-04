import 'dart:developer';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final initialUrl = 'https://flutter.dev';

  // js Interface
  jsInterface(InAppWebViewController controller) {
    // 특정 이벤트 핸들러
    controller.addJavaScriptHandler(
      handlerName: 'eventHandler',
      callback: (args) {
        log(args.toString(), name: 'jsInterface');

        return {};
      },
    );
  }
}
