import 'package:app_emprendimiento/main/data/api_main_impl.dart';
import 'package:app_emprendimiento/main/data/local_main_impl.dart';
import 'package:app_emprendimiento/main/domain/repositories/api_main_repository.dart';
import 'package:app_emprendimiento/main/domain/repositories/local_main_repository.dart';
import 'package:app_emprendimiento/main/presentation/getx/main_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalMainInterface>(() => LocalMainImplementation());
    Get.lazyPut<ApiMainInterface>(() => ApiMainImplementation());
    Get.lazyPut(() => MainController(
      localMainInterface: Get.find(), 
      apiMainInterface: Get.find(), 
    ));
  }
}