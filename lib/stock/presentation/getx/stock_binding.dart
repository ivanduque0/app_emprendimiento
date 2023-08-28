import 'package:app_emprendimiento/stock/data/api_stock_impl.dart';
import 'package:app_emprendimiento/stock/data/local_stock_impl.dart';
import 'package:app_emprendimiento/stock/domain/repositories/api_stock_repository.dart';
import 'package:app_emprendimiento/stock/domain/repositories/local_stock_repository.dart';
import 'package:app_emprendimiento/stock/presentation/getx/stock_controller.dart';
import 'package:get/get.dart';

class StockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalStockInterface>(() => LocalStockImplementation());
    Get.lazyPut<ApiStockInterface>(() => ApiStockImplementation());
    Get.lazyPut(() => StockController(
      localStockInterface: Get.find(), 
      apiStockInterface: Get.find(), 
    ));
  }
}