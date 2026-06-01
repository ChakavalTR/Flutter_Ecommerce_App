import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/modules/detail/controller/detail_controller.dart';
import 'package:get/get.dart';

class ImagePreviewView extends GetView<DetailController> {
  final int initialIndex;
  const ImagePreviewView({super.key, required this.initialIndex});
  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: initialIndex);
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragEnd: (_) => Navigator.pop(context),
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              onPageChanged: controller.changeImageIndex,
              itemCount: controller.productImages.length,
              itemBuilder: (context, index) {
                final image = controller.productImages[index];
                return Center(
                  child: Hero(
                    tag: '${image}_$index',
                    child: InteractiveViewer(
                      minScale: 1,
                      maxScale: 5,
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 75,
              left: 10,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, color: Colors.white, size: 30),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 190,
              child: Obx(() {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[700]?.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${controller.currentImageIndex.value + 1}/${controller.productImages.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
