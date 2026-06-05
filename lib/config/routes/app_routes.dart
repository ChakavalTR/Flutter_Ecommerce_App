import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/modules/category/binding/category_binding.dart';
import 'package:flutter_ecommerce_app/modules/category/view/category_view.dart';
import 'package:flutter_ecommerce_app/modules/detail/binding/detail_binding.dart';
import 'package:flutter_ecommerce_app/modules/detail/view/detail_view.dart';
import 'package:flutter_ecommerce_app/modules/home/view/home_view.dart';
import 'package:flutter_ecommerce_app/modules/search/binding/search_binding.dart';
import 'package:flutter_ecommerce_app/modules/search/view/search_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AppRouting {
  static final route = RouteView.values.map((e) {
    switch (e) {
      case RouteView.home:
        return GetPage(
          name: "/",
          page: () => HomeView(),
          transition: Transition.noTransition,
        );
      case RouteView.search:
        return GetPage(
          name: "/${e.name}",
          page: () => SearchView(),
          binding: SearchBinding(),
          transition: Transition.native,
        );
      case RouteView.detail:
        return GetPage(
          name: "/${e.name}",
          page: () => DetailView(),
          binding: DetailBinding(),
          transition: Transition.native,
        );
      case RouteView.category:
        return GetPage(
          name: "/${e.name}",
          page: () => CategoryView(),
          binding: CategoryBinding(),
          transition: Transition.native,
        );
    }
  }).toList();
}
