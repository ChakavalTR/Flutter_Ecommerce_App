import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';
import 'package:get/get.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  //! Build AppBar
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Checkout',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  //! Build Body
  Widget _buildBody() {
    final items = controller.checkoutItems;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
      child: ListView(
        children: [
          // Shipping Address Section
          Container(
            width: double.infinity,
            height: 120,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(left: 10, right: 5, top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppTheme.primary.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: AppTheme.primary,
                    size: 30,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Shipping Address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      '+855 12345678',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      'City, State, ZIP',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      'Cambodia',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      // Handle change address action
                    },
                    child: Text(
                      'Change',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8),
          // Payment Method Section
          Container(
            width: double.infinity,
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
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
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
                                    '\$${item.product.price}',
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
          ),

          // Shipping Fee Section
          SizedBox(height: 8),
          Obx(() {
            return Container(
              width: double.infinity,
              height: 155,
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
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      'Shipping Method',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.selectShippingMethod(0);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: controller.selectdShipping.value == 0
                            ? AppTheme.primary.withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: controller.selectdShipping.value == 0
                              ? AppTheme.primary
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.local_shipping_outlined,
                              color: AppTheme.primary,
                              size: 28,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Standard Shipping',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '5 - 7 business days',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Free',
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      controller.selectShippingMethod(1);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: controller.selectdShipping.value == 1
                            ? AppTheme.primary.withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: controller.selectdShipping.value == 1
                              ? AppTheme.primary
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.flash_on,
                              color: AppTheme.warning,
                              size: 28,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Express Shipping',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '2 - 3 business days',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '\$9.99',
                              style: TextStyle(
                                color: AppTheme.darkBg,
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
          }),
        ],
      ),
    );
  }
}
