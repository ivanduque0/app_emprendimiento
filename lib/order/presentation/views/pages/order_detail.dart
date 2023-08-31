import 'package:app_emprendimiento/order/presentation/getx/order_controller.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetail extends GetWidget<OrderController> {
  OrderDetail({super.key,
  required this.cartProducts,
  required this.order,
  required this.orderDateTime
  });

  final cartProducts;
  final order;
  final orderDateTime;

  List colors = [primaryClr,pinkClr,yellowClr];
  double iconsSize = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.orderStep.value==OrderStep.selectItems?black:null,
        appBar: _appBar(controller),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: colors[order.color??0],
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
                              Icon(Icons.person,size: iconsSize,color: order.color==2?black:white,),
                              Text(
                                "Nombre",
                                style: subHeadingStyle.copyWith(
                                  color: order.color==2?black:white,
                                  fontSize: 25
                                ),  
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0),
                          child: Text(
                            "${order.name}",
                            style: subHeadingStyle.copyWith(
                              color: order.color==2?black:white
                            ),  
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(bottom:5.0),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_month,size: iconsSize,color: order.color==2?black:white,),
                              Text(
                                "Fecha de pago",
                                style: subHeadingStyle.copyWith(
                                  color: order.color==2?black:white,
                                  fontSize: 25
                                ),  
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0),
                          child: Text(
                            "${DateFormat.yMd('es_ES').format(orderDateTime).toString()} - ${DateFormat("hh:mm a").format(orderDateTime).toString()}",
                            style: subHeadingStyle.copyWith(
                              color: order.color==2?black:white
                            ),  
                            ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.only(bottom:5.0),
                          child: Row(
                            children: [
                              Icon(Icons.shopping_cart_checkout_outlined,size: iconsSize,color: order.color==2?black:white,),
                              Text(
                                "Articulos",
                                style: subHeadingStyle.copyWith(
                                  color: order.color==2?black:white,
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
                                itemCount: cartProducts.length,
                                itemBuilder: (_, index){
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("${cartProducts[index].quantity.toString()}     x   ${cartProducts[index].product.name}",
                                              style: TextStyle(
                                                color: order.color==2?black:white
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text("\$${(cartProducts[index].quantity*double.parse(cartProducts[index].product.price??"0")).toStringAsFixed(2)}",
                                          style: TextStyle(
                                            color: order.color==2?black:white,
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
                                      color: order.color==2?black:white
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
                                  color: order.color==2?black:white,
                                  fontSize: 30
                                ),  
                              ),
                              Text(
                                "\$${order.toPay}",
                                style: headingStyle.copyWith(
                                  color: order.color==2?black:white,
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
                            Get.back();
                          }, 
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical:15.0, horizontal: 15),
                            child: Text(
                              " Regresar ",
                              style: TextStyle(
                                color: white,
                                fontSize: 20
                              ),
                              ),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.grey[300],
                            backgroundColor: order.color==0?pinkClr:
                            order.color==1?blueClr:blueClr
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

_appBar(OrderController controller){
    return AppBar(
        title: Text("Detalles del pedido",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),
            ),
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