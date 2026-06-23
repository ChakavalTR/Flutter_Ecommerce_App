import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/cart/controller/cart_controller.dart';
import 'package:flutter_ecommerce_app/modules/favorite/controller/favorite_controller.dart';
import 'package:flutter_ecommerce_app/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class BottomNavigationBarWidget extends GetView<HomeController> {
  BottomNavigationBarWidget({super.key});
  final favoriteController = Get.find<FavoriteController>();
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentIndex = controller.currentIndex.value;
      final favoriteCount = favoriteController.favoriteProducts.length;
      final cartCount = cartController.cartItems.length;
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
              icon: Badge(
                isLabelVisible: favoriteCount > 0,
                backgroundColor: AppTheme.danger,
                label: Text(
                  favoriteCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: currentIndex == 2
                    ? Icon(Icons.favorite, size: 28)
                    : Icon(Icons.favorite_border, size: 28),
              ),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: cartCount > 0,
                backgroundColor: AppTheme.danger,
                label: Text(
                  cartCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: currentIndex == 3
                    ? Icon(Icons.shopping_cart, size: 28)
                    : Icon(Icons.shopping_cart_outlined, size: 28),
              ),
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
