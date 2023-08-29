import 'dart:io';
import 'package:app_emprendimiento/db/db_helper.dart';
import 'package:app_emprendimiento/order/domain/repositories/api_order_repository.dart';
import 'package:app_emprendimiento/order/domain/repositories/local_order_repository.dart';
import 'package:app_emprendimiento/stock/domain/models/item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum OrderStep {
  selectItems,
  setOrderInfo,
  finish
}

enum SelectItemsState {
  normal,
  detail,
  cart
}

class OrderController extends GetxController {
  final LocalOrderInterface localOrderInterface;  
  final ApiOrderInterface apiOrderInterface;  

  OrderController({
    required this.localOrderInterface,
    required this.apiOrderInterface,
  });

  RxBool orderDateSelected = false.obs;
  RxInt selectedRemindTime = 5.obs;
  RxInt selectedColor = 0.obs;
  Rx<DateTime> orderDateTime = DateTime.now().obs;
  var orderStep = OrderStep.selectItems.obs;
  var selectItemsState = SelectItemsState.normal.obs;
  RxList itemsList = [].obs;
  RxInt itemQuantity = 1.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getItemsInStock();
    super.onInit();
  }

  increaseItemQuantity(){
    itemQuantity(itemQuantity.value+1);
  }

  decreaseItemQuantity(){
    itemQuantity(itemQuantity.value-1);
  }

  resetItemQuantity(){
    itemQuantity(1);
  }

  changeOrderStep(OrderStep step){
    orderStep(step);
  }

  changeSelectItemsState(SelectItemsState state){
    selectItemsState(state);
  }

  getItemsInStock()async{
  List items = await DBHelper.queryItems();
  // itemsList.assignAll(items.map((data) => print(data['price'].runtimeType)));
  // itemsList.assignAll(items.map((data) => print(data)));
  itemsList.assignAll(items.map((data) => new Item.fromJson(data)).toList());
  print(itemsList);
}
  
}