import 'package:batchiq_app/core/colors/colors.dart';
import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final Color? color;
  final double? size;

  const ProgressIndicatorWidget({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size ?? 40,
        height: size ?? 40,
        child: CircularProgressIndicator(
          color: color ?? primaryColor,
        ),
      ),
    );
  }
}
