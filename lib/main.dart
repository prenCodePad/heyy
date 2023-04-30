//Author Praveen Pilli.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:heyy/config/get_it_registrations.dart';
import 'package:heyy/routing/route_generator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  print('Here');
  setPathUrlStrategy();
  GetItRegistration.init().then((v) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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