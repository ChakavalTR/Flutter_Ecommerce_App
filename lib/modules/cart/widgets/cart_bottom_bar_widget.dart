import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/cart/controller/cart_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartBottomBarWidget extends GetView<CartController> {
  const CartBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.cartItems.isEmpty) {
        return SizedBox.shrink();
      }
      return Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, -0.1),
            ),
          ],
        ),
        child: Row(
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: 1.25,
                  child: Checkbox(
                    activeColor: AppTheme.primary,
                    checkColor: Colors.white,
                    side: BorderSide(color: Colors.grey.shade400, width: 2),
                    shape: CircleBorder(),
                    value: controller.isAllSelected,
                    onChanged: (value) {
                      controller.toggleSelectAll(value ?? false);
                    },
                  ),
                ),
                Text(
                  'Select all',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Spacer(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Total: ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: NumberFormat.currency(
                      symbol: '\$',
                      decimalDigits: 2,
                    ).format(controller.selectedTotal),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.success, // green price
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5),
            SizedBox(
              width: 135,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.selectedCount == 0) {
                    Fluttertoast.showToast(
                      msg: "Please select at least one item!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.black.withOpacity(0.8),
                      textColor: Colors.white,
                      fontSize: 16,
                    );
                    return;
                  }
                  RouteView.checkout.go(arguments: controller.selectedItems);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Proceed (${controller.selectedCount})',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
