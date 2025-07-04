import 'package:get/get.dart';
import 'package:today_task/db_task/db_task.dart';

import '../../db_task/task_entity.dart';

class TaskMainLogic extends GetxController {
  DBTask dbTask = Get.find();

  List<TaskEntity> list = [];

  void getData() async {
    list.clear();
    update();
    final result = await dbTask.getTaskAllData();
    list = result.where((element) {
      return element.taskTime.year == DateTime.now().year &&
          element.taskTime.month == DateTime.now().month &&
          element.taskTime.day == DateTime.now().day;
    }).toList();
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}
