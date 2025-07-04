import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:today_task/db_task/db_task.dart';
import 'package:today_task/db_task/task_entity.dart';

class TaskDetailsLogic extends GetxController {
  DBTask dbTask = Get.find();

  TaskEntity entity = Get.arguments;

  Timer? _timer;
  int maxValue = 0;
  int currentValue = 0;

  void startTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    getData();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getData();
    });
  }

  void getData(){
    final now = DateTime.now();
    if (now.isBefore(entity.taskTime)) {
      maxValue = entity.taskTime.difference(entity.createdTime).inSeconds;
      currentValue = entity.taskTime.difference(now).inSeconds;
    } else {
      maxValue = 0;
      currentValue = 0;
      _timer?.cancel();
      _timer = null;
    }
    update();
  }

  deleteTaskData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Are you sure you have completed this task?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () async {
            _timer?.cancel();
            _timer = null;
            await dbTask.deleteTask(entity.id);
            Get.back();
            Get.back(result: true);
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _timer?.cancel();
    _timer = null;
    super.onClose();
  }
}
