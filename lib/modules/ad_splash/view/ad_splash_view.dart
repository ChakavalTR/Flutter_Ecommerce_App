import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/ad_splash_controller.dart';

class AdSplashView extends GetView<AdSplashController> {
  const AdSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody);
  }

  //! Build Body
  Widget get _buildBody {
    return Obx(() {
      return Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/ad_splash.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 20,
            bottom: 40,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              child: Text(
                controller.countdown.value.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
