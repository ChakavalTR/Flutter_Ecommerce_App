import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/cart/view/cart_view.dart';
import 'package:flutter_ecommerce_app/modules/home/controller/home_controller.dart';
import 'package:flutter_ecommerce_app/modules/search/controller/search_controller.dart';
import 'package:flutter_ecommerce_app/modules/search/widgets/search_widget.dart';
import 'package:flutter_ecommerce_app/modules/search/widgets/title_widget.dart';
import 'package:get/get.dart';

class SearchView extends GetView<SearchProductController> {
  SearchView({super.key});
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: _buildBody,
      ),
    );
  }

  //! Build AppBar
  AppBar get _buildAppBar {
    return AppBar(
      actionsPadding: EdgeInsets.only(right: 8),
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
            child: const Icon(Icons.shopping_cart_outlined),
          ),
        ),
      ],
    );
  }

  //! Build Body
  Widget get _buildBody {
    return Column(
      children: [
        SearchWidget(),
        TitleWidget(title: 'Recent Searches', onTap: () {}),
      ],
    );
  }
}
