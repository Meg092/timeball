import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:today_task/db_task/task_entity.dart';
import 'package:today_task/main.dart';
import 'package:today_task/pages/task_main/volume_task.dart';


class TaskItem extends StatefulWidget {
  const TaskItem(this.task,this.onTap, {Key? key}) : super(key: key);
  final TaskEntity task;
  final VoidCallback onTap;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  Timer? _timer;
  int maxValue = 0;
  int currentValue = 0;

  void startTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    final now = DateTime.now();
    if (now.isBefore(widget.task.taskTime)) {
      maxValue = widget.task.taskTime
          .difference(widget.task.createdTime)
          .inSeconds;
      currentValue = widget.task.taskTime.difference(now).inSeconds;
    } else {
      maxValue = 0;
      currentValue = 0;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          final now1 = DateTime.now();
          if (now1.isBefore(widget.task.taskTime)) {
            maxValue = widget.task.taskTime
                .difference(widget.task.createdTime)
                .inSeconds;
            currentValue = widget.task.taskTime.difference(now1).inSeconds;
          } else {
            maxValue = 0;
            currentValue = 0;
            _timer?.cancel();
            _timer = null;
          }
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    if (now.isBefore(widget.task.taskTime)) {
      maxValue = widget.task.taskTime
          .difference(widget.task.createdTime)
          .inSeconds;
      currentValue = widget.task.taskTime.difference(now).inSeconds;
    } else {
      maxValue = 0;
      currentValue = 0;
    }
    return <Widget>[
      WaterContainer(
        waterLevel: currentValue,
        maxWaterLevel: maxValue,
        waterColor: bgColors[widget.task.bgType],
      ),
      <Widget>[
        Text(
          widget.task.name,
          textAlign: TextAlign.center,
          style:const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        Text(
          currentValue == 0 ? 'Expired' : widget.task.taskTimeStr,
        )
      ].toColumn(mainAxisAlignment:MainAxisAlignment.center).marginSymmetric(horizontal: 5)
    ].toStack(alignment: Alignment.center).gestures(onTap: (){
      Get.toNamed('/task_details',arguments: widget.task)?.then((v) {
        if (v != null) {
          widget.onTap();
        }
      });
    });
  }
}
