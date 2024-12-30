import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/src/utils/widgets/custom_action_btn.dart';

customDialogBox({
  required String title,
  required Widget content,
  bool? isOkBtn,
  String? okBtnName,
  void Function()? onOkTap,
  void Function()? onCancelTap,
}) {
  return showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.w),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: Theme.of(context).textTheme.bodyMedium!.color),
            content,
          ],
        ),
        actions: isOkBtn == true
            ? [
                CustomActionBtn(name: "Cancel", onTap: onCancelTap),
                CustomActionBtn(name: okBtnName ?? "Ok", onTap: onOkTap),
              ]
            : [],
      );
    },
  );
}
