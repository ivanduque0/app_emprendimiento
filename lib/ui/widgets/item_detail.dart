import 'dart:io';

import 'package:app_emprendimiento/order/presentation/getx/order_controller.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:app_emprendimiento/ui/widgets/button.dart';
import 'package:app_emprendimiento/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetail extends GetWidget<OrderController> {
  ItemDetail({
    super.key,
    required this.item,
  });
  final item;
  final qttyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 35),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20)),
          ),
          
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 35),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: "itemId${item.id}",
                      child: Image.file(
                      File(item.photo),
                      fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Precio: \$${item.price}",
                      style: titleStyle,
                    ),
                    Text(
                      "disponibles: ${item.quantity}",
                      style: titleStyle,
                    ),
                  ],
                ),
                MyInputField(title: "piezas a comprar", hint: "ingrese una cantidad", onlyNumbers: true, textController: qttyController,),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                  ],
                )
                
              ]
            ),
          ),
        ),
      ),
      floatingActionButton: MyButton(
        label: "Añadir al carrito", 
        onTap: (){
          if (qttyController.text=="") {
            return Get.snackbar(
              "No se pudo añadir al carrito",
              "Debe ingresar una cantidad mayor a 0",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: mainController.isDarkMode.value?white:Colors.grey[400],
              colorText: pinkClr,
              icon: Icon(Icons.warning_amber_rounded,
                color: Colors.red,
              ),
              margin: EdgeInsets.only(bottom: 15, left: 15, right: 15)
            );
          } else if(int.parse(qttyController.text)>item.quantity){
            return Get.snackbar(
              "No se pudo añadir al carrito",
              "ingrese una cantidad menor o igual a la disponible",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: mainController.isDarkMode.value?white:Colors.grey[400],
              colorText: pinkClr,
              icon: Icon(Icons.warning_amber_rounded,
                color: Colors.red,
              ),
              margin: EdgeInsets.only(bottom: 15, left: 15, right: 15)
            );
          }
          Get.back();
        }),
    );
  }
}

_anadirAlCarrito(){
  
}

_appBar(){
    return AppBar(
      
      leading: GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 25,
        ),
      ),
    );
  }