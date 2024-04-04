import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

initFirebase() async {
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
}

// FCM Foreground 설정
_setFCMForgroundListeners(
  RemoteMessage message,
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  AndroidNotificationChannel? channel,
) async {
  log('Got a message whilst in the foreground!', name: 'FCM');
  log('Message data: ${message.data}', name: 'FCM');

  if (message.notification != null) {
    log('Message title: ${message.notification!.title}', name: 'FCM');
    log('Message body: ${message.notification!.body}', name: 'FCM');

    try {
      flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.notification?.title,
        message.notification?.body,
        NotificationDetails(
          android: channel != null
              ? AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: '@mipmap/launcher_icon',
                  actions: [
                    const AndroidNotificationAction(
                      'open',
                      '열기',
                    ),
                  ],
                )
              : null,
          iOS: const DarwinNotificationDetails(
            // badgeNumber: 1,
            // subtitle: 'the subtitle',
            sound: 'slow_spring_board.aiff',
          ),
        ),
        payload: '${message.data['category']},${message.data['value']}',
      );
    } catch (error) {
      log('error: $error', name: 'FCM');
    }
  }
}

// FCM Background 설정
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  log("Handling a background message: ${message.messageId}", name: 'FCM');
}

setFCM() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel? androidNotificationChannel;

  flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ),
    onDidReceiveNotificationResponse: (details) {
      log('onDidReceiveNotificationResponse: ${details.payload}', name: 'FLN');
    },
  );

  if (Platform.isAndroid) {
    //Android 8 (API 26) 이상부터는 채널설정이 필수.
    androidNotificationChannel = const AndroidNotificationChannel(
      'wckc_high_importance_channel', // id
      'WCKC High Importance Notifications', // name
      importance: Importance.high,
      enableVibration: true,
      showBadge: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  //Background Handling 백그라운드 메세지 핸들링
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //Foreground Handling 포어그라운드 메세지 핸들링
  FirebaseMessaging.onMessage.listen((message) {
    _setFCMForgroundListeners(message, flutterLocalNotificationsPlugin, androidNotificationChannel);
  });
  // When the app is terminated
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    log("getInitialMessage: ${initialMessage.messageId}", name: 'FCM');
    // iOS : terminated
    // Android : terminated
  }

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    log("onMessageOpenedApp: ${message.messageId}", name: 'FCM');
    // iOS : background, forground, terminated
    // Android : background, terminated
  });
}
