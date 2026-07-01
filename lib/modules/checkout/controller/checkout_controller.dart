import 'package:flutter_ecommerce_app/modules/cart/model/cart_model.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  //* Variables Section *\\
  late final List<CartModel> checkoutItems;
  final selectedShipping = 0.obs;
  final selectedPaymentMethod = 0.obs;
  final List<String> creditCardImages = [
    'assets/icons/visa_icon.png',
    'assets/icons/mastercard_icon.png',
  ];
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
    selectedShipping.value = index;
  }

  //! Select Payment Method
  void selectPaymentMethod(int index) {
    selectedPaymentMethod.value = index;
  }

  double get shippingFee {
    return selectedShipping.value == 0 ? 0 : 9.99;
  }
}
