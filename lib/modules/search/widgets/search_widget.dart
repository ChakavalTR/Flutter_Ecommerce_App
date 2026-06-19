import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/search/controller/search_controller.dart';
import 'package:get/get.dart';

class SearchWidget extends GetView<SearchProductController> {
  const SearchWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: SizedBox(
        height: 50,
        child: TextField(
          keyboardType: TextInputType.text,
          controller: controller.searchController,
          onChanged: (value) {
            controller.onSearchChange(value);
            controller.onSearch(value);
          },
          onSubmitted: (value) {
            controller.addRecentSearch(value);
            controller.onSearch(value);
          },
          decoration: InputDecoration(
            hintText: 'Search products...',
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppTheme.darkBg.withOpacity(0.5),
            ),
            prefixIcon: Icon(Icons.search),
            suffixIcon: Obx(() {
              if (controller.isTyping.value) {
                return IconButton(
                  onPressed: controller.clearSearch,
                  icon: const Icon(Icons.close),
                );
              }
              return IconButton(
                onPressed: () {
                  controller.openVoiceSearchSheet();
                },
                icon: const Icon(Icons.mic_none_outlined, size: 25),
              );
            }),
            filled: true,
            fillColor: const Color.fromARGB(255, 250, 250, 250),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppTheme.darkBg.withOpacity(0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppTheme.primary),
            ),
          ),
        ),
      ),
    );
  }
}
