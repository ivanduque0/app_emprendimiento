import 'dart:io';

import 'package:app_emprendimiento/order/presentation/getx/order_controller.dart';
import 'package:app_emprendimiento/stock/domain/models/item.dart';
import 'package:app_emprendimiento/stock/presentation/getx/stock_binding.dart';
import 'package:app_emprendimiento/stock/presentation/views/pages/edit_item_page.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:app_emprendimiento/order/presentation/views/pages/item_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemWidget extends StatelessWidget {
  ItemWidget({
    super.key,
    required this.item,
    this.color
  });

  final Item item;
  final Color? color;

  OrderController orderController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (item.quantity==0) return;
        orderController.resetItemQuantity();
        Get.to(()=>ItemDetail(
          item:item
          ),
          transition: Transition.fadeIn,
          duration: Duration(milliseconds: 700));
      },
      child: Opacity(
        opacity: item.quantity==0?0.35:1,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          shadowColor: Colors.black54,
          color: color,
          // color: mainController.isDarkMode.value?pinkClr:Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Hero(
                      tag:"itemId${item.id}",
                      child: Image.file(
                        File(item.photo??""),
                        fit: BoxFit.cover,
                        height: 100
                        ),
                    ),
                  ),
                ),
                Text(
                  "\$${item.price??""}",
                  style: priceStyleItem,
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 15,),
                Text(
                  item.name??"",
                  maxLines: 2,
                  style: subTitleStyleItem
                ),
                SizedBox(height: 7,),
                Text(
                  "${item.quantity??""} unidades",
                  style: subTitleStyleItem,
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Text(
                //       item.name??"",
                //       maxLines: 2,
                //       style: titleStyleStock
                //     ),
                //     Text(
                //       "Precio: ${item.price??""}",
                //       style: subTitleStyleStock,
                //     ),
                //     Text(
                //       "Cantidad: ${item.quantity??""}",
                //       style: subTitleStyleStock,
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}