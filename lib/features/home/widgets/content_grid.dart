import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/grid_content_list.dart';
import 'package:flutter/material.dart';

class ContentGrid extends StatelessWidget {
  const ContentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: gridContentList.length,
        itemBuilder: (BuildContext context, int index) {
          final GridContent grid = gridContentList[index];
          return Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  grid.icon,
                  color: Colors.white,
                ),
                Text(
                  grid.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.6,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
      ),
    );
  }
}
