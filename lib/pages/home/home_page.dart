import 'package:flutter/material.dart';
import 'package:heyy/responsivelayout.dart';

import '../../common/common.dart';
import '../pages.dart';

class MyHomePage extends StatelessWidget with AppMixin {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: GestureDetector(onTap: () => FocusScope.of(context).unfocus(), child: const HomeNarrowLayout()),
        wide: const HomeWideLayout(),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: hc.updateCounter,
      //   tooltip: 'Increment',
      //   foregroundColor: Colors.white,
      //   backgroundColor: const Color(0xff1BD7BB),
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HomeNarrowLayout extends StatelessWidget with AppMixin {
  const HomeNarrowLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

class HomeWideLayout extends StatelessWidget with AppMixin {
  const HomeWideLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeScreenWide();
  }
}
