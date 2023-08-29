import 'package:app_emprendimiento/main/presentation/getx/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color blueClr = Color(0xff4e5ae8);
const Color yellowClr = Color(0xffffb746);
const Color pinkClr = Color(0xffff4667);
const Color purpleClr = Color.fromARGB(255, 163, 70, 255);
const Color white = Colors.white;
const Color black = Colors.black;
const Color primaryClr = blueClr;
const Color darkGreyClr = Color(0xff121212);
const Color lightGreyClr = Color.fromARGB(255, 210, 210, 210);
Color darkHeaderClr = Color(0xff424242);

MainController mainController = Get.find();

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    appBarTheme: AppBarTheme(
      color: white
    ),
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryClr),
    useMaterial3: true,
  );

  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    appBarTheme: AppBarTheme(
      color: darkGreyClr
    ),
    brightness: Brightness.dark,
    useMaterial3: true,
  );
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color:mainController.isDarkMode.value?Colors.grey[400]:Colors.grey
    )
  );
}

TextStyle get headingStyle{
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color:mainController.isDarkMode.value?white:black
    )
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color:mainController.isDarkMode.value?white:black
    )
  );
}

TextStyle get titleStyleStock{
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color:Colors.black
    )
  );
}

TextStyle get subTitleStyle{
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color:mainController.isDarkMode.value?Colors.grey[100]:Colors.grey[600]
    )
  );
}

TextStyle get subTitleStyleItem{
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color:black
    )
  );
}

TextStyle get priceStyleItem{
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color:black
    )
  );
}

TextStyle get tasaStyle{
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color:Colors.green[600]
    )
  );
}

TextStyle get calculoStyle{
  return GoogleFonts.lato (
    textStyle: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color:primaryClr
    )
  );
}