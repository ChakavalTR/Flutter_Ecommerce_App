import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/cart/widgets/cart_bottom_bar_widget.dart';
import 'package:flutter_ecommerce_app/modules/detail/controller/detail_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app/modules/cart/controller/cart_controller.dart';
import 'package:intl/intl.dart';

class CartView extends GetView<CartController> {
  final bool isFromBottomTab;
  const CartView({super.key, this.isFromBottomTab = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: isFromBottomTab ? 0 : kBottomNavigationBarHeight,
        ),
        child: CartBottomBarWidget(),
      ),
    );
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
          Expanded(
            child: Scrollbar(
              radius: Radius.circular(15),
              thickness: 5,
              child: NotificationListener<ScrollUpdateNotification>(
                onNotification: (notification) {
                  if ((notification.scrollDelta ?? 0).abs() > 3) {
                    controller.closeEditingQuantity();
                  }
                  return false;
                },
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = controller.cartItems[index];
                    return Slidable(
                      key: ValueKey(cartItem.product.id),
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        extentRatio: 0.25,
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              controller.removeItem(index);
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (cartItem.isEditingQty.value ||
                              cartItem.isInputQty.value) {
                            return;
                          }
                          controller.closeEditingQuantity();
                          if (Get.isRegistered<DetailController>()) {
                            Get.delete<DetailController>();
                          }
                          RouteView.detail.go(arguments: cartItem.product);
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
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey[300],
                                        child: Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
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
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        if (cartItem.selectedStorage !=
                                            null) ...[
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
                                        Obx(() {
                                          if (!cartItem.isEditingQty.value) {
                                            return GestureDetector(
                                              onTap: () {
                                                cartItem.isEditingQty.value =
                                                    true;
                                              },
                                              child: Container(
                                                width: 55,
                                                height: 36,
                                                margin: EdgeInsets.only(
                                                  right: 10,
                                                ),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: Colors.grey.shade200,
                                                  ),
                                                ),
                                                child: Text(
                                                  'x${cartItem.quantity.value}',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          return GestureDetector(
                                            onTap: () {
                                              cartItem.isEditingQty.value =
                                                  true;
                                            },
                                            behavior:
                                                HitTestBehavior.translucent,
                                            child: Container(
                                              width: 120,
                                              height: 40,
                                              margin: const EdgeInsets.only(
                                                right: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
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
                                                      if (cartItem
                                                              .quantity
                                                              .value >
                                                          1) {
                                                        controller
                                                            .decreaseQuantity(
                                                              index,
                                                            );
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.remove,
                                                      color:
                                                          cartItem
                                                                  .quantity
                                                                  .value >
                                                              1
                                                          ? Colors.red
                                                          : Colors.grey,
                                                      size: 22,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${cartItem.quantity.value}',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .increaseQuantity(
                                                            index,
                                                          );
                                                    },
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: Colors.green,
                                                      size: 22,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
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
