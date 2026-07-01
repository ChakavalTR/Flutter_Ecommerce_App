import 'package:flutter_ecommerce_app/modules/cart/model/cart_model.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  //* Variables Section *\\
  late final List<CartModel> checkoutItems;
  final selectdShipping = 0.obs;
  //-------------------------------------------
  //* Lifecycle Section *\\
  @override
  void onInit() {
    super.onInit();
    checkoutItems = (Get.arguments as List<CartModel>?) ?? [];
  }

  //-------------------------------------------
  //* Functions Section*\\
  //! Select Shipping Method
  void selectShippingMethod(int index) {
    selectdShipping.value = index;
  }

  double get shippingFee {
    return selectdShipping.value == 0 ? 0 : 9.99;
  }
}
