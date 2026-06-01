import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class CategoriesWidget extends GetView<HomeController> {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Obx(() {
        final selectedCategory = controller.selectedCategory.value;
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.categories.length,
          separatorBuilder: (context, index) {
            return const SizedBox(width: 16);
          },
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            final bool isSelected = selectedCategory == index;
            return GestureDetector(
              onTap: () {
                controller.selectCategory(index);
              },
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 60,
                    height: 62,
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primary : AppTheme.cardBg,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.darkBg.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: isSelected ? Colors.white : AppTheme.darkText,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['label'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppTheme.primary : AppTheme.darkText,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
