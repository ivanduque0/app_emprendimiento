import 'dart:io';
import 'package:app_emprendimiento/order/presentation/getx/order_controller.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:app_emprendimiento/ui/widgets/cart_list.dart';
import 'package:app_emprendimiento/ui/widgets/item_in_list.dart';
import 'package:app_emprendimiento/ui/widgets/staggered_dual_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const _panelTransition = Duration(milliseconds: 600);
const double _cartBarHeight = 80;

class SelectProductsScreen extends GetWidget<OrderController> {
  const SelectProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        //mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Obx(()=>Stack(
                children: [
                  _showItems(controller, context, size),
                  _cartBar(size, controller)
                ],
              ),
            )
          )
          
        ],
      );
  }
}

_showItems(OrderController controller, context, size){
  
  // List itemsColors = [pinkClr, yellowClr, blueClr];
  // int colorIndex = -1;
  return AnimatedPositioned(
    curve: Curves.decelerate,
    duration: _panelTransition,
        left: 0,
        right: 0,
        top: controller.selectItemsState==SelectItemsState.normal?-_cartBarHeight:-size.height+_cartBarHeight*2,
        height: size.height- _cartBarHeight,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Get.isDarkMode?darkHeaderClr:white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            )
          ),
          padding: const EdgeInsets.symmetric(horizontal:4.0),
          child: Padding(
            padding: const EdgeInsets.only(top: _cartBarHeight),
            child: StaggeredDualView(
                itemCount: controller.itemsList.length,
                spacing: 0,
                aspectRatio: 0.7,
                itemBuilder: (_, index){
                  // colorIndex++;
                  // if (colorIndex>=3) {
                  //   colorIndex=0;
                  // }
                  //print(colorIndex);
                  return ItemWidget(
                    item: controller.itemsList.value[index],
                    color: Get.isDarkMode?black:white,
                    // color: itemsColors[colorIndex],
                  );
                }
              ),
          ),
          ),
        );
}

_cartBar(size, OrderController controller){
  return AnimatedPositioned(
    curve: Curves.decelerate,
    duration: _panelTransition,
    left: 0,
    right: 0,
    top: controller.selectItemsState==SelectItemsState.normal?size.height - _cartBarHeight*2:0+_cartBarHeight,
    // top: size.height - cartBarHeight*2,
    height: size.height,
    child: GestureDetector(
      onVerticalDragUpdate: onVerticalGesture,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 800),

                child: controller.selectItemsState==SelectItemsState.normal?Row(
                  children: [
                    Container(
                      width: 35,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: (){
                          controller.changeSelectItemsState(SelectItemsState.cart);
                        }, 
                        icon: Icon(Icons.shopping_cart_outlined,
                          color: white,
                          size: 35,),
                      ),
                    ),
                    // Icon(Icons.shopping_cart_outlined,
                    // color: white,
                    // size: 35,),
                    // Text(
                    //   "Carrito",
                    //   style: headingStyle.copyWith(
                    //     color: white,
                    //     fontSize: 20
                    //   ),
                    // ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Obx(()=>Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: Row(
                              children: List.generate(
                                controller.cartProducts.value.length, 
                                (index) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Stack(
                                    children: [
                                      Hero(
                                        tag: "itemId${controller.cartProducts.value[index].product.id}detail",
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: Image.file(
                                            File(controller.cartProducts.value[index].product.photo??""),
                                            // fit: BoxFit.cover,
                                          ).image,
                                        ),
                                      ),
                                      Obx(()=>Positioned(
                                          right: 0,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius:8,
                                            child: controller.cartState.value==CartState.initial?Text(
                                              controller.cartProducts.value[index].quantity.toString(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: white
                                              ),
                                              ):SizedBox.shrink(),
                                        
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            ),
                        ),
                        ),
                      )
                    ),
                    SizedBox(width: 12,),
                    CircleAvatar(
                      backgroundColor: blueClr,
                      radius:25,
                      child: Obx(() => controller.cartState.value==CartState.initial?Text(
                        controller.productsInCartQuantity.value.toString(),
                        style: TextStyle(
                          color: white,
                          fontSize: 20
                        ),
                        ):SizedBox.shrink()
                      )
                      
                    )
                  ],
                ):SizedBox.shrink(),
              ),
            ),
            controller.selectItemsState==SelectItemsState.cart?
              Expanded(child: CartList(cartBarHeight: _cartBarHeight,)):
              SizedBox.shrink()
          ],
        ),
      ),
    ),
  );
}

onVerticalGesture(DragUpdateDetails details){
  OrderController controller = Get.find();
  if (details.primaryDelta! < -7) {
    controller.changeSelectItemsState(SelectItemsState.cart);
  } else if(details.primaryDelta! > 12){
    controller.changeSelectItemsState(SelectItemsState.normal);
  }
}