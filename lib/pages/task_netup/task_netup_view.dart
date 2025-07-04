import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'task_netup_logic.dart';

class TaskNetupView extends GetView<TaskNetupLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Refresh Network'),
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            const SizedBox(
              height: 70,
            ),
            const Text(
              'Please refresh your network status',
              style: TextStyle(color: Colors.black45),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 157,
              height: 46,
              alignment: Alignment.center,
              child: const Text('Reload',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffa5a5a5)),),
            )
                .decorated(
                    borderRadius: BorderRadius.circular(23),
                    color: Colors.white,
                    border: Border.all(color: const Color(0xffa9a9a9), width: 0.5))
                .gestures(onTap: () {
              controller.ghkakjslso();
            })
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}
