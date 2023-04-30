import 'package:flutter/material.dart';
import 'package:heyy/controllers/controllers.dart';
import 'package:heyy/pages/login/screens/login_screen.dart';
import 'package:heyy/pages/login/screens/login_screen_wide.dart';
import 'package:heyy/pages/login/screens/otp_screen.dart';
import 'package:heyy/pages/login/screens/user_setup_screen.dart';
import 'package:heyy/responsivelayout.dart';

import '../../common/common.dart';

class LoginPage extends StatelessWidget with AppMixin {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('here in login');
    return const Scaffold(
      body: ResponsiveLayout(
        wide: LoginNarrowLayout(),
        mobile: LoginNarrowLayout(),
      ),
    );
  }
}

class LoginNarrowLayout extends StatelessWidget with AppMixin {
  const LoginNarrowLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (snc.loginView.value) {
      case LoginView.otpView:
        return const OTPScreen();
      case LoginView.userSetupView:
        return const UserSetupScreen();
      default:
        return const LoginScreen();
    }
  }
}

class LoginWideLayout extends StatelessWidget with AppMixin {
  const LoginWideLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginScreenWide();
  }
}
