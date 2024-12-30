import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPlayBtn extends StatelessWidget {
  final String name;
  final void Function()? onTap;
  const CustomPlayBtn({
    required this.name,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
        child: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          ),
        ),
      ),
    );
  }
}
