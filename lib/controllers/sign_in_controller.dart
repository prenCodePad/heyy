import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heyy_backend/heyy_backend.dart';

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
    return await AuthUsingPhone.verify(otp.value, codeController.text);
  }

  Future<void> getOtp({required void Function(PhoneAuthCredential) onComplete}) async {
    print(phoneNo.value);
    otp.value = await AuthUsingPhone.login('+91${phoneNo.value}') ?? '';
    print('OTP ${otp.value}');
  }
}
