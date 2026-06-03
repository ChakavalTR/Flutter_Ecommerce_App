import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/home/controller/home_controller.dart';
import 'package:flutter_ecommerce_app/widgets/product_card_widget.dart';
import 'package:get/get.dart';

class PhoneCategoryWidget extends GetView<HomeController> {
  const PhoneCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildCardProduct],
      ),
    );
  }

  //! Build Card Product
  SizedBox get _buildCardProduct {
    return SizedBox(
      height: 185,
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.phoneCategoryProducts.isEmpty) {
          return Center(
            child: Text(
              "No products available",
              style: TextStyle(
                color: AppTheme.darkText,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          );
        } else {
          return ListView.separated(
            itemCount: controller.phoneCategoryProducts.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) {
              return SizedBox.shrink();
            },
            itemBuilder: (context, index) {
              final product = controller.phoneCategoryProducts[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ProductCardWidget(
                  title: product.title,
                  price: product.price,
                  image: product.image,
                  rating: product.rating,
                  onTap: () {
                    RouteView.detail.go(arguments: product);
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
