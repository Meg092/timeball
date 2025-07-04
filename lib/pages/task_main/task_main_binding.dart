import 'package:get/get.dart';

import 'task_main_logic.dart';

class TaskMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskMainLogic());
  }
}
