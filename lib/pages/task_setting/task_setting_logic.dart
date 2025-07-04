import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:today_task/db_task/db_task.dart';
import 'package:today_task/pages/task_main/task_main_logic.dart';

class TaskSettingLogic extends GetxController {

  DBTask dbTask = Get.find();

  cleanTaskData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all records?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            await dbTask.cleanAllData();
            Get.back(result:  true);
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  aboutTaskUS(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/launcher.webp',
        width: 77,
        height: 77,
      ),
      children: [
        const Text(
            """We can provide you with custom tasks"""),
      ],
      context: context,
    );
  }


}
