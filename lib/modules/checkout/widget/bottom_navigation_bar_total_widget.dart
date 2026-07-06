import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BottomNavigationBarTotalWidget extends GetView<CheckoutController> {
  const BottomNavigationBarTotalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 10,
          top: 10,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Detail: ${controller.checkoutItems.length} item in total',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Discount: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${controller.discount.toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: AppTheme.danger,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pay ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => Text(
                        NumberFormat.currency(
                          symbol: '\$',
                          decimalDigits: 2,
                        ).format(controller.total),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      ' Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
