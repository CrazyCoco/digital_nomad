import 'package:bmob_plugin/bmob/bmob.dart';
import 'package:digital_nomad/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LogoLogic extends GetxController {
  @override
  void onReady() {
    initAppConfig();
    setHome();
    super.onReady();
  }

  void initAppConfig() {
    Bmob.initialize(
      "9a214828ff2228b14cc7a791eb01441b",
      "6a24d8ee39b0cddf2035983fd64d90b4",
    );

    // BmobUser bmobUserRegister = BmobUser();
    // bmobUserRegister.username = "123456@ss.com";
    // bmobUserRegister.password = "1234567890";
    // bmobUserRegister
    //     .login()
    //     .then((BmobUser bmobUser) {
    //       log("${bmobUser.getObjectId()}\n${bmobUser.username ?? ''}");
    //     })
    //     .catchError((e) {
    //       log(BmobError.convert(e)?.error ?? "");
    //     });
  }

  void setHome() {
    final box = GetStorage();
    final hasCompletedOnboarding = box.read('onboarding_completed') ?? false;

    if (hasCompletedOnboarding) {
      NavigationUtil.toLoginIndex();
    } else {
      NavigationUtil.toOnboarding();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
