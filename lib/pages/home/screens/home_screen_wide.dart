import 'package:flutter/material.dart';
import 'package:heyy/common/app_mixin.dart';
import 'package:heyy/controllers/home_controller.dart';
import 'package:heyy/routing/routes.dart';
import 'package:get/get.dart';

class HomeScreenWide extends StatelessWidget with AppMixin {
  const HomeScreenWide({Key? key}) : super(key: key);
  HomeController get hc => Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Obx(() {
                return Text(
                  '${hc.counter.value}',
                  style: Theme.of(context).textTheme.headline4,
                );
              }),
            ],
          ),
        ),
        Positioned(
            child: IconButton(
                padding: const EdgeInsets.only(right: 30),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.loginPage);
                  logoutUser();
                },
                icon: const Icon(Icons.person, size: 50)))
      ],
    );
  }
}
