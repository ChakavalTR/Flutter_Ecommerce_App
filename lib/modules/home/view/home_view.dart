import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/cart/view/cart_view.dart';
import 'package:flutter_ecommerce_app/modules/category/view/category_view.dart';
import 'package:flutter_ecommerce_app/modules/favorite/view/favorite_view.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/banner_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/best_selling_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/categories_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/flash_sale_widget.dart';
import 'package:flutter_ecommerce_app/modules/home/widgets/title_widget.dart';
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
          bottomNavigationBar: _buildBottomNavigationBar,
        );
      }),
    );
  }

  //! Build AppBar
  AppBar get _buildAppbar {
    return AppBar(
      centerTitle: false,
      actionsPadding: EdgeInsets.only(right: 8),
      title: RichText(
        text: TextSpan(
          text: 'E',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: AppTheme.primary,
          ),
          children: [
            TextSpan(
              text: '-Shop',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppTheme.darkBg,
              ),
            ),
          ],
        ),
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
                  onPressed: () {},
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
      ],
    );
  }

  //! Build Bottom Navigation Bar
  Obx get _buildBottomNavigationBar {
    return Obx(() {
      final currentIndex = controller.currentIndex.value;
      return SizedBox(
        height: 93,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: controller.changeBottomNav,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppTheme.primary,
          unselectedItemColor: AppTheme.greyText,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          items: [
            BottomNavigationBarItem(
              icon: currentIndex == 0
                  ? Icon(Icons.home, size: 28)
                  : Icon(Icons.home_outlined, size: 28),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 1
                  ? Icon(Icons.category, size: 28)
                  : Icon(Icons.category_outlined, size: 28),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 2
                  ? Icon(Icons.favorite, size: 28)
                  : Icon(Icons.favorite_border, size: 28),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 3
                  ? Icon(Icons.shopping_cart, size: 28)
                  : Icon(Icons.shopping_cart_outlined, size: 28),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 4
                  ? Icon(Icons.person, size: 28)
                  : Icon(Icons.person_outline, size: 28),
              label: 'Profile',
            ),
          ],
        ),
      );
    });
  }
}
