import 'package:get/get.dart';
import '../controller/ad_splash_controller.dart';

class AdSplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdSplashController>(() => AdSplashController());
  }
}
