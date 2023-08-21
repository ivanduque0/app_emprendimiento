import 'package:app_emprendimiento/main/domain/repositories/api_main_repository.dart';
import 'package:app_emprendimiento/main/domain/repositories/local_main_repository.dart';
import 'package:app_emprendimiento/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum refreshScreen {
  refresh,
  initial
}

class MainController extends GetxController {
  final LocalMainInterface localMainInterface;  
  final ApiMainInterface apiMainInterface;  

  MainController({
    required this.localMainInterface,
    required this.apiMainInterface,
  });

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isDarkMode(Get.isDarkMode);
    NotifyHelper().initializeNotification();
    NotifyHelper().requestAndroidPermissions();
    NotifyHelper().requestIOSPermissions();
    refreshScreenFunction();
  }

  final calculatorTextController = TextEditingController();

  RxBool isDarkMode = false.obs;
  var refreshState = refreshScreen.initial.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> orderDateTime = DateTime.now().obs;
  RxBool orderDateSelected = false.obs;
  RxInt selectedRemindTime = 5.obs;
  RxInt selectedColor = 0.obs;
  RxInt mainScreenIndex = 0.obs;
  RxDouble tasaDolar = 0.0.obs;
  RxDouble calculoDolar = 0.0.obs;

  refreshScreenFunction() {
    refreshState(refreshScreen.refresh);
    refreshState(refreshScreen.initial);
  }

  Future<Map>updateTasa() async {
    Map tasasDeDolar = await apiMainInterface.getTasas();
    tasaDolar(double.parse(tasasDeDolar['enparalelovzla']['price']));
    //tasaDolar(double.parse("10.00"));
    //print(tasasDeDolar);
    refreshScreenFunction();
    return tasasDeDolar;
  }
}