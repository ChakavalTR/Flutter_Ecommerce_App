import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/data/models/product_model.dart';
import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
  var isLoading = false.obs;
  final currentImageIndex = 0.obs;
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

  //! Save Image
  Future<void> saveImage(String imageUrl) async {
    try {
      isLoading.value = true;
      Get.dialog(
        Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 200,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.lightBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    'assets/lotties/Sandy Loading.json',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Loading Saving...",
                    style: TextStyle(
                      color: AppTheme.darkText,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );
      final response = await Dio().get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      await Gal.putImageBytes(
        response.data,
        name: 'product_${DateTime.now().millisecondsSinceEpoch}',
      );
      await Future.delayed(Duration(seconds: 2));
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.snackbar(
        "Success",
        "Image has been saved to your photos.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppTheme.success,
        colorText: Colors.white,
      );
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.snackbar(
        "Error",
        "Failed to save image: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppTheme.danger,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  //! Current Image Index Change
  List<String> get productImages {
    return product.images.isNotEmpty ? product.images : [product.image];
  }

  void changeImageIndex(int index) {
    currentImageIndex.value = index;
  }
}
