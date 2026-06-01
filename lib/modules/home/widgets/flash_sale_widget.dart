import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/data/models/product_model.dart';
import 'package:flutter_ecommerce_app/modules/home/controller/home_controller.dart';
import 'package:flutter_ecommerce_app/widgets/product_card_widget.dart';
import 'package:get/get.dart';

class FlashSaleWidget extends GetView<HomeController> {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Text(
              controller.isFlashSaleEnded.value
                  ? 'Flash Sale Ended'
                  : 'Ends in ${controller.flashSaleTime}',
              style: TextStyle(
                color: AppTheme.danger,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          // SizedBox(height: 10),
          // Padding(
          //   padding: const EdgeInsets.only(right: 16),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       controller.resetFlashSaleCountdown();
          //     },
          //     child: Text('Reset Flash Sale Countdown'),
          //   ),
          // ),
          SizedBox(height: 10),
          _buildCardProduct,
        ],
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
        } else if (controller.flashSaleProducts.isEmpty) {
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
            itemCount: controller.flashSaleProducts.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) {
              return SizedBox.shrink();
            },
            itemBuilder: (context, index) {
              final product = controller.flashSaleProducts[index];
              return Obx(() {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ProductCardWidget(
                    title: product.title,
                    price: product.price,
                    oldPrice: product.newPrice,
                    discount: product.discount,
                    image: product.image,
                    isFlashSaleActive: !controller.isFlashSaleEnded.value,
                    isFlashSale: true,
                    onTap: () {
                      RouteView.detail.go(
                        arguments: ProductModel(
                          id: product.id,
                          title: product.title,
                          price: product.price,
                          discount: product.discount,
                          newPrice: product.newPrice,
                          description: product.description,
                          image: product.image,
                          category: product.category,
                          brand: product.brand,
                          stock: product.stock,
                          rating: product.rating,
                          isFlashSale: true,
                          images: product.images,
                        ),
                      );
                    },
                  ),
                );
              });
            },
          );
        }
      }),
    );
  }
}
