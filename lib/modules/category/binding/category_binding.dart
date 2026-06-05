import 'package:flutter_ecommerce_app/modules/category/controller/category_controller.dart';
import 'package:flutter_ecommerce_app/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CategoryController>(() => CategoryController());
  }
}
