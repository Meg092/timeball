import 'package:get/get.dart';

import 'task_netup_logic.dart';

class TaskNetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskNetupLogic());
  }
}
