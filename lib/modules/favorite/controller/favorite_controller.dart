import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  //* Variables Section *\\
  final favoriteProducts = <int>{}.obs;
  //--------------------------------------------
  //* Lifecycle Section *\\
  //--------------------------------------------
  //* Functions Section*\\
  //! Toggle Favorite
  bool isFavorite(int productId) {
    return favoriteProducts.contains(productId);
  }

  void toggleFavoriteStatus(int productId) async {
    if (isFavorite(productId)) {
      favoriteProducts.remove(productId);
      Get.snackbar(
        'Removed Successfully',
        'Removed from favorites',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      await Future.delayed(const Duration(milliseconds: 1500), () {
        Get.closeCurrentSnackbar();
      });
    } else {
      favoriteProducts.add(productId);
      Get.snackbar(
        'Added Successfully',
        'Added to favorites',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      await Future.delayed(const Duration(milliseconds: 1500), () {
        Get.closeCurrentSnackbar();
      });
    }
  }
}
