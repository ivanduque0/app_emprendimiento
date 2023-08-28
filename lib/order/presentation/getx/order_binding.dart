import 'package:app_emprendimiento/order/data/api_order_impl.dart';
import 'package:app_emprendimiento/order/data/local_order_impl.dart';
import 'package:app_emprendimiento/order/domain/repositories/api_order_repository.dart';
import 'package:app_emprendimiento/order/domain/repositories/local_order_repository.dart';
import 'package:app_emprendimiento/order/presentation/getx/order_controller.dart';
import 'package:get/get.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalOrderInterface>(() => LocalOrderImplementation());
    Get.lazyPut<ApiOrderInterface>(() => ApiOrderImplementation());
    Get.lazyPut(() => OrderController(
      localOrderInterface: Get.find(), 
      apiOrderInterface: Get.find(), 
    ));
  }
}