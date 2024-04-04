import 'package:flutter/material.dart';
import 'package:flutter_hybridapp_template/app.dart';
import 'package:flutter_hybridapp_template/common/utiles/firebase.dart';

void main() async {
  // Firebase init 설정
  // initFirebase();

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());

  // FCM 설정
  // setFCM();
}
