import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/data/models/product_model.dart';
import 'package:flutter_ecommerce_app/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  //* Variables Section *\\
  final homeController = Get.find<HomeController>();
  final selectedCategory = 0.obs;
  List<Map<String, dynamic>> get categories => homeController.categories;
  final isRefreshing = false.obs;
  //--------------------------------------------
  //* Lifecycle Section *\\
  @override
  void onInit() {
    super.onInit();
    setCategoryFromArgument();
  }
  //--------------------------------------------
  //* Functions Section*\\

  //! On Category Change
  void selectCategory(int index) {
    selectedCategory.value = index;
  }

  //! Get Products by Category
  List<ProductModel> get getProducts {
    if (selectedCategory.value == 0) {
      return homeController.products;
    }
    final category = categories[selectedCategory.value]['label'];
    return homeController.products
        .where((product) => product.category == category)
        .toList();
  }

  //! Set Category from Argument
  void setCategoryFromArgument() {
    final argument = Get.arguments;
    if (argument == null) return;
    final categoryName = argument is Map
        ? argument['category'].toString()
        : argument.toString();
    selectCategoryByName(categoryName);
  }

  void selectCategoryByName(String name) {
    final index = categories.indexWhere(
      (category) =>
          category['label'].toString().toLowerCase() == name.toLowerCase(),
    );
    if (index != -1) {
      selectedCategory.value = index;
    }
  }

  //! Refresh Products
  Future<void> refreshCategoryProduct() async {
    try {
      isRefreshing.value = true;
      await homeController.fetchProducts();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to refresh products',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isRefreshing.value = false;
    }
  }
}
