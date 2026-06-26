import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/services/local_storage_service.dart';
import 'package:flutter_ecommerce_app/data/models/product_model.dart';
import 'package:flutter_ecommerce_app/modules/cart/model/cart_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  //* Variables Section *\\
  final cartItems = <CartModel>[].obs;
  static const String cartKey = 'cart_items';
  //-------------------------------------------
  //* Lifecycle Section *\\
  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  //-------------------------------------------
  //* Functions Section*\\

  //! Add To Cart
  void addToCart({
    required ProductModel product,
    required Color selectedColor,
    String? selectedStorage,
    int quantity = 1,
  }) async {
    final index = cartItems.indexWhere((item) {
      return item.product.id == product.id &&
          item.color == selectedColor &&
          item.selectedStorage == selectedStorage;
    });
    if (index != -1) {
      cartItems[index].quantity.value += quantity;
    } else {
      cartItems.insert(
        0,
        CartModel(
          product: product,
          color: selectedColor,
          selectedStorage: selectedStorage,
          quantity: quantity,
        ),
      );
    }
    await saveCart();
    Get.snackbar(
      'Success',
      'Product added to cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Future.delayed(const Duration(milliseconds: 900), () {
      Get.closeCurrentSnackbar();
    });
  }

  //! Increase Quantity
  void increaseQuantity(int index) {
    cartItems[index].quantity.value++;
    saveCart();
  }

  //! Decrease Quantity
  void decreaseQuantity(int index) {
    if (cartItems[index].quantity.value > 1) {
      cartItems[index].quantity.value--;
    }
    saveCart();
  }

  //! Clear Cart
  void clearCart() {
    cartItems.clear();
    Get.snackbar(
      'Success',
      'Cart cleared successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    Future.delayed(const Duration(milliseconds: 800), () {
      Get.closeCurrentSnackbar();
    });
    saveCart();
  }

  //! Subtotal
  double get subtotal {
    double total = 0;
    for (var item in cartItems) {
      total += item.product.price * item.quantity.value;
    }
    return total;
  }

  double get shipping => 0;
  double get discount => cartItems.isEmpty ? 0 : 0;
  double get total => subtotal + shipping - discount;

  //! Save Cart to Local Storage
  Future<void> saveCart() async {
    await LocalServiceStorage.instance.setStringList(
      cartKey,
      cartItems.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  //! Load Cart from Local Storage
  void loadCart() async {
    final cartData = LocalServiceStorage.instance.getStringList(cartKey);
    if (cartData == null || cartData.isEmpty) return;

    cartItems.value = cartData
        .map((e) => CartModel.fromJson(jsonDecode(e)))
        .toList();
  }

  //! Toggle Item Selection
  void toggleSelectItem(int index) {
    cartItems[index].isSelected.toggle();
    saveCart();
  }

  //! Toggle Select All
  void toggleSelectAll(bool value) {
    for (var item in cartItems) {
      item.isSelected.value = value;
    }
    saveCart();
  }

  //! Check if all items are selected
  bool get isAllSelected {
    return cartItems.isNotEmpty &&
        cartItems.every((item) {
          return item.isSelected.value;
        });
  }

  //! Selected Total
  double get selectedTotal {
    double total = 0;
    for (var item in cartItems) {
      if (item.isSelected.value) {
        total += item.product.price * item.quantity.value;
      }
    }
    return total;
  }

  //! Selected Count
  int get selectedCount {
    return cartItems.where((item) => item.isSelected.value).length;
  }

  //! hasSelectedItems
  bool get hasSelectedItems {
    return cartItems.any((item) => item.isSelected.value);
  }

  //! Update Quantity
  void updateQuantity(int index, int quantity) {
    if (quantity < 0) {
      cartItems[index].quantity.value = 0;
    } else {
      cartItems[index].quantity.value = quantity;
    }
    saveCart();
  }

  //! Close Editing Quantity
  void closeEditingQuantity() {
    for (final item in cartItems) {
      item.isEditingQty.value = false;
    }
  }

  //! Remove Item
  void removeItem(int index) {
    cartItems.removeAt(index);
    Get.snackbar(
      'Success',
      'Item removed from cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Future.delayed(Duration(milliseconds: 800), () {
      Get.closeCurrentSnackbar();
    });
    saveCart();
  }

  //! Get Selected Items
  List<CartModel> get selectedItems {
    return cartItems.where((item) => item.isSelected.value).toList();
  }
}
