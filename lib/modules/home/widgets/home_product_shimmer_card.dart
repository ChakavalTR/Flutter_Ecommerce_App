import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeProductShimmerWidget extends StatelessWidget {
  const HomeProductShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const SizedBox(height: 12),
        _shimmerBox(height: 170, radius: 20),

        const SizedBox(height: 20),
        _titleShimmer(),

        const SizedBox(height: 12),
        SizedBox(
          height: 45,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, __) {
              return _shimmerBox(width: 90, height: 40, radius: 20);
            },
          ),
        ),

        const SizedBox(height: 20),
        _titleShimmer(),
        const SizedBox(height: 12),
        _horizontalProductShimmer(),

        const SizedBox(height: 20),
        _titleShimmer(),
        const SizedBox(height: 12),
        _horizontalProductShimmer(),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _titleShimmer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _shimmerBox(width: 150, height: 22, radius: 6),
        _shimmerBox(width: 60, height: 16, radius: 6),
      ],
    );
  }

  Widget _horizontalProductShimmer() {
    return SizedBox(
      height: 230,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, __) {
          return Container(
            width: 160,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _plainBox(width: double.infinity, height: 120, radius: 15),
                  const SizedBox(height: 10),
                  _plainBox(width: 130, height: 16, radius: 5),
                  const SizedBox(height: 8),
                  _plainBox(width: 90, height: 14, radius: 5),
                  const Spacer(),
                  _plainBox(width: 70, height: 18, radius: 5),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _shimmerBox({
    double? width,
    required double height,
    required double radius,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: _plainBox(width: width, height: height, radius: radius),
    );
  }

  Widget _plainBox({
    double? width,
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
}
