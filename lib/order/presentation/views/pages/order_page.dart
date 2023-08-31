import 'package:app_emprendimiento/order/presentation/getx/order_controller.dart';
import 'package:app_emprendimiento/order/presentation/views/screens/add_order_info_screen.dart';
import 'package:app_emprendimiento/order/presentation/views/screens/save_order_screen.dart';
import 'package:app_emprendimiento/order/presentation/views/screens/select_products_screen.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPage extends GetWidget<OrderController> {

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
        backgroundColor: controller.orderStep.value==OrderStep.selectItems?black:null,
        appBar: _appBar(controller),
        body: Container(
          //padding: const EdgeInsets.only(left:20, right:20),
          child: controller.orderStep.value==OrderStep.selectItems?SelectProductsScreen():
            controller.orderStep.value==OrderStep.setOrderInfo?AddOrderInfoScreen():
            SaveOrderScreen()

          
        ),
      ),
    );
  }

  _colorPallette(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",
          style: titleStyle,
        ),
        SizedBox(height: 8.0,),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index){
              return GestureDetector(
                onTap: (){
                  controller.selectedColor(index);
                  mainController.refreshScreenFunction();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right:8.0),
                  child: Obx(()=>CircleAvatar(
                    radius: 17,
                    backgroundColor: index==0?primaryClr:index==1?pinkClr:yellowClr,
                    child: controller.selectedColor.value==index?Icon(Icons.done,
                    color: white,
                    size: 20,
                    ):null,
                  )),
                ),
              );
            }
          ),
        )
      ],
    );
  }

  _appBar(OrderController controller){
    return AppBar(
        title: Obx(() => Text(
            controller.orderStep.value==OrderStep.selectItems?"Añadir productos al carrito":
            controller.orderStep.value==OrderStep.setOrderInfo?"Informacion del pedido":
            "Resumen del pedido",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),
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

  _getDateFromUser(BuildContext context) async {
    DateTime? _pickerDate = await showDatePicker(
      locale: const Locale("es"),
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime.now(), 
      lastDate: DateTime(DateTime.now().year+2), 
    );

    if (_pickerDate!=null) {
      controller.orderDateSelected(true);
      DateTime updatedOrderDateTime = DateTime(_pickerDate.year, _pickerDate.month, _pickerDate.day, controller.orderDateTime.value.hour, controller.orderDateTime.value.minute);
      controller.orderDateTime(updatedOrderDateTime);
      mainController.refreshScreenFunction();
    }
  }

  _getTimeFromUser(BuildContext context) async {
    TimeOfDay? _pickerTime = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.fromDateTime(controller.orderDateTime.value)
    );

    if (_pickerTime!=null) {
      DateTime updatedOrderDateTime = DateTime(controller.orderDateTime.value.year, controller.orderDateTime.value.month, controller.orderDateTime.value.day, _pickerTime.hour, _pickerTime.minute);
      controller.orderDateTime(updatedOrderDateTime);
      mainController.refreshScreenFunction();
    }

  }
}