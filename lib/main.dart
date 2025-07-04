import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:today_task/db_task/db_task.dart';
import 'package:today_task/pages/task_add/task_add_binding.dart';
import 'package:today_task/pages/task_add/task_add_view.dart';
import 'package:today_task/pages/task_details/task_details_binding.dart';
import 'package:today_task/pages/task_details/task_details_view.dart';
import 'package:today_task/pages/task_main/task_main_binding.dart';
import 'package:today_task/pages/task_main/task_main_view.dart';
import 'package:today_task/pages/task_netup/task_netup_binding.dart';
import 'package:today_task/pages/task_netup/task_netup_view.dart';
import 'package:today_task/pages/task_setting/task_setting_binding.dart';
import 'package:today_task/pages/task_setting/task_setting_view.dart';

Color primaryColor = const Color(0xffff7f00);
Color bgColor = const Color(0xfff4f4f4);

List<Color> bgColors = const [
  Color(0xff64f58d),
  Color(0xfff8f186),
  Color(0xffffa48e),
  Color(0xff868ff8),
  Color(0xfff886ef),
  Color(0xfff88686)
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Get.putAsync(() => DBTask().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: TimeBall,
      initialRoute: '/task_main',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> TimeBall = [
  GetPage(name: '/task_main', page: () => const TaskMainPage(), binding: TaskMainBinding()),
  GetPage(name: '/task_add', page: () => TaskAddPage(), binding: TaskAddBinding()),
  GetPage(name: '/task_details', page: () => TaskDetailsPage(), binding: TaskDetailsBinding()),
  GetPage(name: '/task_netup', page: () => TaskNetupView(), binding: TaskNetupBinding()),
  GetPage(name: '/task_setting', page: () => TaskSettingPage(), binding: TaskSettingBinding()),
];