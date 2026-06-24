import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/detail/controller/detail_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app/modules/cart/controller/cart_controller.dart';
import 'package:intl/intl.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar, body: _buildBody);
  }

  //! Build AppBar
  AppBar get _buildAppBar {
    return AppBar(
      actions: [
        Obx(() {
          if (!controller.hasSelectedItems) {
            return SizedBox.shrink();
          }
          return TextButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(
                    'Are you sure want to clear all?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  // content: Text(
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        controller.clearCart();
                      },
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'Clear All',
              style: TextStyle(
                color: AppTheme.danger,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          );
        }),
      ],
      title: Text(
        'Cart',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  //! Build Body
  Widget get _buildBody {
    return Obx(() {
      if (controller.cartItems.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 100,
                color: Colors.grey[400],
              ),
              SizedBox(height: 16),
              Text(
                'Your Cart is Empty',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        );
      }
      return Column(
        children: [
          SizedBox(
            height: 608,
            child: Scrollbar(
              radius: Radius.circular(15),
              thickness: 5,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = controller.cartItems[index];
                  return GestureDetector(
                    onTap: () {
                      if (Get.isRegistered<DetailController>()) {
                        Get.delete<DetailController>();
                      }
                      RouteView.detail.go(
                        arguments: {
                          'product': cartItem.product,
                          'color': cartItem.color,
                          'storage': cartItem.selectedStorage,
                        },
                      );
                    },
                    child: Container(
                      height: 125,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Obx(() {
                            return Transform.scale(
                              scale: 1.25,
                              child: Checkbox(
                                activeColor: AppTheme.primary,
                                checkColor: Colors.white,
                                side: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 2,
                                ),
                                shape: CircleBorder(),
                                value: cartItem.isSelected.value,
                                onChanged: (value) {
                                  controller.toggleSelectItem(index);
                                },
                              ),
                            );
                          }),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: cartItem.product.image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: 100,
                                height: 100,
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
                                width: 100,
                                height: 100,
                                color: Colors.grey[300],
                                child: Center(
                                  child: Icon(Icons.error, color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItem.product.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 14,
                                      decoration: BoxDecoration(
                                        color: cartItem.color,
                                        shape: BoxShape.rectangle,
                                        border: Border.all(color: Colors.grey),
                                      ),
                                    ),
                                    if (cartItem.selectedStorage != null) ...[
                                      SizedBox(width: 8),
                                      Text(
                                        cartItem.selectedStorage!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      NumberFormat.currency(
                                        symbol: '\$',
                                        decimalDigits: 2,
                                      ).format(cartItem.product.price),
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: AppTheme.success,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      width: 120,
                                      height: 40,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              controller.decreaseQuantity(
                                                index,
                                              );
                                            },
                                            icon: Icon(
                                              Icons.remove,
                                              color: Colors.red,
                                              size: 24,
                                            ),
                                          ),
                                          Obx(
                                            () => Text(
                                              cartItem.quantity.value
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              controller.increaseQuantity(
                                                index,
                                              );
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              color: Colors.green,
                                              size: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Spacer(),
          Container(
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
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.warning,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Proceed (${controller.selectedCount})',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 10),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Subtotal :',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.grey[500],
          //             ),
          //           ),
          //           Obx(
          //             () => Text(
          //               NumberFormat.currency(
          //                 symbol: '\$',
          //                 decimalDigits: 2,
          //               ).format(controller.subtotal),
          //               style: TextStyle(
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.bold,
          //                 color: Colors.grey[500],
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(height: 8),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Shipping : ',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.grey[500],
          //             ),
          //           ),
          //           Text(
          //             NumberFormat.currency(
          //               symbol: '\$',
          //               decimalDigits: 2,
          //             ).format(controller.shipping),
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.grey[500],
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(height: 8),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Discount : ',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.grey[500],
          //             ),
          //           ),
          //           Text(
          //             NumberFormat.currency(
          //               symbol: '-\$\$',
          //               decimalDigits: 2,
          //             ).format(controller.discount),
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: AppTheme.danger,
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(height: 8),
          //       Divider(color: Colors.grey[400], thickness: 1),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Total : ',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.black,
          //             ),
          //           ),
          //           Obx(
          //             () => Text(
          //               NumberFormat.currency(
          //                 symbol: '\$',
          //                 decimalDigits: 2,
          //               ).format(controller.total),
          //               style: TextStyle(
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.bold,
          //                 color: Colors.black,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 10),
          // Container(
          //   width: double.infinity,
          //   margin: const EdgeInsets.symmetric(horizontal: 16),
          //   child: ElevatedButton(
          //     onPressed: () {},
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(Icons.payment, size: 26),
          //         SizedBox(width: 10),
          //         Text('Proceed to Checkout'),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      );
    });
  }
}
