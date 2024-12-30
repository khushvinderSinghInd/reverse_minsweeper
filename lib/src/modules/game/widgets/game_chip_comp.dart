import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameChipComp extends StatelessWidget {
  final double size;
  final String? name;
  final Color? color;
  const GameChipComp({
    required this.size,
    this.name,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.h,
      height: size.h,
      margin: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: color ?? Colors.grey[300],
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          // Outer shadow for elevation
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(10, 10),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          // Inner shadow for depth effect
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-10, -10),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade400,
          ],
        ),
      ),
      child: Center(
        child: Text(name ?? ""),
      ),
    );
  }
}
