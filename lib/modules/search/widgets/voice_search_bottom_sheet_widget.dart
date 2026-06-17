import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/config/theme/app_theme.dart';
import 'package:flutter_ecommerce_app/modules/search/controller/search_controller.dart';
import 'package:get/get.dart';

class VoiceSearchBottomSheetWidget extends GetView<SearchProductController> {
  const VoiceSearchBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Obx(() {
        return Column(
          children: [
            Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              controller.isListening.value
                  ? 'Listening...'
                  : 'Tap mic to speak',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 1,
                end: controller.isListening.value ? 1.25 : 1,
              ),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              builder: (context, scale, child) {
                return AnimatedScale(
                  scale: scale,
                  duration: const Duration(milliseconds: 600),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.isListening.value
                          ? AppTheme.primary.withOpacity(0.15)
                          : Colors.grey.shade100,
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (controller.isListening.value) {
                          controller.stopListening();
                        } else {
                          controller.startListening();
                        }
                      },
                      icon: Icon(
                        controller.isListening.value
                            ? Icons.mic
                            : Icons.mic_none_outlined,
                        size: 42,
                        color: controller.isListening.value
                            ? AppTheme.primary
                            : Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                controller.stopListening();
                Get.back();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      }),
    );
  }
}
