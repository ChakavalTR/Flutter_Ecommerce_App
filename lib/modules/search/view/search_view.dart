import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/cart/controller/cart_controller.dart';
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
  final cartController = Get.find<CartController>();
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
              icon: Obx(() {
                return Badge(
                  isLabelVisible: cartController.cartItems.isNotEmpty,
                  backgroundColor: AppTheme.danger,
                  label: Text(
                    cartController.cartItems.length.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  child: Icon(Icons.shopping_cart_outlined),
                );
              }),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: SearchWidget(),
          ),
        ),
        Obx(() {
          if (!controller.isTyping.value) {
            return SliverToBoxAdapter(child: RecentSearchWidget());
          }
          if (!controller.isSuggestionSelected.value &&
              controller.suggestions.isNotEmpty) {
            return SliverToBoxAdapter(
              child: Column(
                children: controller.suggestions.map((item) {
                  return ListTile(
                    leading: Icon(Icons.search, color: Colors.grey),
                    title: Text(
                      item,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.north_west, color: Colors.grey),
                    onTap: () {
                      controller.selectSuggestion(item);
                    },
                  );
                }).toList(),
              ),
            );
          }
          return SliverToBoxAdapter(
            child: SearchResultWidget(products: controller.searchProducts),
          );
        }),
      ],
    );
  }
}
