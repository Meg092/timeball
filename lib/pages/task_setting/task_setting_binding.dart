import 'package:get/get.dart';

import 'task_setting_logic.dart';

class TaskSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskSettingLogic());
  }
}
