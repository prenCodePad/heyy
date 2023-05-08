import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:heyy/config/storage_prefs.dart';
import 'package:heyy/routing/routes.dart';
import 'package:heyy_backend/heyy_backend.dart';

import '../config/config.dart';
import '../controllers/controllers.dart';

mixin AppMixin {
  AppSizes get sizes => GetIt.I<AppSizes>();
  AppTheme get theme => GetIt.I<AppTheme>();
  SignInController get snc => Get.put(SignInController());
  LoginRepo get loginRepo => LoginRepoImpl();

  Future<void> logoutUser() async {
    await loginRepo.updateUser(
        StoragePrefs.getStorageValue('id'), {'isOnline': false, 'lastSeen': DateTime.now().millisecondsSinceEpoch});
    StoragePrefs.setStorageValue('loggedIn', false);
    StoragePrefs.setStorageValue('id', null);
    StoragePrefs.setStorageValue('phone', null);

    await FirebaseAuth.instance.signOut();
    Get.offAndToNamed(Routes.loginPage);
  }
}
