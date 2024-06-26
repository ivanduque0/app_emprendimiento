import 'package:app_emprendimiento/main/presentation/getx/main_controller.dart';
import 'package:app_emprendimiento/order/presentation/getx/order_controller.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SaveOrderScreen extends GetWidget<OrderController> {
  SaveOrderScreen({super.key});

  List colors = [primaryClr,pinkClr,yellowClr];
  double iconsSize = 30;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.changeOrderStep(OrderStep.setOrderInfo);
        return false;
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: colors[controller.orderObject.value.color??0],
            ),
            child: Column(
              children: [
                SizedBox(height: 15,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom:5.0),
                          child: Row(
                            children: [
                              Icon(Icons.person,size: iconsSize,color: controller.orderObject.value.color==2?black:white,),
                              Text(
                                "Nombre",
                                style: subHeadingStyle.copyWith(
                                  color: controller.orderObject.value.color==2?black:white,
                                  fontSize: 25
                                ),  
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0),
                          child: Text(
                            "${controller.orderObject.value.name}",
                            style: subHeadingStyle.copyWith(
                              color: controller.orderObject.value.color==2?black:white
                            ),  
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(bottom:5.0),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_month,size: iconsSize,color: controller.orderObject.value.color==2?black:white,),
                              Text(
                                "Fecha de pago",
                                style: subHeadingStyle.copyWith(
                                  color: controller.orderObject.value.color==2?black:white,
                                  fontSize: 25
                                ),  
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0),
                          child: Text(
                            "${DateFormat.yMd('es_ES').format(controller.orderDateTime.value).toString()} - ${DateFormat("hh:mm a").format(controller.orderDateTime.value).toString()}",
                            style: subHeadingStyle.copyWith(
                              color: controller.orderObject.value.color==2?black:white
                            ),  
                            ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(bottom:5.0),
                          child: Row(
                            children: [
                              Icon(Icons.shopping_cart_checkout_outlined,size: iconsSize,color: controller.orderObject.value.color==2?black:white,),
                              Text(
                                "Articulos",
                                style: subHeadingStyle.copyWith(
                                  color: controller.orderObject.value.color==2?black:white,
                                  fontSize: 25
                                ),  
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height/6,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:15.0),
                            child: ListView.builder(
                                itemCount: controller.cartProducts.length,
                                itemBuilder: (_, index){
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("${controller.cartProducts[index].quantity.toString()}     x   ${controller.cartProducts[index].product.name}",
                                              style: TextStyle(
                                                color: controller.orderObject.value.color==2?black:white
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text("\$${(controller.cartProducts[index].quantity*double.parse(controller.cartProducts[index].product.price??"0")).toStringAsFixed(2)}",
                                          style: TextStyle(
                                            color: controller.orderObject.value.color==2?black:white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                            ),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:15.0),
                          child: LayoutBuilder(
                          builder:(BuildContext context, BoxConstraints constraints) {
                            return Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              direction: Axis.horizontal,
                              children: List.generate(
                                (constraints.constrainWidth()/10).floor(), (index) => SizedBox(
                                  width: 5, height: 2,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: controller.orderObject.value.color==2?black:white
                                    )
                                  ),
                                )
                              ),
                            );
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: subHeadingStyle.copyWith(
                                  color: controller.orderObject.value.color==2?black:white,
                                  fontSize: 30
                                ),  
                              ),
                              Text(
                                "\$${controller.totalToPay.value.toStringAsFixed(2)}",
                                style: headingStyle.copyWith(
                                  color: controller.orderObject.value.color==2?black:white,
                                  fontSize: 30
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) {
                                return WillPopScope(
                                  onWillPop: () async => false,
                                  child:  Center(child: CircularProgressIndicator(strokeWidth: 5,)));
                              }
                            );
                            int value = await controller.addOrder();
                            await controller.updateProductsInStock();
                            await mainController.getOrders();
                            await mainController.getItemsInStock();
                            mainController.refreshScreenFunction();
                            Get.back();
                            Get.back();
                          }, 
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical:15.0, horizontal: 15),
                            child: Text(
                              " Finalizar ",
                              style: TextStyle(
                                color: white,
                                fontSize: 20
                              ),
                              ),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.grey[300],
                            backgroundColor: controller.orderObject.value.color==0?pinkClr:
                            controller.orderObject.value.color==1?blueClr:blueClr
                          )
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15,)
              ],
            ),
          ),
        ),
      ),
    );
  }

}
