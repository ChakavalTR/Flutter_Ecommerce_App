import 'package:flutter_ecommerce_app/modules/favorite/controller/favorite_controller.dart';
import 'package:get/get.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoriteController(), permanent: true);
  }
}
