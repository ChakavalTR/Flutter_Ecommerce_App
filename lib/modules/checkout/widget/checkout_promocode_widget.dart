import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';

class CheckoutPromoCodeWidget extends GetView<CheckoutController> {
  const CheckoutPromoCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Promo Code',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter promo code',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: AppTheme.primary,
                        width: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    Get.closeCurrentSnackbar();
                  });
                  Get.snackbar(
                    'Coming Soon',
                    'Share product feature is coming soon!',
                    backgroundColor: AppTheme.primary,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: Text(
                  'Apply',
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
