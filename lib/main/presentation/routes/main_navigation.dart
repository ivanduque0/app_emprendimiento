

import 'package:app_emprendimiento/main/presentation/getx/main_binding.dart';
import 'package:app_emprendimiento/main/presentation/views/main_page.dart';
import 'package:app_emprendimiento/main/presentation/views/pages/add_order_page.dart';
import 'package:get/get.dart';

class MainRoutes {
  static String main = '/main';
  static String addOrder = '/addOrder';
}

class MainPages {
  static GetPage MainPageRoute = GetPage(
    name: MainRoutes.main, 
    page: ()=>MainPage(),
    bindings: [MainBinding(),]
  );
  static GetPage AddOrderPageRoute = GetPage(
    name: MainRoutes.addOrder, 
    page: ()=>AddOrderPage(),
  );
}