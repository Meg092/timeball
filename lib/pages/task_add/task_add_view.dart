import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:today_task/main.dart';
import 'package:today_task/pages/task_add/task_text_field.dart';

import 'task_add_logic.dart';

class TaskAddPage extends GetView<TaskAddLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add task'),
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
        // leadingWidth: 30,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<TaskAddLogic>(builder: (_) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: <Widget>[
                  const Text(
                    'Task name',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: TaskTextField(
                        value: controller.name,
                        maxLength: 20,
                        onChange: (v) {
                          controller.name = v;
                        }),
                  ).decorated(
                      color: const Color(0xfffcfcfc),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xffd1d1d1))),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Task time',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: <Widget>[
                      Expanded(
                          child: IgnorePointer(
                        child: TaskTextField(
                            hintText: 'Select time',
                            value: controller.taskTimeStr,
                            onChange: (_) {}),
                      )),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.black,
                        size: 25,
                      )
                    ].toRow(),
                  )
                      .decorated(
                          color: const Color(0xfffcfcfc),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: const Color(0xffd1d1d1)))
                      .gestures(onTap: () {
                    controller.selectTaskTime(context);
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Select color',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 45,
                    child: GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1, mainAxisSpacing: 8),
                        itemCount: bgColors.length,
                        itemBuilder: (_, index) {
                          return Container()
                              .decorated(
                            color: bgColors[index],
                            borderRadius: BorderRadius.circular(22.5),
                            border: controller.bgType == index
                                ? Border.all(color: Colors.black, width: 2)
                                : null,
                          )
                              .gestures(onTap: () {
                            controller.bgType = index;
                            controller.update();
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      'Add task',
                      style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                  ).decorated(color: primaryColor,borderRadius: BorderRadius.circular(10)).gestures(onTap: (){
                    controller.addTask();
                  })
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              ).decorated(
                  color: Colors.white, borderRadius: BorderRadius.circular(20))
            ].toColumn(),
          );
        }).marginAll(15)),
      ),
    );
  }
}
