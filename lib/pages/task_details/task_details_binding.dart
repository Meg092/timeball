import 'package:get/get.dart';

import 'task_details_logic.dart';

class TaskDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskDetailsLogic());
  }
}
