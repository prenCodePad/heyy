import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:heyy/config/push_notification_service.dart';
import 'package:heyy/pages/home/home_page.dart';

class PushNotificationEvents {
  static Future<void> init() async {
    FirebaseMessaging.onMessage.listen((message) async {
      print('Push Notification recieved');
      LocalNotificationService.display(message);
    });

    ///Gets called when the app is background/terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      LocalNotificationService.display(message!);
    });

    ///Gets called when user taps on the notification, when the app is background/terminated state
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Get.to(const MyHomePage(title: ''));
    });
  }
}
