import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerWidget extends GetView<HomeController> {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 190,
          child: PageView.builder(
            controller: controller.bannerController,
            onPageChanged: controller.changeBanner,
            itemBuilder: (context, index) {
              final imageIndex = index % controller.bannerImages.length;
              final image = controller.bannerImages[imageIndex];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.darkBg.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                clipBehavior: Clip.antiAlias,
                child: controller.bannerImages[imageIndex].startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return Container(
                            color: AppTheme.cardBg,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  AppTheme.primary,
                                ),
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Container(
                            color: AppTheme.cardBg,
                            child: const Center(
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                          );
                        },
                      )
                    : Image.asset(image, fit: BoxFit.cover),
              );
            },
          ),
        ),
        SizedBox(height: 10),
        Obx(() {
          return AnimatedSmoothIndicator(
            activeIndex: controller.currentBanner.value,
            count: controller.bannerImages.length,
            effect: ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: AppTheme.primary,
              dotColor: AppTheme.darkBg.withOpacity(0.3),
            ),
          );
        }),
      ],
    );
  }
}
