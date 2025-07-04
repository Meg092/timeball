import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:today_task/db_task/db_task.dart';
import 'package:today_task/db_task/task_entity.dart';

class TaskAddLogic extends GetxController {
  DBTask dbTask = Get.find();

  String name = '';
  DateTime? taskTime;
  String taskTimeStr = '';
  int bgType = 0;

  void selectTaskTime(BuildContext context) {
    DatePicker.showDatePicker(context,
        dateFormat: 'HH:mm',
        minDateTime: DateTime.now().add(const Duration(minutes: 30)),
        onConfirm: (date, list) {
      taskTime = date;
      taskTimeStr = DateFormat('HH:mm').format(date);
      update();
    });
  }

  void addTask() async {
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter task name');
      return;
    }
    if (taskTime == null) {
      Fluttertoast.showToast(msg: 'Please select task time');
      return;
    }
    final entity = TaskEntity(
        id: 0,
        createdTime: DateTime.now(),
        name: name,
        taskTime: taskTime!,
        bgType: bgType);
    await dbTask.insertTask(entity);
    Get.back();
  }
}
