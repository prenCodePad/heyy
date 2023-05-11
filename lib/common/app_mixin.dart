import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:heyy/config/storage_prefs.dart';
import 'package:heyy/controllers/chat_controller.dart';
import 'package:heyy/routing/routes.dart';
import 'package:heyy_backend/heyy_backend.dart';

import 'package:encrypt/encrypt.dart';

import '../config/config.dart';
import '../controllers/controllers.dart';

mixin AppMixin {
  AppSizes get sizes => GetIt.I<AppSizes>();
  AppTheme get theme => GetIt.I<AppTheme>();
  SignInController get snc => Get.put(SignInController());
  LoginRepo get loginRepo => LoginRepoImpl();
  ChatRepo get chatRepo => ChatRepoApi();
  String initials(String name) => '${name[0]}${name[1]}';
  DateTime today(DateTime now) => DateTime(now.year, now.month, now.day);
  DateTime yesterday(DateTime now) => DateTime(now.year, now.month, now.day - 1);
  DateTime aDate(DateTime date) => DateTime(date.year, date.month, date.day);
  DateTime convertDateTime(int epoch) => DateTime.fromMicrosecondsSinceEpoch(epoch * 1000);
  /*WSTTheme get theme => GetIt.I<WSTTheme>();  have to bring in GetIt for Singleton
  Initialisations*/

  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String hours(Duration duration) => twoDigits(duration.inHours);
  String minutes(Duration duration) => twoDigits(duration.inMinutes.remainder(60));
  String seconds(Duration duration) => twoDigits(duration.inSeconds.remainder(60));

  //32 chars
  IV get iv => IV.fromUtf8('put16characters!'); //16 chars

//encrypt
  String encrypt(String text) {
    final key = Key.fromUtf8('put32charactershereeeeeeeeeeeee!');
    final e = Encrypter(AES(key, mode: AESMode.cbc));
    return e.encrypt(text, iv: iv).base64;
  }

//dycrypt
  String decrypt(String text) {
    final key = Key.fromUtf8('put32charactershereeeeeeeeeeeee!');
    final e = Encrypter(AES(key, mode: AESMode.cbc));
    return e.decrypt(Encrypted.fromBase64(text), iv: iv);
  }

  Future<void> logoutUser() async {
    await loginRepo.updateUser(StoragePrefs.getStorageValue('id'), {
      'isOnline': false,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    });
    StoragePrefs.setStorageValue('loggedIn', false);
    StoragePrefs.setStorageValue('id', null);
    StoragePrefs.setStorageValue('phone', null);
    await FirebaseAuth.instance.signOut();
    Get.delete<SignInController>();
    Get.delete<ChatController>();
    Get.delete<HomeController>();
    Get.offAllNamed(Routes.loginPage);
  }
}
