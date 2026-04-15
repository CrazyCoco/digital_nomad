import 'dart:developer';

import 'package:bmob_plugin/bmob/bmob.dart';
import 'package:bmob_plugin/bmob/response/bmob_error.dart';
import 'package:bmob_plugin/bmob/table/bmob_user.dart';
import 'package:digital_nomad/page/login_index/login_index_view.dart';
import 'package:digital_nomad/page/onboarding/onboarding_view.dart';
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

    Get.offAll(() {
      return hasCompletedOnboarding
          ? const LoginIndexPage()
          : const OnboardingPage();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
