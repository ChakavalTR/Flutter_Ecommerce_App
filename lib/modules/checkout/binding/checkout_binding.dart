import 'package:flutter_ecommerce_app/modules/order/controller/order_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(() => CheckoutController());
    Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
  }
}
