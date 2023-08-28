import 'package:app_emprendimiento/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? textController;
  final Widget? widget;
  final bool? onlyNumbers;
  const MyInputField({super.key, 
    required this.title, 
    required this.hint,
    this.textController,
    this.widget,
    this.onlyNumbers
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
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
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget==null?false:true,
                    autofocus: false,
                    cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                    controller: textController,
                    style: subTitleStyle,
                    keyboardType: onlyNumbers==true?TextInputType.number:null,
                    inputFormatters: onlyNumbers==true?<TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                    ]:[], 
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: hint,
                      hintStyle: subTitleStyle
                    ),
                  ),
                ),
                widget==null?
                SizedBox.shrink():
                Container(
                  child: widget
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}