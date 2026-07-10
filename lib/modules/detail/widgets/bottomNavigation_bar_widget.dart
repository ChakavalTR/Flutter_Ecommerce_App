// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/modules/cart/controller/cart_controller.dart';
import 'package:flutter_ecommerce_app/modules/cart/model/cart_model.dart';
import 'package:flutter_ecommerce_app/modules/detail/controller/detail_controller.dart';
import 'package:get/get.dart';

class BottomnavigationBarWidget extends GetView<DetailController> {
  BottomnavigationBarWidget({super.key});
  final detailController = Get.find<DetailController>();
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(color: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    cartController.addToCart(
                      product: detailController.product,
                      selectedColor: detailController
                          .colorsOption[detailController.selectedColors.value],
                      selectedStorage: detailController.showStorage
                          ? detailController.storagesOption[detailController
                                .selectedStorage
                                .value]
                          : null,
                      quantity: detailController.quantity.value,
                    );
                    detailController.quantity.value = 1;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    final checkoutItems = CartModel(
                      product: detailController.product,
                      color: detailController
                          .colorsOption[detailController.selectedColors.value],
                      selectedStorage: detailController.showStorage
                          ? detailController.storagesOption[detailController
                                .selectedStorage
                                .value]
                          : null,
                      quantity: detailController.quantity.value,
                    );
                    RouteView.checkout.go(arguments: [checkoutItems]);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    'Pay Now',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            // Container(
            //   width: 140,
            //   height: 55,
            //   decoration: BoxDecoration(
            //     color: Colors.grey[200],
            //     borderRadius: BorderRadius.circular(15),
            //     border: Border.all(color: Colors.green, width: 1),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       IconButton(
            //         onPressed: () {
            //           if (controller.quantity.value > 1) {
            //             controller.quantity.value--;
            //           }
            //         },
            //         icon: Icon(Icons.remove, color: Colors.red, size: 28),
            //       ),
            //       SizedBox(width: 8),
            //       Obx(() {
            //         return Text(
            //           controller.quantity.value.toString(),
            //           style: TextStyle(
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         );
            //       }),
            //       SizedBox(width: 8),
            //       IconButton(
            //         onPressed: () {
            //           controller.quantity.value++;
            //         },
            //         icon: Icon(Icons.add, color: Colors.green, size: 28),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
