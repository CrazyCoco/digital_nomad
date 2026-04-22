import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logo_logic.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({Key? key}) : super(key: key);

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  final LogoLogic logic = Get.put(LogoLogic());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Image.asset("images/启动.png", width: Get.width, height: Get.height),
    );
  }

  @override
  void dispose() {
    Get.delete<LogoLogic>();
    super.dispose();
  }
}
