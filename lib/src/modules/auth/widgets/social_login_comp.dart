import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/src/modules/auth/controllers/auth_controller.dart';
import 'package:minesweeper_game/src/utils/icon_palette.dart';

class SocialLoginComp extends StatelessWidget {
  final AuthController ac;
  const SocialLoginComp({required this.ac, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Get.width - 40,
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "or",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            final res = await ac.loginWithGoogle();
            ac.handleLoginSession(res);
          },
          child: Image.asset(
            AppIcons.googleIcon,
            height: 30.h,
          ),
        ),
      ],
    );
  }
}
