import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:get/get.dart';

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
              child: Obx(() {
                final isProcessing = controller.isProcessingPayment.value;
                return ElevatedButton(
                  onPressed: isProcessing ? null : controller.processPayment,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55),
                    backgroundColor: isProcessing
                        ? Colors.grey
                        : AppTheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isProcessing)
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        ),
                      if (isProcessing) SizedBox(width: 10),
                      Text(
                        isProcessing ? 'Processing...' : 'Pay Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
