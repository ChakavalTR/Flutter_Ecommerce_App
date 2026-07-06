import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutPriceSummaryWidget extends GetView<CheckoutController> {
  const CheckoutPriceSummaryWidget({super.key});

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
        spacing: 10,
        children: [
          Text(
            'Price Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                'Subtotal: ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              Spacer(),
              Text(
                NumberFormat.currency(
                  symbol: '\$',
                  decimalDigits: 2,
                ).format(controller.subTotal),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Shipping: ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              Spacer(),
              Obx(() {
                return Text(
                  NumberFormat.currency(
                    symbol: '\$',
                    decimalDigits: 2,
                  ).format(controller.shippingFee),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                );
              }),
            ],
          ),
          Row(
            children: [
              Text(
                'Discount: ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              Spacer(),
              Text(
                '${controller.discount.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.danger,
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey.shade400, thickness: 1),
          Row(
            children: [
              Text(
                'Total: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Obx(() {
                return Text(
                  NumberFormat.currency(
                    symbol: '\$',
                    decimalDigits: 2,
                  ).format(controller.total),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
