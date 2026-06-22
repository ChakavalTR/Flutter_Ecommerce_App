import 'dart:async';
import 'package:flutter_ecommerce_app/config/routes/app_pages.dart';
import 'package:get/get.dart';

class AdSplashController extends GetxController {
  //* Variables Section *\\
  final countdown = 3.obs;
  Timer? _timer;
  //--------------------------------------------
  //* Lifecycle Section *\\
  @override
  void onInit() {
    startCountdown();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  //--------------------------------------------
  //* Functions Section *\\
  //! Start Countdown
  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value <= 1) {
        timer.cancel();
        RouteView.home.go(clearAll: true);
      } else {
        countdown.value--;
      }
    });
  }
}
