// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/services/local_storage_service.dart';
import 'package:flutter_ecommerce_app/data/models/product_model.dart';
import 'package:flutter_ecommerce_app/modules/home/controller/home_controller.dart';
import 'package:flutter_ecommerce_app/modules/search/widgets/voice_search_bottom_sheet_widget.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchProductController extends GetxController {
  //* Variables Section *\\
  final searchController = TextEditingController();
  final isTyping = false.obs;
  final isListening = false.obs;
  final SpeechToText speechToText = SpeechToText();
  final recentSearches = <String>[].obs;
  static const recentSearchKey = 'recent_searches';
  final homeController = Get.find<HomeController>();
  final searchProducts = <ProductModel>[].obs;
  final suggestions = <String>[].obs;
  final isSuggestionSelected = false.obs;
  //-------------------------------------------
  //* Lifecycle Section *\\
  @override
  void onClose() {
    searchController.dispose();
    speechToText.stop();
    super.onClose();
  }

  @override
  void onInit() {
    loadRecentSearches();
    super.onInit();
  }

  //-------------------------------------------
  //* Functions Section*\\
  //! On Search Text Change
  void onSearchChange(String value) {
    final keyword = value.trim().toLowerCase();
    isTyping.value = value.trim().isNotEmpty;
    isSuggestionSelected.value = false;
    searchProducts.clear();
    if (keyword.isEmpty) {
      suggestions.clear();
      return;
    }
    final allSuggestions = homeController.products
        .map((element) => element.title)
        .toSet()
        .toList();
    suggestions.value = allSuggestions
        .where((suggestion) {
          return suggestion.toLowerCase().contains(keyword);
        })
        .take(8)
        .toList();
  }

  //! Clear Search
  void clearSearch() {
    searchController.clear();
    isTyping.value = false;
    isSuggestionSelected.value = false;
    searchProducts.clear();
    suggestions.clear();
  }

  //! Select Suggestion
  void selectSuggestion(String value) {
    searchController.text = value;
    searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: searchController.text.length),
    );
    isSuggestionSelected.value = true;
    suggestions.clear();
    addRecentSearch(value);
    onSearch(value);
  }

  //! Start Listening
  Future<void> startListening() async {
    final available = await speechToText.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          isListening.value = false;
        }
      },
      onError: (error) {
        isListening.value = false;
        Get.snackbar(
          'Error',
          'Speech recognition error: ${error.errorMsg}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      },
    );
    if (!available) {
      Get.snackbar(
        'Error',
        'Speech recognition not available',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    isListening.value = true;
    await speechToText.stop();
    await Future.delayed(const Duration(milliseconds: 300));
    await speechToText.listen(
      localeId: 'en_US',
      listenFor: const Duration(seconds: 10),
      pauseFor: const Duration(seconds: 5),
      onResult: (result) {
        searchController.text = result.recognizedWords;
        searchController.selection = TextSelection.fromPosition(
          TextPosition(offset: searchController.text.length),
        );
        isTyping.value = searchController.text.trim().isNotEmpty;
        if (result.finalResult) {
          addRecentSearch(result.recognizedWords);
          isListening.value = false;
          if (Get.isBottomSheetOpen ?? false) {
            Get.back();
          }
        }
      },
    );
  }

  //! Open Voice Search Sheet
  void openVoiceSearchSheet() {
    Get.bottomSheet(
      const VoiceSearchBottomSheetWidget(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      startListening();
    });
  }

  //! Stop Listening
  Future<void> stopListening() async {
    isListening.value = false;
    await speechToText.stop();
  }

  //! Add Recent Search
  Future<void> addRecentSearch(String value) async {
    final text = value.trim();
    if (text.isEmpty) return;
    recentSearches.remove(text);
    recentSearches.insert(0, text);
    await saveRecentSearches();
  }

  //! Remove One Recent Search
  Future<void> removeRecentSearch(String value) async {
    recentSearches.remove(value);
    await saveRecentSearches();
  }

  //! Clear All Recent Searches
  Future<void> clearAllRecentSearches() async {
    recentSearches.clear();
    await saveRecentSearches();
  }

  //! Load Recent Searches from Storage
  void loadRecentSearches() {
    final saved = LocalServiceStorage.instance.getStringList(recentSearchKey);
    if (saved != null) {
      recentSearches.assignAll(saved);
    }
  }

  //! Save Recent Searches to Storage
  Future<void> saveRecentSearches() async {
    await LocalServiceStorage.instance.setStringList(
      recentSearchKey,
      recentSearches.toList(),
    );
  }

  //! Search Products
  void onSearch(String value) {
    final keyword = value.trim().toLowerCase();
    isTyping.value = keyword.isNotEmpty;
    if (keyword.isEmpty) {
      searchProducts.clear();
      return;
    }
    searchProducts.value = homeController.products.where((product) {
      return product.title.toLowerCase().contains(keyword) ||
          product.brand.toLowerCase().contains(keyword) ||
          product.category.toLowerCase().contains(keyword);
    }).toList();
  }
}
