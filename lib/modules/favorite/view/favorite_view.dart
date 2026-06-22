import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/category/controller/category_controller.dart';
import 'package:flutter_ecommerce_app/modules/favorite/controller/favorite_controller.dart';
import 'package:flutter_ecommerce_app/modules/favorite/widgets/favorite_shimmer_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class FavoriteView extends StatelessWidget {
  FavoriteView({super.key});
  final favoriteController = Get.find<FavoriteController>();
  final categoryController = Get.find<CategoryController>();
  final scrollController = Get.find<HomeController>().favoriteScrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar, body: _buildBody);
  }

  //! Build AppBar
  AppBar get _buildAppbar {
    return AppBar(
      title: Text(
        'Wishlist',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  //! Build Body
  Widget get _buildBody {
    return Obx(() {
      final products = categoryController.homeController.products;
      final favoriteProducts = products
          .where((product) => favoriteController.isFavorite(product.id))
          .toList();
      if (categoryController.isRefreshing.value) {
        return WishlistShimmerWidget();
      } else if (favoriteProducts.isEmpty) {
        return Center(
          child: Text(
            'No products in your wishlist yet.',
            style: TextStyle(color: AppTheme.darkText, fontSize: 18),
          ),
        );
      }
      return Scrollbar(
        controller: scrollController,
        radius: Radius.circular(15),
        thickness: 7,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: RefreshIndicator(
            onRefresh: categoryController.refreshCategoryProduct,
            backgroundColor: Colors.white,
            color: AppTheme.primary,
            child: ListView.builder(
              controller: scrollController,
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return GestureDetector(
                  onTap: () {
                    RouteView.detail.go(arguments: product);
                  },
                  child: Container(
                    height: 110,
                    margin: EdgeInsets.only(bottom: 10),
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
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 110,
                              height: 110,
                              color: Colors.grey[300],
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                    AppTheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 110,
                              height: 110,
                              color: Colors.grey[300],
                              child: Center(
                                child: Icon(Icons.error, color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${product.category} | ${product.brand}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '\$${product.price.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 16.5,
                                  color: AppTheme.success,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: IconButton(
                                onPressed: () {
                                  favoriteController.toggleFavoriteStatus(
                                    product.id,
                                  );
                                },
                                icon: Icon(Icons.favorite),
                                color: AppTheme.danger,
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
      );
    });
  }
}
