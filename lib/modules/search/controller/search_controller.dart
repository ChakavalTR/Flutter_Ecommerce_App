// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/modules/search/widgets/voice_search_bottom_sheet_widget.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchProductController extends GetxController {
  //* Variables Section *\\
  final searchController = TextEditingController();
  final isTyping = false.obs;
  final isListening = false.obs;
  final SpeechToText speechToText = SpeechToText();
  //-------------------------------------------
  //* Lifecycle Section *\\
  @override
  void onClose() {
    searchController.dispose();
    speechToText.stop();
    super.onClose();
  }

  //-------------------------------------------
  //* Functions Section*\\
  //! On Search Text Change
  void onSearchChange(String value) {
    isTyping.value = value.trim().isNotEmpty;
  }

  //! Clear Search
  void clearSearch() {
    searchController.clear();
    isTyping.value = false;
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
          isListening.value = false;
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
}
