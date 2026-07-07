import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/checkout/model/shipping_address_model.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app/modules/checkout/controller/checkout_controller.dart';

class AddEditAddressView extends GetView<CheckoutController> {
  const AddEditAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final ShippingAddressModel? editAddress = Get.arguments;
    if (editAddress != null) {
      controller.fillAddressForm(editAddress);
    } else {
      controller.clearShippingAddressForm();
    }
    return Scaffold(
      appBar: _buildAppBar(editAddress),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: _buildBody(editAddress),
      ),
    );
  }

  AppBar _buildAppBar(ShippingAddressModel? editAddress) {
    return AppBar(
      centerTitle: true,
      title: Text(
        editAddress == null ? 'Add Address' : 'Edit Address',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding _buildBody(ShippingAddressModel? editAddress) {
    return Padding(
      padding: EdgeInsets.only(top: 8, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      //! Full Name Number
                      Text.rich(
                        TextSpan(
                          text: 'Full Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: controller.fullNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Thorng RattanakChakaval',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: AppTheme.primary),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Full name is required';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 4),

                      //! Phone Number
                      Text.rich(
                        TextSpan(
                          text: 'Phone Number',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: controller.phoneController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: '0123456789',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: AppTheme.primary),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Phone number is required';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 4),

                      //! Address
                      Text.rich(
                        TextSpan(
                          text: 'Address',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: controller.addressController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home),
                          hintText: 'Street Address, Building, Apartment, etc.',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: AppTheme.primary),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Address is required';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 4),

                      //! City / Province
                      Text.rich(
                        TextSpan(
                          text: 'City / Province',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: controller.cityController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city),
                          hintText: 'Phnom Penh',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: AppTheme.primary),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'City / Province is required';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 4),

                      //! Postal Code
                      Text.rich(
                        TextSpan(
                          text: 'Postal Code (ZIP)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: controller.postalCodeController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.local_post_office),
                          hintText: '12345',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: AppTheme.primary),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Postal Code is required';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 4),

                      //! Country
                      Text.rich(
                        TextSpan(
                          text: 'Country',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        initialValue: controller.countryController.text.isEmpty
                            ? null
                            : controller.countryController.text,
                        items: [
                          DropdownMenuItem(
                            value: 'Cambodia',
                            child: Text('Cambodia'),
                          ),
                          DropdownMenuItem(
                            value: 'Vietnam',
                            child: Text('Vietnam'),
                          ),
                          DropdownMenuItem(value: 'Laos', child: Text('Laos')),
                          DropdownMenuItem(
                            value: 'Singapore',
                            child: Text('Singapore'),
                          ),
                          DropdownMenuItem(
                            value: 'Malaysia',
                            child: Text('Malaysia'),
                          ),
                          DropdownMenuItem(
                            value: 'United States',
                            child: Text('United States'),
                          ),
                        ],
                        onChanged: (value) {
                          controller.countryController.text = value ?? '';
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.public),
                          hintText: 'Select Country',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: AppTheme.primary),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Country is required';
                          }
                          return null;
                        },
                      ),

                      Obx(
                        () => Row(
                          children: [
                            Checkbox(
                              value: controller.isDefaultAddress.value,
                              onChanged: (value) {
                                controller.isDefaultAddress.value =
                                    value ?? false;
                              },
                            ),
                            Text(
                              'Set as default address',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SafeArea(
                    top: false,
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.saveShippingAddress(
                            oldAddress: editAddress,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save, size: 30),
                            SizedBox(width: 10),
                            Text(
                              'Save Address',
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
            ],
          ),
        ),
      ),
    );
  }
}
