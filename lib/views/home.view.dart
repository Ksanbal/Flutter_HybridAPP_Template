import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hybridapp_template/components/webview.comp.dart';
import 'package:flutter_hybridapp_template/controllers/home.controller.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // 상단 스테이터스바 노출
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );

    return Container(
      color: Colors.white,
      child: SafeArea(
        // top: false, // 상단 safearea 설정
        bottom: false, // 하단 safearea 설정
        child: WebViewComp(
          initialUrl: controller.initialUrl,
          jsInterface: controller.jsInterface,
          // 로딩창
          onLoadWidget: Container(
            color: Colors.white.withOpacity(0.1),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
