

import 'package:app_emprendimiento/main/presentation/getx/main_binding.dart';
import 'package:app_emprendimiento/main/presentation/views/main_page.dart';
import 'package:get/get.dart';

class MainRoutes {
  static String main = '/main';
}

class MainPages {
  static GetPage MainPageRoute = GetPage(
    name: MainRoutes.main, 
    page: ()=>MainPage(),
    bindings: [MainBinding(),]
  );
}