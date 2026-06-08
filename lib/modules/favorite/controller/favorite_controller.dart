import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/services/local_storage_service.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  //* Variables Section *\\
  final favoriteProducts = <int>{}.obs;
  static const String favoriteKey = 'favorite_products';
  //--------------------------------------------
  //* Lifecycle Section *\\
  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  //--------------------------------------------
  //* Functions Section*\\
  //! Load favorites from local storage
  void loadFavorites() {
    final data = LocalServiceStorage.instance.getStringList(favoriteKey);
    if (data != null && data.isNotEmpty) {
      favoriteProducts.addAll(data.map((e) => int.parse(e)));
    }
  }

  //! Save favorites to local storage
  Future<void> saveFavorites() async {
    await LocalServiceStorage.instance.setStringList(
      favoriteKey,
      favoriteProducts.map((e) => e.toString()).toList(),
    );
  }

  //! Toggle Favorite
  bool isFavorite(int productId) {
    return favoriteProducts.contains(productId);
  }

  Future<void> toggleFavoriteStatus(int productId) async {
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
      await saveFavorites();
      await Future.delayed(const Duration(milliseconds: 1500), () {
        Get.closeCurrentSnackbar();
      });
    }
  }
}
