import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/data/models/product_model.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  //* Variables Section *\\
  late ProductModel product;
  var selectedColors = 0.obs;
  var selectedStorage = 0.obs;
  var isExpanded = false.obs;
  final colorsOption = [
    Colors.black,
    Colors.purple,
    const Color.fromARGB(255, 246, 214, 184),
    const Color.fromARGB(255, 200, 200, 200),
  ];
  final storagesOption = ['256GB', '512GB', '1TB', '2TB'];
  final quantity = 1.obs;
  var toggleFavorite = false.obs;
  //-------------------------------------------
  //* Lifecycle Section *\\
  @override
  void onInit() {
    product = Get.arguments as ProductModel;
    super.onInit();
  }

  //-------------------------------------------
  //* Functions Section*\\
  //! On Color Change
  void changeColor(int index) {
    selectedColors.value = index;
  }

  //! On Storage Change
  void changeStorage(int index) {
    selectedStorage.value = index;
  }

  //! On Description Expand/Collapse
  void toggleDescription() {
    isExpanded.toggle();
  }

  //! On Quantity Change
  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  //! On Favorite Toggle
  void toggleFavoriteStatus() {
    toggleFavorite.toggle();
  }

  //! Show Storage Options Modal
  bool get showStorage {
    final category = product.category.toLowerCase();
    return category.contains('phones') ||
        category.contains('laptops') ||
        category.contains('watches') ||
        category.contains('gaming');
  }
}
