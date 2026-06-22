import 'package:flutter_ecommerce_app/modules/cart/controller/cart_controller.dart';
import 'package:flutter_ecommerce_app/modules/category/controller/category_controller.dart';
import 'package:flutter_ecommerce_app/modules/favorite/controller/favorite_controller.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.put(FavoriteController(), permanent: true);
    Get.put(CartController(), permanent: true);
  }
}
