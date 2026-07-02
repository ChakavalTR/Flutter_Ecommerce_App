import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:intl/intl.dart';

class CheckoutItemsWidget extends GetView<CheckoutController> {
  const CheckoutItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = controller.checkoutItems;
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
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
            child: Text(
              'Items (${items.length})',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: List.generate(items.length, (index) {
              final item = items[index];
              return Column(
                spacing: 5,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: CachedNetworkImage(
                          imageUrl: item.product.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 90,
                            height: 90,
                            color: Colors.grey[300],
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  AppTheme.primary,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 90,
                            height: 90,
                            color: Colors.grey[300],
                            child: Icon(Icons.error, color: Colors.red),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: item.color,
                                    shape: BoxShape.rectangle,
                                    border: Border.all(color: Colors.grey),
                                  ),
                                ),
                                if (item.selectedStorage != null) ...[
                                  SizedBox(width: 8),
                                  Text(
                                    item.selectedStorage!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              NumberFormat.currency(
                                symbol: '\$',
                                decimalDigits: 2,
                              ).format(item.product.price),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 55,
                        height: 36,
                        margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Text(
                          'x${item.quantity.value}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (index != items.length - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                      color: Colors.grey.shade300,
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
