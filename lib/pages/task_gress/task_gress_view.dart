import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'task_gress_logic.dart';

class TaskGressView extends GetView<TaskGressLogic> {
  const TaskGressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.schoen.value
              ? const CircularProgressIndicator(color: Colors.orangeAccent)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.ouwfqsn();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
