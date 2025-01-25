import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/admin_grid_content_list.dart';
import 'package:batchiq_app/core/constants/grid_content_class.dart';
import 'package:flutter/material.dart';

class AdminContentGrid extends StatelessWidget {
  const AdminContentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<GridContent> contentList = adminGridContentList;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: contentList.length,
        itemBuilder: (BuildContext context, int index) {
          final GridContent grid = contentList[index];
          return GestureDetector(
            onTap: () => grid.onTapAdmin!(),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: shadeColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: grid.color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      grid.iconPath,
                      scale: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    grid.name,
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    grid.adminDescription!,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: secondaryFontColor),
                  )
                ],
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
      ),
    );
  }
}
