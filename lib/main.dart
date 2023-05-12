//Author Praveen Pilli.

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:heyy/config/get_it_registrations.dart';
import 'package:heyy/config/push_notification_events.dart';
import 'package:heyy/config/push_notification_service.dart';
import 'package:heyy/routing/route_generator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setPathUrlStrategy();
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  FirebaseMessaging.instance.requestPermission(alert: true, badge: true, sound: true);
  LocalNotificationService().initialize();
  GetItRegistration.init().then((v) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PushNotificationEvents.init();
  }

  @override
  Widget build(BuildContext context) {
    var defaultLocale = const Locale('en', 'US');
    return ScreenUtilInit(
        builder: (_, p) => GetMaterialApp(
            title: 'Heyy',
            builder: (context, child) {
              return MediaQuery(
                child: child!,
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              );
            },
            theme: ThemeData(primarySwatch: Colors.blue),
            fallbackLocale: defaultLocale,
            onGenerateRoute: RouteGenerator.generateRoute));
  }
}
