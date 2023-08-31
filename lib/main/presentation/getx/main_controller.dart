import 'dart:io';

import 'package:app_emprendimiento/db/db_helper.dart';
import 'package:app_emprendimiento/main/domain/repositories/api_main_repository.dart';
import 'package:app_emprendimiento/main/domain/repositories/local_main_repository.dart';
import 'package:app_emprendimiento/order/domain/models/order.dart';
import 'package:app_emprendimiento/services/notification_services.dart';
import 'package:app_emprendimiento/stock/domain/models/item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum refreshScreen {
  refresh,
  initial
}

enum UpdateTasaState {
  initial,
  update
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
    getItemsInStock();
    getOrders();
    refreshScreenFunction();
  }

  final calculatorTextController = TextEditingController();

  RxBool isDarkMode = false.obs;
  var refreshState = refreshScreen.initial.obs;
  var updateTasaState = UpdateTasaState.initial.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxInt mainScreenIndex = 0.obs;
  RxDouble tasaDolar = 0.0.obs;
  RxDouble calculoDolar = 0.0.obs;
  RxList itemsList = [].obs;
  RxList ordersList = [].obs;
  RxList<bool> selectedToggledButton = [true, false].obs;

  switchToggleButtonSelected(int index) async {
    if (selectedToggledButton.value[index]) return;
      selectedToggledButton.value[0]=!selectedToggledButton.value[0];
      selectedToggledButton.value[1]=!selectedToggledButton.value[1];
    // selectedToggledButton = await [!selectedToggledButton.value[0], !selectedToggledButton.value[0]].obs;
  }

  refreshScreenFunction() {
    refreshState(refreshScreen.refresh);
    refreshState(refreshScreen.initial);
  }

  changeUpdateTasaState(UpdateTasaState state) {
    updateTasaState(state);
  }

  Future<Map>updateTasa() async {
    Map tasasDeDolar = await apiMainInterface.getTasas();
    tasaDolar(double.parse(tasasDeDolar['enparalelovzla']['price']));
    //tasaDolar(double.parse("10.00"));
    //print(tasasDeDolar);
    refreshScreenFunction();
    return tasasDeDolar;
  }

  getItemsInStock()async{
    List items = await DBHelper.queryItems();
    // itemsList.assignAll(items.map((data) => print(data['price'].runtimeType)));
    // itemsList.assignAll(items.map((data) => print(data)));
    itemsList.assignAll(items.map((data) => new Item.fromJson(data)).toList());
  }

  getOrders()async{
    List orders = await DBHelper.queryOrders();
    // itemsList.assignAll(items.map((data) => print(data['price'].runtimeType)));
    // itemsList.assignAll(items.map((data) => print(data)));
    ordersList.assignAll(orders.map((data) => new Order.fromJson(data)).toList());
  }

  Future<int> deleteOrder(int id) async {
    return await DBHelper.deleteOrder(id) ;
  }

  completeOrder(Order order){
    order.isCompleted=true;
    updateOrder(order);
  }

  Future<int> updateOrder(Order order) async {
    return await DBHelper.updateOrder(order) ;
  }
}