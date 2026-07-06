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
  final discount = 0.0.obs;
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

  //------------------------------------------
  //* Calculated Properties Section *\\
  //! Subtotal
  double get subTotal {
    double total = 0;
    for (final item in checkoutItems) {
      total += item.product.price * item.quantity.value;
    }
    return total;
  }

  //! Shipping Fee
  double get shippingFee {
    return selectedShipping.value == 0 ? 0 : 9.99;
  }

  //! Discount
  double get discountAmount {
    return discount.value;
  }

  //! Total
  double get total {
    return subTotal + shippingFee - discountAmount;
  }
}
