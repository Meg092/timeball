import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:today_task/pages/task_main/task_item.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'task_main_logic.dart';

class TaskMainPage extends StatefulWidget {
  const TaskMainPage({Key? key}) : super(key: key);

  @override
  State<TaskMainPage> createState() => _TaskMainPageState();
}

class _TaskMainPageState extends State<TaskMainPage> {
  TaskMainLogic controller = Get.find();

  void oiuoiyqigb() async {
    final hadNetwork = await InternetConnectionChecker.instance.hasConnection;
    if (!hadNetwork) {
      Get.toNamed('/task_netup');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    oiuoiyqigb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: <Widget>[const Expanded(child: Text('Today task'))].toRow(),
        backgroundColor: Colors.white,
        actions: [
          <Widget>[
            Image.asset('assets/icon0.webp', fit: BoxFit.cover).gestures(
                onTap: () {
              Get.toNamed('/task_add')?.then((_) {
                controller.getData();
              });
            }),
            const SizedBox(
              width: 10,
            ),
            Image.asset('assets/icon1.webp', fit: BoxFit.cover).gestures(
                onTap: () {
              Get.toNamed('/task_setting')?.then((v) {
                controller.getData();
              });
            })
          ].toRow().marginOnly(right: 20)
        ],
      ),
      body: SafeArea(
          child: GetBuilder<TaskMainLogic>(builder: (_) {
        return controller.list.isEmpty
            ? const Center(
                child: Text('No data'),
              )
            : GridView.custom(
                gridDelegate: SliverWovenGridDelegate.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  pattern: const [
                    WovenGridTile(1, alignment: AlignmentDirectional.topStart),
                    WovenGridTile(
                      1,
                      crossAxisRatio: 0.9,
                      alignment: AlignmentDirectional.bottomEnd,
                    ),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  childCount: controller.list.length,
                  (context, index)  {
                    final entity = controller.list[index];
                    return LayoutBuilder(builder: (_, max) {
                      return Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(max.maxWidth / 2),
                          child: <Widget>[
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                            ).decorated(color: Colors.white),
                            TaskItem(entity, () {
                              controller.getData();
                            }),
                          ].toStack(alignment: Alignment.center),
                        ),
                      ).decorated(
                          borderRadius: BorderRadius.circular(max.maxWidth / 2),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.16),
                                blurRadius: 6,
                                spreadRadius: 1,
                                offset: const Offset(0, 3))
                          ]);
                    });
                  },
                ),
              );
      }).marginAll(20)),
    );
  }
}
