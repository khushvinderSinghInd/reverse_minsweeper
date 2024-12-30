import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTileComp extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final bool isSmall;
  final bool isCenter;
  const CustomListTileComp({
    required this.title,
    this.leading,
    this.trailing,
    this.isSmall = false,
    this.isCenter = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context)
            .bottomNavigationBarTheme
            .backgroundColor!
            .withOpacity(0.2),
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.all(10.r),
      child: isCenter
          ? ListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: isSmall
                  ? const VisualDensity(horizontal: -4, vertical: -4)
                  : VisualDensity(horizontal: -2.w, vertical: -2.h),
              title: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            )
          : ListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: isSmall
                  ? const VisualDensity(horizontal: -4, vertical: -4)
                  : VisualDensity(horizontal: -2.w, vertical: -2.h),
              title: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
              leading: leading,
              trailing: trailing,
            ),
    );
  }
}
