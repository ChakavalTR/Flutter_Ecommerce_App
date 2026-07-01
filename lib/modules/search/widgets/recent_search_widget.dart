import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/search/controller/search_controller.dart';
import 'package:flutter_ecommerce_app/modules/search/widgets/title_search_widget.dart';
import 'package:get/get.dart';

class RecentSearchWidget extends GetView<SearchProductController> {
  const RecentSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final displaySearches = controller.recentSearches.take(5).toList();
      if (displaySearches.isEmpty) {
        return SizedBox.shrink();
      }
      return Column(
        children: [
          TitleSearchWidget(
            title: 'Recent Searches',
            onTap: () {
              Get.dialog(
                AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(
                    'Are you sure want to clear all?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  // content: Text(
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.clearAllRecentSearches();
                        Get.back();
                      },
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: displaySearches.map((item) {
                  return GestureDetector(
                    onTap: () {
                      controller.selectSuggestion(item);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: AppTheme.darkBg.withOpacity(0.12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.history,
                            size: 18,
                            color: AppTheme.darkBg.withOpacity(0.45),
                          ),
                          SizedBox(width: 8),
                          Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.darkBg.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              controller.removeRecentSearch(item);
                            },
                            child: Icon(
                              Icons.close,
                              size: 18,
                              color: AppTheme.darkBg.withOpacity(0.45),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      );
    });
  }
}
