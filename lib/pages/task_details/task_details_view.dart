import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:today_task/main.dart';
import 'package:today_task/pages/task_main/volume_task.dart';

import 'task_details_logic.dart';

class TaskDetailsPage extends GetView<TaskDetailsLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: <Widget>[Expanded(child: Text(controller.entity.name))].toRow(),
        backgroundColor: Colors.white,
        leading: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              'assets/icon3.webp',
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ).gestures(onTap: () {
              Get.back();
            })),
        actions: [
          <Widget>[
            Image.asset('assets/icon2.webp', fit: BoxFit.cover).gestures(
                onTap: () {
              controller.deleteTaskData();
            }),
          ].toRow().marginOnly(right: 20)
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GetBuilder<TaskDetailsLogic>(builder: (_) {
          return <Widget>[
            WaterContainer(
              waterLevel: controller.currentValue,
              maxWaterLevel: controller.maxValue,
              waterColor: bgColors[controller.entity.bgType],
            ),
            Text(
              controller.entity.taskTime.isBefore(DateTime.now())
                  ? 'Expired'
                  : DateFormat('HH:mm').format(controller.entity.taskTime),
              style: TextStyle(fontSize: 76, fontWeight: FontWeight.bold),
            )
          ].toStack(alignment: Alignment.center);
        }),
      ),
    );
  }
}
