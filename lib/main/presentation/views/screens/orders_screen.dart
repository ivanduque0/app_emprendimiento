import 'dart:convert';

import 'package:app_emprendimiento/main/presentation/getx/main_controller.dart';
import 'package:app_emprendimiento/main/presentation/routes/main_navigation.dart';
import 'package:app_emprendimiento/order/domain/models/order.dart';
import 'package:app_emprendimiento/order/domain/models/product_cart.dart';
import 'package:app_emprendimiento/order/presentation/getx/order_binding.dart';
import 'package:app_emprendimiento/order/presentation/routes/stock_navigation.dart';
import 'package:app_emprendimiento/order/presentation/views/pages/order_detail.dart';
import 'package:app_emprendimiento/services/notification_services.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:app_emprendimiento/ui/widgets/button.dart';
import 'package:app_emprendimiento/ui/widgets/order_in_list.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends GetWidget<MainController> {
  OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          _addOrderBar(),
          _addDateBar(),
          _selectOrdersToShow(),
          _showOrders(context),
        ],
      );
  }

  _selectOrdersToShow(){
    return Obx(()=>controller.refreshState.value==refreshScreen.initial?
    Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0),
      child: ToggleButtons(
          children: [
            Container(
              child: Text(
                "En espera",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),
              ),
              width: 120,
            ),
            Container(
              child: Text(
                "Completadas",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),
              ),
              width: 120,
            )
          ], 
          isSelected: controller.selectedToggledButton,
          onPressed: (index)async {
            await controller.switchToggleButtonSelected(index);
            controller.refreshScreenFunction();
          },
          borderRadius: BorderRadius.circular(20),
        ),
    ):SizedBox.shrink(),
    );
  }

  _showBottomSheet(BuildContext context, Order order){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: order.isCompleted??false?
          MediaQuery.of(context).size.height*0.40:
          MediaQuery.of(context).size.height*0.50,
        color: Get.isDarkMode?darkGreyClr:white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
              ),
            ),
            SizedBox(height: 25,),
            order.isCompleted==false?_bottomSheetButton(
              label: "Completar", 
              onTap: ()async{
                AwesomeDialog(
                  btnCancelText: "NO",
                  btnOkText: "SI",
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: mainController.isDarkMode.value?white:Colors.black,
                  ),
                  // descTextStyle: TextStyle(
                  //   fontWeight: FontWeight.bold,
                  //   fontSize: 20,
                  //   color: Colors.black
                  // ),
                  context: context,
                  animType: AnimType.bottomSlide,
                  headerAnimationLoop: false,
                  dialogType: DialogType.warning,
                  showCloseIcon: true,
                  title: "¿Desea marcar como finalizado el pedido?",
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    await controller.completeOrder(order);
                    await controller.getOrders();
                    return Get.back();
                  },
                ).show();
                
              }, 
              color: Colors.green
            ):SizedBox.shrink(),
            _bottomSheetButton(
              label: "Detalles", 
              onTap: ()async{
                List productsOrder = await jsonDecode(order.products??"[]");
                List cartProducts = [];
                for (var productOrder in productsOrder) {
                  for (var productItem in controller.itemsList) {
                    if (productOrder['product']==productItem.id) {
                      cartProducts.add(
                        ProductCart(
                          product: productItem,
                          quantity: productOrder['quantity']
                        )
                      );
                    }
                  }
                  
                }
                Get.back();
                Get.to(()=>OrderDetail(
                  cartProducts: cartProducts, 
                  order: order,
                  orderDateTime: DateTime.parse('${order.date} ${order.time}'),
                  ), 
                  binding: OrderBinding(), 
                transition: Transition.fadeIn,
                duration: Duration(milliseconds: 700));
              }, 
              color: primaryClr
            ),
            _bottomSheetButton(
              label: "Eliminar", 
              onTap: () async {
                AwesomeDialog(
                  btnCancelText: "NO",
                  btnOkText: "SI",
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: mainController.isDarkMode.value?white:Colors.black,
                  ),
                  // descTextStyle: TextStyle(
                  //   fontWeight: FontWeight.bold,
                  //   fontSize: 20,
                  //   color: Colors.black
                  // ),
                  context: context,
                  animType: AnimType.bottomSlide,
                  headerAnimationLoop: false,
                  dialogType: DialogType.warning,
                  showCloseIcon: true,
                  title: "¿Seguro que desea eliminar el pedido?",
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    await controller.deleteOrder(order.id??0);
                    await controller.getOrders();
                    Get.back();
                  },
                ).show();
                
              }, 
              color: Colors.red
            )
          ],
        ),
      )
    );
  }

  _bottomSheetButton({
    required String label,
  required Future onTap(),
  required Color color,
  bool isCLose=false}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
              child: ElevatedButton(
                onPressed: onTap, 
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:15.0, horizontal: 15),
                  child: Text(
                    " $label ",
                    style: TextStyle(
                      color: white,
                      fontSize: 20
                    ),
                    ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.grey[300],
                  backgroundColor: color,
                )
              ),
            ),
          ),
        ],
      ),
    );

  }

  _showOrders(BuildContext context){
    return Expanded(
      child: Obx(()=>controller.refreshState.value==refreshScreen.initial?Container(
        child: ListView.builder(
            itemCount: controller.ordersList.length,
            itemBuilder: (_, index){
              
                bool showCompletedOrders = controller.selectedToggledButton[1];
                DateTime orderDateTime = DateTime.parse('${controller.ordersList[index].date} ${controller.ordersList[index].time}');
                if (!showCompletedOrders&&!controller.ordersList[index].isCompleted){
                  if (DateFormat('yyyy-MM-dd').format(controller.selectedDate.value)==controller.ordersList[index].date) {
                    // if(DateFormat('yyyy-MM-dd').format(DateTime.now())==controller.ordersList[index].date){
                    //   NotifyHelper().scheduledNotification();
                    // }
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 700),
                      child: SlideAnimation(
                        //verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  _showBottomSheet(context, controller.ordersList[index]);
                                },
                                child: OrderWidget(
                                  order: controller.ordersList[index],
                                  orderDateTime: orderDateTime,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }
                if (showCompletedOrders && controller.ordersList[index].isCompleted) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 700),
                    child: SlideAnimation(
                      //verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                _showBottomSheet(context, controller.ordersList[index]);
                              },
                              child: OrderWidget(
                                order: controller.ordersList[index],
                                orderDateTime: orderDateTime,
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
            }
          ),
        ):SizedBox.shrink(),
      ),
    );
  }

  _addDateBar(){
    return Obx(()=>Container(
      margin: const EdgeInsets.only(top:20,left:20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey
          )
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: mainController.isDarkMode.value?white:Colors.black,
          )
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: mainController.isDarkMode.value?white:Colors.black,
          ),
        ),
        onDateChange: (date){
          controller.selectedDate(date);
          controller.refreshScreenFunction();
        },
      ),
    ),);
  }

  _addOrderBar(){
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Obx(()=> controller.refreshState.value==refreshScreen.initial?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd("es_ES").format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text("Hoy",
                  style: headingStyle,
                )
              ],
            ):SizedBox.shrink(),
            ),
          ),
          MyButton(label: "Agregar Pedido", onTap: (){
            Get.toNamed(OrderRoutes.addOrder);
            })
        ],
      ),
    );
  }
}