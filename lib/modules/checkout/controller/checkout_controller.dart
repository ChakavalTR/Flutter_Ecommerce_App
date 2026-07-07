import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/modules/cart/model/cart_model.dart';
import 'package:flutter_ecommerce_app/modules/checkout/model/shipping_address_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutController extends GetxController {
  //* Variables Section *\\
  late final List<CartModel> checkoutItems;
  final selectedShipping = 0.obs;
  final selectedPaymentMethod = 0.obs;
  final List<String> creditCardImages = [
    'assets/icons/visa_icon.png',
    'assets/icons/mastercard_icon.png',
  ];
  final discount = 0.0.obs;
  final shippingAddress = <ShippingAddressModel>[].obs;
  final selectedAddressIndex = 0.obs;
  final isDefaultAddress = false.obs;
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final countryController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final String shippingAddressKey = 'shipping_address_key';
  //-------------------------------------------
  //* Lifecycle Section *\\
  @override
  void onInit() {
    super.onInit();
    checkoutItems = (Get.arguments as List<CartModel>?) ?? [];
    loadShippingAddressFromLocalStorage();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
    super.onClose();
  }

  //-------------------------------------------
  //* Functions Section*\\
  //! Select Shipping Method
  void selectShippingMethod(int index) {
    selectedShipping.value = index;
  }

  //! Select Payment Method
  void selectPaymentMethod(int index) {
    selectedPaymentMethod.value = index;
  }

  //! Fill Shipping Address
  void fillAddressForm(ShippingAddressModel address) {
    fullNameController.text = address.fullName;
    phoneController.text = address.phone;
    addressController.text = address.address;
    cityController.text = address.city;
    postalCodeController.text = address.postalCode;
    countryController.text = address.country;
    isDefaultAddress.value = address.isDefault;
  }

  //! Clear Shipping Address Form
  void clearShippingAddressForm() {
    fullNameController.clear();
    phoneController.clear();
    addressController.clear();
    cityController.clear();
    postalCodeController.clear();
    countryController.clear();
    countryController.text = 'Cambodia';
    isDefaultAddress.value = false;
  }

  //! Save Shipping Address
  void saveShippingAddress({ShippingAddressModel? oldAddress}) {
    if (!formKey.currentState!.validate()) return;
    final newAddress = ShippingAddressModel(
      id: oldAddress?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: fullNameController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      city: cityController.text.trim(),
      postalCode: postalCodeController.text.trim(),
      country: countryController.text.trim(),
      isDefault: isDefaultAddress.value,
    );
    if (newAddress.isDefault) {
      for (var i = 0; i < shippingAddress.length; i++) {
        shippingAddress[i] = shippingAddress[i].copyWith(isDefault: false);
      }
    }
    if (oldAddress == null) {
      shippingAddress.add(newAddress);
      selectedAddressIndex.value = shippingAddress.length - 1;
    } else {
      final index = shippingAddress.indexWhere((e) => e.id == oldAddress.id);
      if (index != -1) {
        shippingAddress[index] = newAddress;
        selectedAddressIndex.value = index;
      }
    }
    saveShippingAddressToLocalStorage();
    clearShippingAddressForm();
    Get.back();
    Get.snackbar(
      'Success',
      'Address saved successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Future.delayed(Duration(milliseconds: 1000), () {
      Get.closeCurrentSnackbar();
    });
  }

  //! Select Shipping Address
  void selectShippingAddress(int index) {
    selectedAddressIndex.value = index;
    saveShippingAddressToLocalStorage();
  }

  //! Delete Shipping Address
  void deleteShippingAddress(int index) {
    shippingAddress.removeAt(index);
    if (selectedAddressIndex.value >= shippingAddress.length) {
      selectedAddressIndex.value = 0;
    }
    saveShippingAddressToLocalStorage();
    Get.snackbar(
      'Success',
      'Address deleted successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Future.delayed(Duration(milliseconds: 1000), () {
      Get.closeCurrentSnackbar();
    });
  }

  //! Get Selected Shipping Address
  ShippingAddressModel? get selectedShippingAddress {
    if (shippingAddress.isEmpty) return null;
    return shippingAddress[selectedAddressIndex.value];
  }

  //! Edit Shipping Address
  void editShippingAddress(ShippingAddressModel oldAddress) {
    RouteView.addEditAddress.go(arguments: oldAddress);
  }

  //! Save Shipping Address to Local Storage
  void saveShippingAddressToLocalStorage() async {
    final preferences = await SharedPreferences.getInstance();
    final data = shippingAddress.map((e) => e.toJson()).toList();
    await preferences.setString(shippingAddressKey, jsonEncode(data));
  }

  //! Load Shipping Address from Local Storage
  void loadShippingAddressFromLocalStorage() async {
    final preferences = await SharedPreferences.getInstance();
    final data = preferences.getString(shippingAddressKey);
    if (data == null) return;
    final List decodedData = jsonDecode(data);
    shippingAddress.value = decodedData
        .map((e) => ShippingAddressModel.fromJson(e))
        .toList();
    final defaultIndex = shippingAddress.indexWhere((e) => e.isDefault);
    if (defaultIndex != -1) {
      selectedAddressIndex.value = defaultIndex;
    }
  }

  //------------------------------------------
  //* Calculated Properties Section *\\
  //! Subtotal
  double get subTotal {
    double total = 0;
    for (final item in checkoutItems) {
      total += item.product.price * item.quantity.value;
    }
    return total;
  }

  //! Shipping Fee
  double get shippingFee {
    return selectedShipping.value == 0 ? 0 : 9.99;
  }

  //! Discount
  double get discountAmount {
    return discount.value;
  }

  //! Total
  double get total {
    return subTotal + shippingFee - discountAmount;
  }
}
