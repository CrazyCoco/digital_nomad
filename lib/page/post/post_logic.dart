import 'package:get/get.dart';

class PostLogic extends GetxController {
  String content = '';
  int selectedTab = 0;
  
  final List<String> images = [];
  
  @override
  void onReady() { super.onReady(); }
  @override
  void onClose() { super.onClose(); }
  
  void updateContent(String value) {
    content = value;
    update();
  }
  
  void addImage() {
    // TODO: Implement image picker
    images.add('placeholder');
    update();
  }
  
  void removeImage(int index) {
    images.removeAt(index);
    update();
  }
  
  void selectTab(int index) { 
    selectedTab = index;
    update();
  }
  
  void post() {
    // TODO: Implement post logic
  }
}
