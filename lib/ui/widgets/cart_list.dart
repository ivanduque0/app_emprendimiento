import 'dart:io';
import 'package:app_emprendimiento/order/presentation/getx/order_controller.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartList extends GetWidget<OrderController> {

  const CartList({super.key,
  required this.cartBarHeight});
  final cartBarHeight;

  onDismiss(productID){
    controller.deleteProductOnCart(productID);
    controller.refresCart();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:20.0, bottom: 20, right:20.0),
                child: Text("Carrito",
                style: headingStyle.copyWith(color: white,
                fontSize: 30),),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(()=> ListView.builder(
                      itemCount: controller.cartProducts.length,
                      itemBuilder: (_, index){
                        return Dismissible(
                          key: Key(controller.cartProducts.value[index].product.id.toString()),
                          onDismissed: (direction){
                            try {
                              onDismiss(controller.cartProducts.value[index].product.id);
                            } catch (e) {
                              
                            }

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: Image.file(
                                          File(controller.cartProducts[index].product.photo??""),
                                          // fit: BoxFit.cover,
                                        ).image,
                                    ),
                                    SizedBox(width: 20,),
                                    Text("${controller.cartProducts[index].quantity.toString()}     x   ${controller.cartProducts[index].product.name}",
                                      style: TextStyle(
                                        color: white
                                      ),
                                    ),
                                  ],
                                ),
                                Text("\$${(controller.cartProducts[index].quantity*double.parse(controller.cartProducts[index].product.price??"0")).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                  ),
                )
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total:",
              style: headingStyle.copyWith(
                color: Colors.grey[600]
              ),),
              Obx(()=>controller.cartState==CartState.initial?Text("\$${controller.totalToPay.value.toStringAsFixed(2)}",
                  style: headingStyle.copyWith(
                    color: white,
                    fontSize: 35
                  ),
                ):SizedBox.shrink(),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: ElevatedButton(
                  onPressed: ()async{
                    if (controller.cartProducts.value.length==0) {
                      Get.snackbar(
                        "No se puede continuar",
                        "El carrito esta vacio",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: mainController.isDarkMode.value?white:Colors.grey[400],
                        colorText: pinkClr,
                        icon: Icon(Icons.warning_amber_rounded,
                          color: Colors.red,
                        ),
                        margin: EdgeInsets.only(bottom: 15, left: 15, right: 15)
                      );
                    } else {
                      controller.changeOrderStep(OrderStep.setOrderInfo);
                    }
                     
                    
                  }, 
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:15.0, horizontal: 15),
                    child: Text(
                      " Siguiente ",
                      style: TextStyle(
                        color: white,
                        fontSize: 20
                      ),
                      ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.grey[300],
                    backgroundColor: blueClr
                  )
                ),
              ),
            )
          ],
        ),
        SizedBox(height: (cartBarHeight*2)+10,)
      ],
    );
  }
}