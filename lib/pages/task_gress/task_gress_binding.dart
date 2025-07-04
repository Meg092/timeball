import 'package:get/get.dart';

import 'task_gress_logic.dart';

class TaskGressBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      TaskGressLogic(),
      permanent: true,
    );
  }
}
