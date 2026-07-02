import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:get/get.dart';

class CheckoutPaymentWidget extends GetView<CheckoutController> {
  const CheckoutPaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 10),
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                'Payment Method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.selectedPaymentMethod.value = 0;
              },
              child: Container(
                width: double.infinity,
                height: 55,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: controller.selectedPaymentMethod.value == 0
                      ? AppTheme.primary.withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: controller.selectedPaymentMethod.value == 0
                        ? AppTheme.primary
                        : Colors.grey.shade300,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.credit_card, size: 28, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        'Credit / Debit Card',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      ...List.generate(controller.creditCardImages.length, (
                        index,
                      ) {
                        return Container(
                          width: 35,
                          height: 30,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Image.asset(
                            controller.creditCardImages[index],
                            fit: BoxFit.contain,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.selectedPaymentMethod.value = 1;
              },
              child: Container(
                width: double.infinity,
                height: 55,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: controller.selectedPaymentMethod.value == 1
                      ? AppTheme.primary.withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: controller.selectedPaymentMethod.value == 1
                        ? AppTheme.primary
                        : Colors.grey.shade300,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.local_atm, size: 28, color: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        'Cash on Delivery',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
