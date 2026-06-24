import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/cart/controller/cart_controller.dart';
import 'package:flutter_ecommerce_app/modules/cart/view/cart_view.dart';
import 'package:flutter_ecommerce_app/modules/category/controller/category_controller.dart';
import 'package:flutter_ecommerce_app/modules/category/view/category_view.dart';
import 'package:flutter_ecommerce_app/modules/favorite/view/favorite_view.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/accessories_category_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/audio_category_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/banner_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/best_selling_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/bottom_navigation_bar.widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/home_product_shimmer_card.dart';
import 'package:flutter_ecommerce_app/widgets/categories_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/flash_sale_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/gaming_category_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/laptops_category_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/phones_category_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/title_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/watches_category_widget.dart';
import 'package:flutter_ecommerce_app/modules/profile/view/profile_view.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Obx(() {
        if (!Get.isRegistered<CategoryController>()) {
          Get.put(CategoryController());
        }
        final view = [
          _buildBody,
          CategoryView(),
          FavoriteView(),
          CartView(),
          ProfileView(),
        ];
        final currentIndex = controller.currentIndex.value;
        final currentView = view[currentIndex];
        return Scaffold(
          appBar: currentIndex == 0
              ? PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: Obx(() {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: controller.isShowBars.value
                          ? _buildAppbar
                          : SizedBox.shrink(),
                    );
                  }),
                )
              : null,
          body: currentIndex == 0
              ? Obx(() {
                  if (controller.isRefreshing.value) {
                    return HomeProductShimmerWidget();
                  }
                  return RefreshIndicator(
                    backgroundColor: Colors.white,
                    color: AppTheme.primary,
                    onRefresh: () async {
                      await controller.refreshHome();
                    },
                    child: _buildBody,
                  );
                })
              : currentView,
          bottomNavigationBar: Obx(() {
            return ClipRect(
              child: AnimatedSize(
                duration: Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: SizedBox(
                  height: controller.isShowBars.value ? null : 0,
                  child: controller.isShowBars.value
                      ? BottomNavigationBarWidget()
                      : SizedBox.shrink(),
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  //! Build AppBar
  AppBar get _buildAppbar {
    return AppBar(
      centerTitle: false,
      actionsPadding: EdgeInsets.only(right: 8),
      titleSpacing: 4,
      title: SizedBox(
        width: 130,
        child: Image.asset('assets/icons/logo_icon.png', fit: BoxFit.fitWidth),
      ),
      actions: [
        Stack(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    RouteView.search.go();
                  },
                  icon: Icon(Icons.search_outlined),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(() => CartView());
                  },
                  icon: Badge(
                    isLabelVisible: cartController.cartItems.isNotEmpty,
                    backgroundColor: AppTheme.danger,
                    label: Text(
                      cartController.cartItems.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Icon(Icons.shopping_cart_outlined),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  //! Build Body
  ListView get _buildBody {
    final isSelectedCategory = controller.selectedCategory.value;
    return ListView(
      controller: controller.homeScrollController,
      children: [
        BannerWidget(),
        TitleWidget(
          title: 'Categories 🛍️',
          onTap: () {
            Get.find<CategoryController>().selectCategoryByName('All');
            RouteView.category.go();
          },
        ),
        CategoriesWidget(
          categories: controller.categories,
          selectedIndex: controller.selectedCategory.value,
          onTap: (index) {
            controller.selectCategory(index);
          },
        ),
        if (isSelectedCategory == 0) ...[
          TitleWidget(title: 'Flash Sale ⚡️'),
          FlashSaleWidget(),
          SizedBox(height: 10),
          TitleWidget(title: 'Recommend For You 🌟'),
          SizedBox(height: 10),
          BestSellingWidget(),
          TitleWidget(
            title: 'Phones 📱',
            onTap: () {
              Get.find<CategoryController>().selectCategoryByName('Phones');
              RouteView.category.go();
            },
          ),
          PhoneCategoryWidget(),
          TitleWidget(
            title: 'Laptops 💻',
            onTap: () {
              Get.find<CategoryController>().selectCategoryByName('Laptops');
              RouteView.category.go();
            },
          ),
          LaptopCategoryWidget(),
          TitleWidget(
            title: 'Watches ⌚',
            onTap: () {
              Get.find<CategoryController>().selectCategoryByName('Watches');
              RouteView.category.go();
            },
          ),
          WatchCategoryWidget(),
          TitleWidget(
            title: 'Audio 🎧',
            onTap: () {
              Get.find<CategoryController>().selectCategoryByName('Audio');
              RouteView.category.go();
            },
          ),
          AudioCategoryWidget(),
          TitleWidget(
            title: 'Accessories 🎒',
            onTap: () {
              Get.find<CategoryController>().selectCategoryByName(
                'Accessories',
              );
              RouteView.category.go();
            },
          ),
          AccessoriesCategoryWidget(),
          TitleWidget(
            title: 'Gaming 🎮',
            onTap: () {
              Get.find<CategoryController>().selectCategoryByName('Gaming');
              RouteView.category.go();
            },
          ),
          GamingCategoryWidget(),
        ],
        if (isSelectedCategory == 1) ...[
          TitleWidget(
            title: 'Phones 📱',
            onTap: () {
              Get.find<CategoryController>().selectCategoryByName('Phones');
              RouteView.category.go();
            },
          ),
          PhoneCategoryWidget(),
        ],
        if (isSelectedCategory == 2) ...[
          TitleWidget(
            title: 'Laptops 💻',
            onTap: () {
              Get.find<CategoryController>().selectCategoryByName('Laptops');
              RouteView.category.go();
            },
          ),
          LaptopCategoryWidget(),
        ],
        if (isSelectedCategory == 3) ...[
          TitleWidget(
            title: 'Watches ⌚',
            onTap: () {
              Get.find<CategoryController>().selectCategoryByName('Watches');
              RouteView.category.go();
            },
          ),
          WatchCategoryWidget(),
        ],
        if (isSelectedCategory == 4) ...[
          TitleWidget(
            title: 'Audio 🎧',
            onTap: () {
              Get.find<CategoryController>().selectCategoryByName('Audio');
              RouteView.category.go();
            },
          ),
          AudioCategoryWidget(),
        ],
        if (isSelectedCategory == 5) ...[
          TitleWidget(
            title: 'Accessories 🎒',
            onTap: () {
              Get.find<CategoryController>().selectCategoryByName(
                'Accessories',
              );
              RouteView.category.go();
            },
          ),
          AccessoriesCategoryWidget(),
        ],
        if (isSelectedCategory == 6) ...[
          TitleWidget(
            title: 'Gaming 🎮',
            onTap: () {
              Get.find<CategoryController>().selectCategoryByName('Gaming');
              RouteView.category.go();
            },
          ),
          GamingCategoryWidget(),
        ],
      ],
    );
  }
}
