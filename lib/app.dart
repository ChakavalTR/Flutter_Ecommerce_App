import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:flutter_ecommerce_app/config/routes/app_routes.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/home/binding/home_binding.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      //! Theme
      theme: AppTheme.lightTheme,

      //! Routing(),
      getPages: AppRouting.route,
      initialRoute: RouteView.adSplash.name,
      initialBinding: HomeBinding(),
    );
  }
}
