import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minesweeper_game/src/utils/color_palette.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerText extends StatelessWidget {
  final String data;
  final double? size;
  final Color? color;
  const ShimmerText({
    required this.data,
    this.size,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color ?? AppColor.silver,
      highlightColor: Colors.white,
      child: Text(
        data,
        style: TextStyle(
          fontSize: size ?? 45.sp,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
