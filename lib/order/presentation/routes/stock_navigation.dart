
import 'package:app_emprendimiento/order/presentation/getx/order_binding.dart';
import 'package:app_emprendimiento/order/presentation/views/pages/order_page.dart';
import 'package:get/get.dart';

class OrderRoutes {
  static String addOrder = '/addOrder';
}

class OrderPages {
  static GetPage AddOrderPageRoute = GetPage(
    name: OrderRoutes.addOrder, 
    page: ()=>OrderPage(),
    bindings: [OrderBinding(),]
  );
}