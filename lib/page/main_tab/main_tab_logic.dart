import 'package:get/get.dart';

class MainTabLogic extends GetxController {
  int selectedIndex = 0;
  
  void selectTab(int index) {
    selectedIndex = index;
    update();
  }
}
