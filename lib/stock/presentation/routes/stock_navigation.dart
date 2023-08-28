
import 'package:app_emprendimiento/stock/presentation/getx/stock_binding.dart';
import 'package:app_emprendimiento/stock/presentation/views/pages/add_to_stock_page.dart';
import 'package:app_emprendimiento/stock/presentation/views/pages/edit_item_page.dart';
import 'package:get/get.dart';

class StockRoutes {
  static String addToStock = '/addToStock';
}

class StockPages {
  static GetPage AddToStockPageRoute = GetPage(
    name: StockRoutes.addToStock, 
    page: ()=>AddToStockPage(),
    bindings: [StockBinding(),]
  );
}