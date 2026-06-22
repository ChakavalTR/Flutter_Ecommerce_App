import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/data/models/product_model.dart';
import 'package:flutter_ecommerce_app/modules/cart/model/cart_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  //* Variables Section *\\
  final cartItems = <CartModel>[].obs;
  //-------------------------------------------
  //* Lifecycle Section *\\
  //-------------------------------------------
  //* Functions Section*\\

  //! Add To Cart
  void addToCart(ProductModel product) {
    final index = cartItems.indexWhere((item) {
      return item.product.id == product.id;
    });
    if (index != -1) {
      cartItems[index].quantity.value++;
    } else {
      cartItems.add(CartModel(product: product));
    }
    Get.snackbar(
      'Success',
      'Product added to cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  //! Increase Quantity
  void increaseQuantity(int index) {
    cartItems[index].quantity.value++;
  }

  //! Decrease Quantity
  void decreaseQuantity(int index) {
    if (cartItems[index].quantity.value > 1) {
      cartItems[index].quantity.value--;
    } else {
      cartItems.removeAt(index);
    }
  }

  //! Clear Cart
  void clearCart() {
    cartItems.clear();
    Get.snackbar(
      'Success',
      'Cart cleared',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
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
  double get discount => cartItems.isEmpty ? 0 : 50;
  double get total => subtotal + shipping - discount;
}
