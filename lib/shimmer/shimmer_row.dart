import 'package:batchiq_app/shimmer/shimmer_container.dart';
import 'package:flutter/material.dart';

class ShimmerRow extends StatelessWidget {
  final int itemCount;
  final double width;
  final double height;

  const ShimmerRow({
    required this.itemCount,
    required this.width,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        itemCount,
            (index) => ShimmerContainer(width: width, height: height),
      ),
    );
  }
}