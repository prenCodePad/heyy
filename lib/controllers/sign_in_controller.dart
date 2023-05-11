import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heyy/config/storage_prefs.dart';
import 'package:heyy_backend/heyy_backend.dart';
import 'package:uuid/uuid.dart';

enum LoginView { loginView, otpView, userSetupView }

class SignInController extends GetxController {
  final isLoggedIn = false.obs;
  final phoneNo = ''.obs;
  final userName = ''.obs;
  final user = Rxn<Map<String, dynamic>>();
  final otp = ''.obs;
  final setupLoader = false.obs;

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  final LoginRepo _loginRepo = LoginRepoImpl();

  @override
  void onInit() {
    if (StoragePrefs.getStorageValue('loggedIn') ?? false) {
      getUser();
    }
    super.onInit();
  }

  @override
  void dispose() {
    phoneController.dispose();
    nameController.dispose();
    codeController.dispose();
    super.dispose();
  }

  updateIsLoggedIn(bool b) => isLoggedIn.value = b;
  onPhoneNumberChanged(String no) => phoneNo.value = no;
  onUserNameChanged(String name) => userName.value = name;

  Future<bool> loginUser() async {
    return await AuthUsingPhone.verify(otp.value, codeController.text);
  }

  Future<void> getOtp({required void Function(PhoneAuthCredential) onComplete}) async {
    await AuthUsingPhone.login(
      phoneNo.value,
      codeSent: (id, resendToken) {
        otp.value = id;
      },
      codeAutoRetrievalTimeout: (id) {
        otp.value = id;
      },
    );
  }

  Future<void> setUser() async {
    setupLoader.value = true;
    var uuid = const Uuid().v4();
    var id = FirebaseAuth.instance.currentUser?.uid ?? uuid;
    var data = {'id': id, 'name': nameController.text, 'phone': phoneNo.value, 'isOnline': true, 'lastSeen': 0};
    await _loginRepo.setUser(id, data).then((value) {
      StoragePrefs.setStorageValue('loggedIn', true);
      StoragePrefs.setStorageValue('id', id);
      StoragePrefs.setStorageValue('phone', phoneNo.value);
      StoragePrefs.setStorageValue('name', nameController.text);
      user.value = data;
    });
    setupLoader.value = false;
  }

  Future<bool> getUser() async {
    try {
      var data = await _loginRepo.getUserWithPhone(phoneNo.value).then((v) {
        if (v.isNotEmpty) {
          StoragePrefs.setStorageValue('loggedIn', true);
          StoragePrefs.setStorageValue('id', v['id']);
          StoragePrefs.setStorageValue('phone', phoneNo.value);
          StoragePrefs.setStorageValue('name', v['name']);
          userName.value = v['name'];
          phoneNo.value = v['phone'];
          user.value = v;
        }
        return v;
      });
      return data.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
