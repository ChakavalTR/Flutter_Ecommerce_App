import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';

class ShippingAddressView extends GetView<CheckoutController> {
  const ShippingAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody);
  }

  //! Build AppBar
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Shipping Address',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.add, size: 30),
          onPressed: () {
            RouteView.addEditAddress.go();
          },
        ),
      ],
    );
  }

  //! Build Body
  Padding get _buildBody {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on,
                  color: AppTheme.primary,
                  size: 40,
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    'Manage your address',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Choose a shipping address for your order',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          Expanded(
            child: Obx(() {
              if (controller.shippingAddress.isEmpty) {
                return Center(
                  child: Text(
                    'No Shipping address yet',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.shippingAddress.length,
                itemBuilder: (context, index) {
                  final address = controller.shippingAddress[index];
                  return Obx(() {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedAddressIndex.value = index;
                      },
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: StretchMotion(),
                          extentRatio: 0.50,
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                controller.editShippingAddress(address);
                              },
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Edit',
                              borderRadius: BorderRadius.circular(15),
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                controller.deleteShippingAddress(index);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ],
                        ),
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color:
                                  controller.selectedAddressIndex.value == index
                                  ? AppTheme.primary
                                  : Colors.grey.withOpacity(0.3),
                              width:
                                  controller.selectedAddressIndex.value == index
                                  ? 1.5
                                  : 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  controller.selectedAddressIndex.value == index
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (address.isDefault)
                                          Container(
                                            margin: EdgeInsets.only(bottom: 6),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppTheme.primary
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              'Default',
                                              style: TextStyle(
                                                color: AppTheme.primary,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        Text(
                                          address.fullName,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          address.phone,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Text(
                                          '${address.address}\n${address.city}\n${address.postalCode}\n${address.country}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                },
              );
            }),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your information is safe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'We only use your address to deliver your order',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'and will never share it with others.',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          SafeArea(
            top: false,
            child: Obx(() {
              return SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: controller.shippingAddress.isEmpty
                      ? null
                      : () {
                          Get.back();
                        },
                  child: Text(
                    'Use Selected Address',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
