import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/cart/view/cart_view.dart';
import 'package:flutter_ecommerce_app/modules/category/view/category_view.dart';
import 'package:flutter_ecommerce_app/modules/favorite/view/favorite_view.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/accessories_category_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/audio_category_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/banner_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/best_selling_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/bottom_navigation_bar.widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/categories_widget.dart';
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
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Obx(() {
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
          appBar: currentIndex == 0 ? _buildAppbar : null,
          body: currentView,
          bottomNavigationBar: BottomNavigationBarWidget(),
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
        width: 140,
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
                  icon: Icon(Icons.shopping_cart_outlined),
                ),
              ],
            ),
            Positioned(
              right: 4,
              top: 4,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppTheme.danger,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '0',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //! Build Body
  ListView get _buildBody {
    return ListView(
      children: [
        BannerWidget(),
        TitleWidget(title: 'Categories 🛍️', onTap: () {}),
        CategoriesWidget(),
        TitleWidget(title: 'Flash Sale ⚡️', onTap: () {}),
        FlashSaleWidget(),
        TitleWidget(title: 'Best Selling 🔥', onTap: () {}),
        BestSellingWidget(),
        TitleWidget(title: 'Phones 📱', onTap: () {}),
        PhoneCategoryWidget(),
        TitleWidget(title: 'Laptops 💻', onTap: () {}),
        LaptopCategoryWidget(),
        TitleWidget(title: 'Watches ⌚', onTap: () {}),
        WatchCategoryWidget(),
        TitleWidget(title: 'Audio 🎧', onTap: () {}),
        AudioCategoryWidget(),
        TitleWidget(title: 'Accessories 🎒', onTap: () {}),
        AccessoriesCategoryWidget(),
        TitleWidget(title: 'Gaming 🎮', onTap: () {}),
        GamingCategoryWidget(),
      ],
    );
  }
}
