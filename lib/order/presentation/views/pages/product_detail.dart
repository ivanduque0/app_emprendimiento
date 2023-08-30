import 'dart:io';
import 'package:app_emprendimiento/order/domain/models/product_cart.dart';
import 'package:app_emprendimiento/order/presentation/getx/order_controller.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetail extends GetWidget<OrderController> {
  ItemDetail({
    super.key,
    required this.item,
  });
  final item;
  final qttyController = TextEditingController();

  _addToCart(ProductCart product){
    controller.addProductToCart(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0, vertical: 15),
        child: Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20)),
          // ),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(20),
                      child: Obx(()=>Hero(
                          tag: "itemId${item.id}${controller.heroTag.value}",
                          child: Image.file(
                          File(item.photo),
                          fit: BoxFit.scaleDown,
                          height: MediaQuery.of(context).size.height*0.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${item.name}",
                        style: priceStyleItem.copyWith(
                          fontSize: 24,
                          color: Get.isDarkMode?white:black
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: lightGreyClr,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30)
                              )
                            ),
                            height: 50,
                            width: 50,
                            child: GestureDetector(
                              onTap: (){
                                if (controller.itemQuantity==1) return;
                                controller.decreaseItemQuantity();
                              },
                              child: Icon(Icons.remove , color: black, size: 35,),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: lightGreyClr,
                              
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal:12.0),
                                child: Obx(()=>Text(
                                    "${controller.itemQuantity.value}",
                                    style: TextStyle(fontSize: 28, color: black),),
                                ),
                              )
                              ),
                            height: 50,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: lightGreyClr,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)
                              )
                            ),
                            height: 50,
                            width: 50,
                            child: GestureDetector(
                              onTap: () {
                                if (controller.itemQuantity==item.quantity) return;
                                controller.increaseItemQuantity();
                              },
                              child: Icon(Icons.add, color: black, size: 35,),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${item.price}",
                        style: priceStyleItem.copyWith(
                          fontSize: 30,
                          color: Get.isDarkMode?white:black
                        ),
                      ),
                    ],
                  ),
                
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: ()async{
                        await _addToCart(ProductCart(product: item, quantity: controller.itemQuantity.value));
                        controller.heroTag("detail");
                        controller.refresCart();
                      Get.back();
                    }, 
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:15.0, horizontal: 15),
                      child: Text(
                        " Añadir al carrito ",
                        style: TextStyle(
                          color: white
                        ),
                        ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey[300],
                      backgroundColor: blueClr
                    )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: MyButton(
      //   label: "Añadir al carrito", 
      //   onTap: (){
      //     if (qttyController.text=="") {
      //       return Get.snackbar(
      //         "No se pudo añadir al carrito",
      //         "Debe ingresar una cantidad mayor a 0",
      //         snackPosition: SnackPosition.BOTTOM,
      //         backgroundColor: mainController.isDarkMode.value?white:Colors.grey[400],
      //         colorText: pinkClr,
      //         icon: Icon(Icons.warning_amber_rounded,
      //           color: Colors.red,
      //         ),
      //         margin: EdgeInsets.only(bottom: 15, left: 15, right: 15)
      //       );
      //     } else if(int.parse(qttyController.text)>item.quantity){
      //       return Get.snackbar(
      //         "No se pudo añadir al carrito",
      //         "ingrese una cantidad menor o igual a la disponible",
      //         snackPosition: SnackPosition.BOTTOM,
      //         backgroundColor: mainController.isDarkMode.value?white:Colors.grey[400],
      //         colorText: pinkClr,
      //         icon: Icon(Icons.warning_amber_rounded,
      //           color: Colors.red,
      //         ),
      //         margin: EdgeInsets.only(bottom: 15, left: 15, right: 15)
      //       );
      //     }
      //     Get.back();
      //   }),
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