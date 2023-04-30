import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heyy/config/config.dart';

class GetItRegistration {
  static Future<void> init() async {
    GetIt.I.allowReassignment = true;
    await GetStorage.init();
    GetIt.I.registerSingleton<AppSizes>(AppSizes(), signalsReady: true);
    AppSizes sizes = AppSizes();
    GetIt.I.registerSingleton<AppSizes>(sizes);
    GetIt.I.registerSingleton<AppTheme>(AppTheme(sizes: sizes));
  }
}
