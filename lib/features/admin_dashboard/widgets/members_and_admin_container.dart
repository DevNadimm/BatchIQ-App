import 'package:batchiq_app/core/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MembersAndAdminContainer extends StatelessWidget {
  const MembersAndAdminContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final containerWidth = MediaQuery.sizeOf(context).width / 2.3;

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildInfoContainer(
            context: context,
            width: containerWidth,
            title: "Members",
            count: 120,
            icon: CupertinoIcons.person_2,
            iconBackgroundColor: const Color(0xffC8E6C9),
          ),
          buildInfoContainer(
            context: context,
            width: containerWidth,
            title: "Admin",
            count: 5,
            icon: CupertinoIcons.person_circle,
            iconBackgroundColor: const Color(0xffFFCDD2),
          ),
        ],
      ),
    );
  }

  Widget buildInfoContainer({
    required BuildContext context,
    required double width,
    required String title,
    required int count,
    required IconData icon,
    required Color iconBackgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.black,
                ),
              )
            ],
          ),
          Text(
            count.toString(),
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
