import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomActionBtn extends StatelessWidget {
  final String name;
  final void Function()? onTap;
  const CustomActionBtn({
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
          borderRadius: BorderRadius.circular(20.r),
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        child: Text(
          name.toUpperCase(),
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
