import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryProductShimmerWidget extends StatelessWidget {
  final int itemCount;

  const CategoryProductShimmerWidget({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    final count = itemCount == 0 ? 6 : itemCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category label shimmer
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: _box(width: 140, height: 24, radius: 6),
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(left: 16, right: 16),
            itemCount: count,
            itemBuilder: (context, index) {
              return Container(
                height: 140,
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Row(
                    children: [
                      _box(width: 120, height: 120, radius: 15),
                      SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _box(width: double.infinity, height: 18, radius: 5),
                            SizedBox(height: 8),
                            _box(width: 170, height: 14, radius: 5),
                            SizedBox(height: 8),
                            _box(width: 110, height: 14, radius: 5),
                            SizedBox(height: 8),
                            _box(width: 90, height: 14, radius: 5),
                            Spacer(),
                            _box(width: 80, height: 20, radius: 5),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      _circle(size: 26),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _box({
    required double width,
    required double height,
    required double radius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget _circle({required double size}) {
    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}
