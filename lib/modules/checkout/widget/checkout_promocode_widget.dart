import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';

class CheckoutPromoCodeWidget extends GetView<CheckoutController> {
  const CheckoutPromoCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                    controller: controller.promoCodeController,
                    enabled: !controller.isPromoCodeApplied.value,
                    textCapitalization: TextCapitalization.characters,
                    onSubmitted: (value) {
                      controller.applyPromoCode();
                    },
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
                  onPressed: controller.isPromoCodeApplied.value
                      ? controller.removePromoCode
                      : controller.applyPromoCode,
                  child: Text(
                    controller.isPromoCodeApplied.value ? 'Remove' : 'Apply',
                    style: TextStyle(
                      color: controller.isPromoCodeApplied.value
                          ? Colors.red
                          : AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if (controller.isPromoCodeApplied.value) ...[
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Promo code applied! You got a discount of ${controller.discount.value.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}
