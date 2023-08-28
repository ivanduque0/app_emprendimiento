import 'dart:io';

import 'package:app_emprendimiento/stock/domain/models/item.dart';
import 'package:app_emprendimiento/stock/presentation/getx/stock_binding.dart';
import 'package:app_emprendimiento/stock/presentation/views/pages/edit_item_page.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.item
  });

  final Item item;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>EditItemPage(
          id:item.id,
          photo:item.photo,
          priceTextController: TextEditingController(text:item.price),
          nameTextController: TextEditingController(text:item.name),
          quantityTextController: TextEditingController(text:item.quantity.toString()),
          ), binding: StockBinding(), 
          transition: Transition.fadeIn,
          duration: Duration(milliseconds: 700));
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        shadowColor: mainController.isDarkMode.value?white:Colors.black54,
        color: mainController.isDarkMode.value?pinkClr:Colors.grey[200],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag:"photoItem_${item.id}",
                    child: Image.file(
                      File(item.photo??""),
                      fit: BoxFit.cover,
                      ),
                  ),
                ),
              )
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    item.name??"",
                    maxLines: 2,
                    style: titleStyle
                  ),
                  Text(
                    "Precio: ${item.price??""}",
                    style: subTitleStyle,
                  ),
                  Text(
                    "Cantidad: ${item.quantity??""}",
                    style: subTitleStyle,
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}