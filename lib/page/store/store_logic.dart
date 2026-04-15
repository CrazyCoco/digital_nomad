import 'package:get/get.dart';

class StoreLogic extends GetxController {
  int selectedTab = 3;
  
  @override
  void onReady() { super.onReady(); }
  @override
  void onClose() { super.onClose(); }
  
  void selectTab(int index) { 
    selectedTab = index;
    update();
  }
}
