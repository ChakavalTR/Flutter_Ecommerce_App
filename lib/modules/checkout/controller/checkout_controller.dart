import 'package:flutter_ecommerce_app/modules/cart/model/cart_model.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  //* Variables Section *\\
  late final List<CartModel> checkoutItems;
  //-------------------------------------------
  //* Lifecycle Section *\\
  @override
  void onInit() {
    super.onInit();
    checkoutItems = (Get.arguments as List<CartModel>?) ?? [];
  }

  //-------------------------------------------
  //* Functions Section*\\
}
