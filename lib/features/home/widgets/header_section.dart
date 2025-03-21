import 'package:batchiq_app/core/colors/colors.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final double height;
  final int assignmentCount;
  final int examCount;

  const HeaderSection({
    super.key,
    this.height = 100,
    required this.assignmentCount,
    required this.examCount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: height / 2,
              color: primaryColor,
            ),
            Container(
              height: height / 2,
              color: Colors.transparent,
            ),
          ],
        ),
        Positioned.fill(
          child: Row(
            children: [
              Container(
                height: height,
                width: 16,
                color: Colors.transparent,
              ),
              Expanded(
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 10,
                        blurRadius: 8,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stat(number: assignmentCount.toString().padLeft(2, "0"), label: "ASSIGNMENTS"),
                      // Stat(number: "92", label: "CLASSES"),
                      Stat(number: examCount.toString().padLeft(2, "0"), label: "EXAMS"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Stat extends StatelessWidget {
  final String number;
  final String label;

  const Stat({
    super.key,
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
