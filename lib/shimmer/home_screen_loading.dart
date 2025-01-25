import 'package:batchiq_app/core/colors/colors.dart';
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

class HomeScreenLoading extends StatelessWidget {
  const HomeScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Row(
          children: [
            ShimmerContainer(width: 30, height: 30),
            SizedBox(width: 10),
            ShimmerContainer(width: 120, height: 30),
          ],
        ),
        actions: const [
          ShimmerContainer(width: 30, height: 30),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: ShimmerRow(itemCount: 3, width: 100, height: 50),
          ),
          const SizedBox(height: 8),

          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerContainer(width: 130, height: 30),
                SizedBox(height: 8),
                ShimmerContainer(width: 130, height: 30),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      ShimmerContainer(width: 250, height: 130),
                      SizedBox(width: 16),
                      ShimmerContainer(width: 250, height: 130),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return const ShimmerContainer(width: double.infinity, height: 100);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
