import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/services/api_service.dart';
import 'package:flutter_ecommerce_app/core/services/local_storage_service.dart';
import 'package:flutter_ecommerce_app/data/models/product_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //* Variables Section *\\
  var currentBanner = 0.obs;
  Timer? timerBanner;
  late PageController bannerController;
  int pageIndex = 1000;
  final List<String> bannerImages = [
    'assets/images/banner_1.png',
    'assets/images/banner_2.png',
    'assets/images/banner_3.png',
    'assets/images/banner_4.png',
  ];
  var selectedCategory = 0.obs;
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.grid_view_rounded, 'label': 'All'},
    {'icon': Icons.phone_android_rounded, 'label': 'Phones'},
    {'icon': Icons.laptop_mac_rounded, 'label': 'Laptops'},
    {'icon': Icons.watch_rounded, 'label': 'Watches'},
    {'icon': Icons.headphones, 'label': 'Audio'},
    {'icon': Icons.cable_rounded, 'label': 'Accessories'},
    {'icon': Icons.videogame_asset, 'label': 'Gaming'},
  ];
  var flashSaleDuration = Duration.zero.obs;
  Timer? timerFlashSale;
  var isFlashSaleEnded = false.obs;
  var products = <ProductModel>[].obs;
  var isLoading = false.obs;
  var currentIndex = 0.obs;
  final RxList<ProductModel> flashSaleProducts = <ProductModel>[].obs;
  //-------------------------------------------
  //* Lifecycle Section *\\
  @override
  void onInit() {
    super.onInit();
    bannerController = PageController(initialPage: pageIndex);
    currentBanner.value = pageIndex % bannerImages.length;
    fetchProducts();
    startFlashSaleCountdown();
    autoScrollBanner();
  }

  @override
  void onClose() {
    timerBanner?.cancel();
    bannerController.dispose();
    timerFlashSale?.cancel();
    super.onClose();
  }

  //-------------------------------------------
  //* Functions Section*\\
  //! On Banner Change
  void changeBanner(int index) {
    pageIndex = index;
    currentBanner.value = index % bannerImages.length;
  }

  //! Auto Scroll Banner
  void autoScrollBanner() {
    timerBanner?.cancel();
    timerBanner = Timer.periodic(Duration(seconds: 4), (timer) {
      pageIndex++;
      if (!bannerController.hasClients) return;
      currentBanner.value = pageIndex % bannerImages.length;
      bannerController.animateToPage(
        pageIndex,
        duration: Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }

  //! On Category Select
  void selectCategory(int index) {
    selectedCategory.value = index;
  }

  //! Flash Sale Countdown
  Future<void> startFlashSaleCountdown() async {
    const key = 'flash_sale_end_time';
    final savedEndTime = LocalServiceStorage.instance.getString(key);
    DateTime endTime;
    if (savedEndTime == null) {
      endTime = DateTime.now().add(
        Duration(hours: 730, minutes: 30, seconds: 59),
        //Duration(seconds: 10), // For testing
      );
      await LocalServiceStorage.instance.setString(
        key,
        endTime.toIso8601String(),
      );
    } else {
      endTime = DateTime.parse(savedEndTime);
    }
    timerFlashSale?.cancel();
    final remainingNow = endTime.difference(DateTime.now());
    if (remainingNow.inSeconds <= 0) {
      flashSaleDuration.value = Duration.zero;
      isFlashSaleEnded.value = true;
      return;
    }
    flashSaleDuration.value = remainingNow;
    isFlashSaleEnded.value = false;
    timerFlashSale = Timer.periodic(Duration(seconds: 1), (timer) {
      final remaining = endTime.difference(DateTime.now());
      if (remaining.inSeconds <= 0) {
        flashSaleDuration.value = Duration.zero;
        isFlashSaleEnded.value = true;
        timer.cancel();
      } else {
        flashSaleDuration.value = remaining;
      }
    });
  }

  String get flashSaleTime {
    final duration = flashSaleDuration.value;
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  //! Bottom Navigation Bar Change
  void changeBottomNav(int index) {
    currentIndex.value = index;
  }

  //! Flash Countdown reset (for testing)
  // Future<void> resetFlashSaleCountdown() async {
  //   final key = 'flash_sale_end_time';
  //   await LocalServiceStorage.instance.remove(key);
  //   flashSaleDuration.value = Duration.zero;
  //   isFlashSaleEnded.value = true;
  //   await startFlashSaleCountdown();
  // }

  //-------------------------------------------
  //* Sale By Category Section *\\
  //! Flash Sale Products
  void loadFlashSaleProducts() {
    List<ProductModel> getRandomProducts(String category, int count) {
      final items = products
          .where(
            (p) =>
                p.category.toLowerCase() == category.toLowerCase() &&
                (p.discount ?? 0) > 0,
          )
          .take(count)
          .toList();
      return items.take(count).toList();
    }

    flashSaleProducts.assignAll([
      ...getRandomProducts('Watches', 2),
      ...getRandomProducts('Accessories', 4),
      ...getRandomProducts('Laptops', 1),
      ...getRandomProducts('Audio', 2),
    ]);
  }

  //! Best Selling Products
  List<ProductModel> get bestSellingProducts {
    final list = [...products];
    list.sort((a, b) => b.rating.compareTo(a.rating));
    return list.take(5).toList();
  }

  //! Phones Category Products
  List<ProductModel> get phoneCategoryProducts {
    return products
        .where((product) => product.category.toLowerCase() == 'phones')
        .toList();
  }

  //! Laptops Category Products
  List<ProductModel> get laptopCategoryProducts {
    return products
        .where((product) => product.category.toLowerCase() == 'laptops')
        .toList();
  }

  //! Watches Category Products
  List<ProductModel> get watchCategoryProducts {
    return products
        .where((product) => product.category.toLowerCase() == 'watches')
        .toList();
  }

  //! Audio Category Products
  List<ProductModel> get audioCategoryProducts {
    return products
        .where((product) => product.category.toLowerCase() == 'audio')
        .toList();
  }

  //! Accessories Category Products
  List<ProductModel> get accessoriesCategoryProducts {
    return products
        .where((product) => product.category.toLowerCase() == 'accessories')
        .toList();
  }

  //! Gaming Category Products
  List<ProductModel> get gamingCategoryProducts {
    return products
        .where((product) => product.category.toLowerCase() == 'gaming')
        .toList();
  }

  //-------------------------------------------
  //* API Section *\\
  //! Fetch Products
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final response = await ApiService.get('/api/products');
      final List data = response.data;
      products.value = data.map((json) => ProductModel.fromJson(json)).toList();
      loadFlashSaleProducts();
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
