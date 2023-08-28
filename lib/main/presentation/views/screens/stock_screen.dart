import 'dart:io';

import 'package:app_emprendimiento/db/db_helper.dart';
import 'package:app_emprendimiento/main/presentation/getx/main_controller.dart';
import 'package:app_emprendimiento/main/presentation/routes/main_navigation.dart';
import 'package:app_emprendimiento/stock/domain/models/item.dart';
import 'package:app_emprendimiento/stock/presentation/getx/stock_binding.dart';
import 'package:app_emprendimiento/stock/presentation/routes/stock_navigation.dart';
import 'package:app_emprendimiento/stock/presentation/views/pages/edit_item_page.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:app_emprendimiento/ui/widgets/item_in_list.dart';
import 'package:app_emprendimiento/ui/widgets/staggered_dual_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class StockScreen extends GetWidget<MainController> {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _addItemButton(controller),
        _showItems(controller)
      ],
    );
  }
}

_addItemButton(controller){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal:20.0, vertical: 10),
    child: GestureDetector(
      onTap: () async {
        imageCache.clear();
        imageCache.clearLiveImages();
        // var appDir = await getTemporaryDirectory();
        // var path = appDir.path;
        // print(path);
        // var directory = Directory(path);
        // await directory.delete();
        Get.toNamed(StockRoutes.addToStock);
      },
      child:Container(
        height:60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr
        ),
        child: Center(
          child: Text("Añadir articulo al inventario",
          textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18
              
            ),
          ),
        ),
      ),
    ),
  );
}

_showItems(MainController controller){
  return Expanded(
    child: Obx(() => 
      controller.refreshState.value==refreshScreen.initial?Padding(
        padding: const EdgeInsets.symmetric(horizontal:7.0),
        child: StaggeredDualView(
          itemCount: controller.itemsList.length,
          spacing: 2,
          aspectRatio: 0.7,
          itemBuilder: (_, index){
            return ItemWidget(
              item: controller.itemsList.value[index]
            );
          }
      
        ),
      ):SizedBox.shrink()
    )
  );
}