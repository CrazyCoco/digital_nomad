import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_account_logic.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final CreateAccountLogic logic = Get.put(CreateAccountLogic());

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<CreateAccountLogic>();
    super.dispose();
  }
}