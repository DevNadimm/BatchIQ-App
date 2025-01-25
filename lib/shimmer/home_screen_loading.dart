import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/shimmer/shimmer_container.dart';
import 'package:batchiq_app/shimmer/shimmer_row.dart';
import 'package:flutter/material.dart';

class HomeScreenLoading extends StatelessWidget {
  const HomeScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

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
          Padding(
            padding: const EdgeInsets.all(16),
            child: ShimmerRow(itemCount: 3, width: width / 3.6, height: 50),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerContainer(width: width / 2.7, height: 30),
                const SizedBox(height: 8),
                ShimmerContainer(width: width / 2.7, height: 30),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      ShimmerContainer(width: width / 1.5, height: 130),
                      const SizedBox(width: 16),
                      ShimmerContainer(width: width / 1.5, height: 130),
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
                  return const ShimmerContainer(
                      width: double.infinity, height: 100);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
