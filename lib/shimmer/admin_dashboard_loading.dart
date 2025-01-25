import 'package:batchiq_app/shimmer/shimmer_container.dart';
import 'package:batchiq_app/shimmer/shimmer_row.dart';
import 'package:flutter/material.dart';

class AdminDashboardLoading extends StatelessWidget {
  const AdminDashboardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerRow(itemCount: 2, width: width / 2.3, height: 100),
          const SizedBox(height: 32),
          const ShimmerContainer(width: 100, height: 30),
          const SizedBox(height: 16),
          Expanded(
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
                  width: double.infinity,
                  height: 100,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
