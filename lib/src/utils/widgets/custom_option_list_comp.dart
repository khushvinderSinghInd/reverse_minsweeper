import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOptionListComp extends StatelessWidget {
  final List listData;
  final bool leading;
  final Widget? trailing;
  final void Function(int)? onTap;
  const CustomOptionListComp({
    required this.listData,
    this.leading = false,
    this.trailing,
    this.onTap,
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
      // padding: EdgeInsets.all(10.r),
      child: Column(
        children: List.generate(listData.length, (index) {
          return Column(
            children: [
              ListTile(
                onTap: () => onTap!(index),
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                title: Text(
                  listData[index]["title"],
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
                leading: leading
                    ? Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        height: 30.h,
                        width: 30.h,
                        padding: EdgeInsets.all(6.r),
                        child: Image.asset(
                          listData[index]["icon"],
                        ),
                      )
                    : null,
                trailing: trailing ??
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
              ),
              index == listData.length - 1
                  ? const SizedBox()
                  : Divider(
                      height: 0,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    )
            ],
          );
        }),
      ),
    );
  }
}
