import 'dart:io';

import 'package:app_emprendimiento/db/db_helper.dart';
import 'package:app_emprendimiento/main/domain/repositories/api_main_repository.dart';
import 'package:app_emprendimiento/main/domain/repositories/local_main_repository.dart';
import 'package:app_emprendimiento/services/notification_services.dart';
import 'package:app_emprendimiento/stock/domain/models/item.dart';
import 'package:app_emprendimiento/stock/domain/repositories/api_stock_repository.dart';
import 'package:app_emprendimiento/stock/domain/repositories/local_stock_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockController extends GetxController {
  final LocalStockInterface localStockInterface;  
  final ApiStockInterface apiStockInterface;  

  StockController({
    required this.localStockInterface,
    required this.apiStockInterface,
  });

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  RxMap imageFile={}.obs;

  final priceTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final quantityTextController = TextEditingController();

  addPhoto(File file, path){
    Map mapFile = {"file": file, "path":path};
    imageFile(mapFile);
    // print(imageFile.value);
  }

  Future<int> addItem(Item item) async {
    return await DBHelper.insertItem(item) ;
  }

  Future<int> updateItem(Item item) async {
    return await DBHelper.updateItem(item) ;
  }

  Future<int> deleteItem(int id) async {
    return await DBHelper.deleteItem(id) ;
  }
  
}