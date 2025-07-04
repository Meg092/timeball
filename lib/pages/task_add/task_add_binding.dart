import 'package:get/get.dart';

import 'task_add_logic.dart';

class TaskAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskAddLogic());
  }
}
