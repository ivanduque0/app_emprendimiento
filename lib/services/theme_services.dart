import 'package:app_emprendimiento/main/presentation/getx/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';


  _saveThemeToBox(bool isDarkMode) {
    MainController mainController = Get.find();
    _box.write(_key, isDarkMode);
    mainController.isDarkMode(isDarkMode);
    mainController.refreshScreenFunction();
    }

  bool _loadThemeFromBox()=>_box.read(_key)??false;
  ThemeMode get theme=>_loadThemeFromBox()?ThemeMode.dark:ThemeMode.light;

  void switchThemeMode(){
    Get.changeThemeMode(_loadThemeFromBox()?ThemeMode.light:ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}