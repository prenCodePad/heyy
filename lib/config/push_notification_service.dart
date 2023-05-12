import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart' as local;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  static final navigatorKey = GlobalKey<NavigatorState>();

  void initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        macOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    await _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void onDidReceiveLocalNotification(int? id, String? title, String? body, String? payload) {
    stopNotificationSound();
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    var msg = jsonDecode(payload ?? "");
    handleMessage(msg);
  }

  static void handleMessage(Map<String, dynamic> message) {
    print("local notification service message is $message");
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      var androidPlatformChannelSpecifics = const local.AndroidNotificationDetails('heyy_channel', "heyy_channel",
          importance: local.Importance.high,
          priority: local.Priority.high,
          //  sound: RawResourceAndroidNotificationSound('ringtone'),
          playSound: true,
          ongoing: true,
          icon: '@mipmap/ic_launcher',
          visibility: NotificationVisibility.public,
          timeoutAfter: 28000);

      var iOSPlatformChannelSpecifics = const local.DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        sound: 'ringtone.caf',
        presentSound: true,
      );
      // FlutterRingtonePlayer.play(fromAsset: "assets/sounds/cafe.caf");
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(const AndroidNotificationChannel(
            'wst_channel',
            "wst channel",
            importance: local.Importance.high,
            sound: RawResourceAndroidNotificationSound('ringtone'),
            playSound: true,
          ));

      var platformChannelSpecifics =
          local.NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
      print("Message ${message}   ${message.data}  ${message.toMap().toString()}");
      if (Platform.isAndroid) {
        await _notificationsPlugin.show(
          id,
          message.notification?.title,
          message.notification?.body,
          platformChannelSpecifics,
          payload: message.toMap().toString(),
        );
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static void stopNotificationSound() {
    _notificationsPlugin.cancelAll();
  }
}
