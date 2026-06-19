import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/category/controller/category_controller.dart';
import 'package:flutter_ecommerce_app/modules/category/widgets/category_product_shimmer_card.widget.dart';
import 'package:flutter_ecommerce_app/modules/favorite/controller/favorite_controller.dart';
import 'package:flutter_ecommerce_app/modules/home/controller/home_controller.dart';
import 'package:flutter_ecommerce_app/widgets/categories_widget.dart';
import 'package:get/get.dart';

class CategoryView extends GetView<CategoryController> {
  CategoryView({super.key});
  final favoriteController = Get.find<FavoriteController>();
  final scrollController = Get.find<HomeController>().categoryScrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar, body: _buildBody);
  }

  //! Build AppBar
  AppBar get _buildAppbar {
    return AppBar(
      title: Text(
        'Categories',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget get _buildBody {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return CategoriesWidget(
            categories: controller.categories,
            selectedIndex: controller.selectedCategory.value,
            onTap: controller.selectCategory,
          );
        }),

        Expanded(
          child: Obx(() {
            final products = controller.getProducts;
            if (controller.isRefreshing.value) {
              return CategoryProductShimmerWidget(itemCount: products.length);
            } else if (products.isEmpty) {
              return Center(
                child: Text(
                  "No products available",
                  style: TextStyle(color: AppTheme.darkText, fontSize: 18),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 12,
                  ),
                  child: Obx(() {
                    return Text(
                      controller.categories[controller
                          .selectedCategory
                          .value]['label'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ),
                Expanded(
                  child: Scrollbar(
                    controller: scrollController,
                    radius: Radius.circular(15),
                    thickness: 7,
                    child: RefreshIndicator(
                      onRefresh: controller.refreshCategoryProduct,
                      backgroundColor: Colors.white,
                      color: AppTheme.primary,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        controller: scrollController,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return GestureDetector(
                            onTap: () {
                              RouteView.detail.go(arguments: product);
                            },
                            child: Container(
                              height: 140,
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: product.image,
                                      width: 120,
                                      height: 130,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return Container(
                                          width: 120,
                                          height: 130,
                                          color: Colors.grey[200],
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                    AppTheme.primary,
                                                  ),
                                            ),
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, error) {
                                        return Container(
                                          width: 120,
                                          height: 130,
                                          color: Colors.grey[200],
                                          child: const Center(
                                            child: Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${product.category} | ${product.brand}',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                product.rating.toString(),
                                                style: TextStyle(
                                                  color: Colors.amber,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Text(
                                            '\$${product.price.toStringAsFixed(0)}',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                        alignment: Alignment.center,
                                        child: IconButton(
                                          onPressed: () {
                                            favoriteController
                                                .toggleFavoriteStatus(
                                                  product.id,
                                                );
                                          },
                                          icon: Obx(() {
                                            return Icon(
                                              favoriteController.isFavorite(
                                                    product.id,
                                                  )
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              size: 26,
                                              color:
                                                  favoriteController.isFavorite(
                                                    product.id,
                                                  )
                                                  ? Colors.red
                                                  : Colors.grey[600],
                                            );
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
