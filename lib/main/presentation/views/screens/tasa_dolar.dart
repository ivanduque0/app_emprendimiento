import 'package:app_emprendimiento/main/presentation/getx/main_controller.dart';
import 'package:app_emprendimiento/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TasaDolarScreen extends GetWidget<MainController> {

  static String formatCurrency(num value,{int fractionDigits = 2}) {
    ArgumentError.checkNotNull(value, 'value');

    // convert cents into hundreds.
    value = value / 100;

    return NumberFormat.currency(
      customPattern: '###.##',
        // using Netherlands because this country also
        // uses the comma for thousands and dot for decimal separators.
      locale: 'en_US'
    ).format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>controller.refreshState.value==refreshScreen.initial?
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Text("Tasa Actual\ndel dolar paralelo",
              style: headingStyle,
              textAlign: TextAlign.center,),
              SizedBox(height: 30,),
              Text("${controller.tasaDolar.value} Bs.",
              style: tasaStyle,),
              SizedBox(height:80),
              Text("Calculadora",style: headingStyle,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: 52,
                  margin: EdgeInsets.only(top:8.0),
                  padding: EdgeInsets.only(left: 14),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0
                    ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: TextFormField(
                    readOnly: false,
                    autofocus: false,
                    cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                    controller: controller.calculatorTextController,
                    style: subTitleStyle,
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) {
                      // remove characters to convert the value to double (because one of those may appear in the keyboard)
                      String newText = newValue.text
                          .replaceAll('.', '')
                          .replaceAll(',', '')
                          .replaceAll('_', '')
                          .replaceAll('-', '');
                      String value = newText;
                      int cursorPosition = newText.length;
                      if (newText.isNotEmpty) {
                        value = formatCurrency(double.parse(newText), fractionDigits: 0);
                        cursorPosition = value.length;
                      }
                      return TextEditingValue(
                          text: value,
                          selection: TextSelection.collapsed(offset: cursorPosition)
                      );
                    }),
                    ],
                    //textAlign: TextAlign.right,

                    
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "Ingrese una cantidad de dolares",
                      hintStyle: subTitleStyle
                    ),
                    onChanged:(value) {
                      double cantidad = double.parse(value);
                      controller.calculoDolar(cantidad*controller.tasaDolar.value);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:20.0, bottom:50),
                child: Text("${controller.calculoDolar.value.toStringAsFixed(2)} Bs.",
                  style: calculoStyle,
                ),
              ),
            ],
          )
        ),
      ):
      SizedBox.shrink(),
    );
  }
}