import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_management/repositories/firebase_repo/firebase_repo.dart';
import 'package:state_management/repositories/firebase_repo/firebase_storage_repo.dart';
import 'package:state_management/screens/login/bloc/login_bloc.dart';
import 'package:state_management/utils/helper/shared_pref_controller.dart';

class DependencyInjection {
  late final sharedPreference;
  GetIt getIt = GetIt.instance;
  void init() async {
    sharedPreference = await SharedPreferences.getInstance();
    await initializeSingleton();
  }

  initializeSingleton() async {
    getIt.registerSingleton<SharedPrefController>(
        SharedPrefController(sharedPreference));
    getIt.registerSingleton<FirebaseStorageService>(FirebaseStorageService());
    getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
    getIt.registerFactory<LoginBloc>(
        () => LoginBloc(getIt<FirebaseAuthService>()));
  }
}
