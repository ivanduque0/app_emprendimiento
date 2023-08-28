import 'package:app_emprendimiento/main/presentation/getx/main_controller.dart';
import 'package:app_emprendimiento/main/presentation/routes/main_navigation.dart';
import 'package:app_emprendimiento/order/presentation/routes/stock_navigation.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:app_emprendimiento/ui/widgets/button.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends GetWidget<MainController> {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          _addOrderBar(),
          _addDateBar(),
        ],
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