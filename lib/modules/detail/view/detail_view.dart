import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/cart/view/cart_view.dart';
import 'package:flutter_ecommerce_app/modules/detail/view/image_preview_view.dart';
import 'package:flutter_ecommerce_app/modules/detail/widgets/bottomNavigation_bar_widget.dart';
import 'package:flutter_ecommerce_app/modules/detail/widgets/color_option_widget.dart';
import 'package:flutter_ecommerce_app/modules/detail/widgets/storage_option_widget.dart';
import 'package:flutter_ecommerce_app/modules/favorite/controller/favorite_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app/modules/detail/controller/detail_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailView extends GetView<DetailController> {
  DetailView({super.key});
  final favoriteController = Get.find<FavoriteController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(top: true, child: _buildBody),
      bottomNavigationBar: BottomnavigationBarWidget(),
    );
  }

  //! Build Body Using CustomScrollView
  CustomScrollView get _buildBody {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          leadingWidth: 60,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[700]?.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 26,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          expandedHeight: 350,
          pinned: true,
          actions: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[700]?.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  RouteView.cart.go();
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 26,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 5),
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[700]?.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 26,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                onSelected: (value) {
                  switch (value) {
                    case 'save':
                      controller.saveImage(controller.product.image);
                      break;
                    case 'share':
                      Get.snackbar(
                        'Coming Soon',
                        'Share product feature is coming soon!',
                        backgroundColor: AppTheme.primary,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      break;
                    case 'report':
                      Get.snackbar(
                        'Coming Soon',
                        'Report product feature is coming soon!',
                        backgroundColor: AppTheme.primary,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      break;
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'save',
                      child: Row(
                        children: [
                          Icon(Icons.save_outlined),
                          SizedBox(width: 8),
                          Text(
                            'Save Image',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'share',
                      child: Row(
                        children: [
                          Icon(Icons.share_outlined),
                          SizedBox(width: 8),
                          Text(
                            'Share Product',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'report',
                      child: Row(
                        children: [
                          Icon(Icons.report_outlined),
                          SizedBox(width: 8),
                          Text(
                            'Report Product',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            ),
            SizedBox(width: 5),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                PageView.builder(
                  onPageChanged: controller.changeImageIndex,
                  itemCount: controller.productImages.length,
                  itemBuilder: (context, index) {
                    final image = controller.productImages[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ImagePreviewView(initialIndex: index));
                      },
                      child: Hero(
                        tag: '${image}_$index',
                        child: CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Obx(() {
                    return AnimatedSmoothIndicator(
                      activeIndex: controller.currentImageIndex.value,
                      count: controller.productImages.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: AppTheme.primary,
                        dotColor: AppTheme.darkBg.withOpacity(0.3),
                      ),
                    );
                  }),
                ),
                Positioned(
                  right: 28,
                  bottom: 20,
                  child: Obx(() {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[700]?.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${controller.currentImageIndex.value + 1}/${controller.productImages.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        controller.product.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Obx(() {
                      return IconButton(
                        onPressed: () {
                          favoriteController.toggleFavoriteStatus(
                            controller.product.id,
                          );
                        },
                        icon: Icon(
                          favoriteController.isFavorite(controller.product.id)
                              ? (Icons.favorite)
                              : Icons.favorite_border,
                          color:
                              favoriteController.isFavorite(
                                controller.product.id,
                              )
                              ? Colors.red
                              : Colors.black,
                          size: 28,
                        ),
                      );
                    }),
                  ],
                ),
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      if (index < controller.product.rating.floor()) {
                        return Icon(Icons.star, color: Colors.amber, size: 18);
                      } else if (index < controller.product.rating) {
                        return Icon(
                          Icons.star_half,
                          color: Colors.amber,
                          size: 18,
                        );
                      } else {
                        return Icon(
                          Icons.star_border,
                          color: Colors.amber,
                          size: 18,
                        );
                      }
                    }),
                    SizedBox(width: 6),
                    Text(
                      controller.product.rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '(reviews)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Builder(
                  builder: (context) {
                    final hasDiscount =
                        controller.product.isFlashSale &&
                        controller.product.discount != null &&
                        controller.product.newPrice != null;
                    if (hasDiscount) {
                      return Row(
                        children: [
                          Text(
                            '\$${controller.product.price.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.success,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '\$${controller.product.newPrice!.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.danger,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '-${controller.product.discount!.toStringAsFixed(0)}%',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Text(
                      '\$${controller.product.price.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.success,
                      ),
                    );
                  },
                ),
                Text(
                  'Color',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 1),
                Obx(() {
                  return Row(
                    children: List.generate(controller.colorsOption.length, (
                      index,
                    ) {
                      return GestureDetector(
                        onTap: () {
                          controller.changeColor(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 5),
                          child: ColorOptionWidget(
                            color: controller.colorsOption[index],
                            isSelected:
                                controller.selectedColors.value == index,
                          ),
                        ),
                      );
                    }),
                  );
                }),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
                if (controller.showStorage) ...[
                  Text(
                    'Storage',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 1),
                  Obx(() {
                    return Row(
                      children: List.generate(
                        controller.storagesOption.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              controller.changeStorage(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                left: 5,
                              ),
                              child: StorageOptionWidget(
                                storage: controller.storagesOption[index],
                                isSelected:
                                    controller.selectedStorage.value == index,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ],
                SizedBox(height: 10),
                Obx(() {
                  final isLongDescription =
                      controller.product.description.length > 100;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        controller.product.description,
                        maxLines: controller.isExpanded.value ? null : 2,
                        overflow: controller.isExpanded.value
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                      ),
                      if (isLongDescription)
                        GestureDetector(
                          onTap: () {
                            controller.toggleDescription();
                          },
                          child: Text(
                            controller.isExpanded.value
                                ? 'Show Less'
                                : 'Show More',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
