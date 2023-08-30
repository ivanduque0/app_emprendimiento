import 'dart:io';
import 'package:app_emprendimiento/main/presentation/getx/main_controller.dart';
import 'package:app_emprendimiento/stock/presentation/getx/stock_binding.dart';
import 'package:app_emprendimiento/stock/presentation/routes/stock_navigation.dart';
import 'package:app_emprendimiento/stock/presentation/views/pages/edit_item_page.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    child: Obx(()=> controller.refreshState.value==refreshScreen.initial?Padding(
      padding: const EdgeInsets.symmetric(horizontal:7.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10
        ), 
        itemCount: controller.itemsList.value.length,
        itemBuilder: (_, index){
          return GestureDetector(
            onTap: () {
              Get.to(()=>EditItemPage(
                id:controller.itemsList.value[index].id,
                photo:controller.itemsList.value[index].photo,
                priceTextController: TextEditingController(text:controller.itemsList.value[index].price),
                nameTextController: TextEditingController(text:controller.itemsList.value[index].name),
                quantityTextController: TextEditingController(text:controller.itemsList.value[index].quantity.toString()),
                ), binding: StockBinding(), 
                transition: Transition.fadeIn,
                duration: Duration(milliseconds: 700));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: "photoItem_${controller.itemsList.value[index].id}",
                child: Image.file(
                  File(controller.itemsList.value[index].photo??""),
                  fit: BoxFit.cover,
                  ),
              ),
            ),
          );
        }
      ),
    ):SizedBox.shrink(),
    ),
  );
}