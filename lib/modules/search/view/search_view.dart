import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/cart/view/cart_view.dart';
import 'package:flutter_ecommerce_app/modules/home/controller/home_controller.dart';
import 'package:flutter_ecommerce_app/modules/search/controller/search_controller.dart';
import 'package:flutter_ecommerce_app/modules/search/widgets/search_result_widget.dart';
import 'package:flutter_ecommerce_app/modules/search/widgets/search_widget.dart';
import 'package:flutter_ecommerce_app/modules/search/widgets/recent_search_widget.dart';
import 'package:get/get.dart';

class SearchView extends GetView<SearchProductController> {
  SearchView({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: _buildCustomScrollView,
      ),
    );
  }

  //! Build CustomScrollView Body + AppBar
  CustomScrollView get _buildCustomScrollView {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          actionsPadding: EdgeInsets.only(right: 8),
          pinned: true,
          backgroundColor: Colors.white,
          title: Text(
            'Search',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: AppTheme.darkBg,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => CartView());
              },
              icon: Badge(
                isLabelVisible: homeController.flashSaleProducts.isNotEmpty,
                backgroundColor: AppTheme.danger,
                label: Text(
                  homeController.flashSaleProducts.length.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                child: Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: SearchWidget(),
          ),
        ),
        SliverToBoxAdapter(child: RecentSearchWidget()),
        SliverToBoxAdapter(child: SizedBox(height: 12)),
        Obx(() {
          if (controller.isTyping.value && controller.searchProducts.isEmpty) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 80),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off_rounded,
                      size: 60,
                      color: AppTheme.greyText.withOpacity(0.5),
                    ),
                    Text(
                      'No products found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.greyText.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      'Try searching for something else',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.greyText.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (controller.searchProducts.isEmpty) {
            return SliverToBoxAdapter(child: SizedBox.shrink());
          }
          return SliverToBoxAdapter(
            child: SearchResultWidget(products: controller.searchProducts),
          );
        }),
      ],
    );
  }
}
