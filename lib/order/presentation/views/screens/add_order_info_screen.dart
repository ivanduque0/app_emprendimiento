import 'package:app_emprendimiento/main/presentation/getx/main_controller.dart';
import 'package:app_emprendimiento/order/presentation/getx/order_controller.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:app_emprendimiento/ui/widgets/button.dart';
import 'package:app_emprendimiento/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddOrderInfoScreen extends GetWidget<OrderController> {

  List<int> remindTimeList = [5,10,15,20];
  MainController mainController = Get.find();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.changeOrderStep(OrderStep.selectItems);
        return false;
      },
      child: Container(
          padding: const EdgeInsets.only(left:20, right:20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Informacion del pedido",
                  style: headingStyle,
                ),
                MyInputField(title: "Nombre", hint:"ingrese nombre"),
                //MyInputField(title: "articulo", hint:"ingrese el articulo"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(()=> mainController.refreshState.value==refreshScreen.initial?Expanded(
                      child: MyInputField(
                        title: "Fecha a pagar", 
                        hint:controller.orderDateSelected.value?DateFormat.yMd('es_ES').format(controller.orderDateTime.value).toString():"dd/mm/aaaa", 
                        widget: IconButton(
                          onPressed: (){
                            _getDateFromUser(context);
                          },
                          icon: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey,
                          )
                        )),
                    ):SizedBox.shrink()
                    ),
                    SizedBox(width:10),
                    Obx(()=> mainController.refreshState.value==refreshScreen.initial?Expanded(
                      child: MyInputField(
                        title: "Hora a pagar", 
                        hint:DateFormat("hh:mm a").format(controller.orderDateTime.value).toString(), 
                        widget: IconButton(
                          onPressed: (){
                            _getTimeFromUser(context);
                          },
                          icon: Icon(
                            Icons.access_time_filled_rounded,
                            color: Colors.grey,
                          )
                        )),
                    ):SizedBox.shrink()
                    ),
                  ],
                ),
                Obx(()=>MyInputField(
                    title: "Recordatorio", 
                    hint:"${controller.selectedRemindTime.value} minutos antes",
                    widget: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        padding: EdgeInsets.only(right:7),
                        icon: Icon(Icons.keyboard_arrow_down_outlined,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        style: subTitleStyle,
                        items: remindTimeList.map<DropdownMenuItem<String>>((int value) {
                          return DropdownMenuItem<String>(
                            child: Text(value.toString()),
                            value: value.toString()
                          );
                        }).toList(),
                        onChanged:(value) {
                          controller.selectedRemindTime(int.parse(value!));
                          mainController.refreshScreenFunction();
                        },
                      ),
                    )
                  ),
                ),
                SizedBox(height: 18,),
                _colorPallette(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButton(
                          label: "Siguiente", 
                          onTap: (){}),
                  ],
                )
                
              ],
            ),
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