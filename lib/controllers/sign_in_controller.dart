import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LoginView { loginView, otpView, userSetupView }

class SignInController extends GetxController {
  final isLoggedIn = false.obs;
  final phoneNo = ''.obs;
  final userName = ''.obs;
  final loginView = LoginView.loginView.obs;
  final otp = ''.obs;

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  updateIsLoggedIn(bool b) => isLoggedIn.value = b;
  onPhoneNumberChanged(String no) => phoneNo.value = no;
  onUserNameChanged(String name) => userName.value = name;

  Future<bool> loginUser() async {
    bool login = false;
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(verificationId: otp.value, smsCode: codeController.text))
        .then((value) {
      if (value.user != null) {
        login = true;
      }
    });
    return login;
  }

  getOtp({required void Function(PhoneAuthCredential) onComplete}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${phoneNo.value}',
        verificationCompleted: onComplete,
        verificationFailed: (e) => print(e.message),
        codeSent: (id, resend) {
          otp.value = id;
        },
        codeAutoRetrievalTimeout: (_) {});
  }
}
