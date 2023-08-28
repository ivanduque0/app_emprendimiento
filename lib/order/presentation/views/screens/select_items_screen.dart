import 'dart:io';

import 'package:app_emprendimiento/order/presentation/getx/order_controller.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:app_emprendimiento/ui/widgets/item_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectItemsScreen extends GetWidget<OrderController> {
  const SelectItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Seleccione los productos",
              style: headingStyle,
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                child: Obx(()=> GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10
                    ), 
                    itemCount: controller.itemsList.value.length,
                    itemBuilder: (_, index){
                      return GestureDetector(
                        onTap: () {
                          if (controller.itemsList.value[index].quantity==0) return;
                          Get.to(()=>ItemDetail(
                            item:controller.itemsList.value[index]
                            ),
                            transition: Transition.fadeIn,
                            duration: Duration(milliseconds: 700));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Opacity(
                            opacity: controller.itemsList.value[index].quantity==0?0.35:1,
                            child: Hero(
                              tag: "itemId${controller.itemsList.value[index].id}",
                              child: Image.file(
                                File(controller.itemsList.value[index].photo??""),
                                fit: BoxFit.cover,
                                ),
                            ),
                          ),
                        ),
                      );
                    }
                    ),
                ),
              ),
            )
          ],
        ),
    );
  }
}