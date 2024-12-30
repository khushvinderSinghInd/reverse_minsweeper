import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/src/extensions/space_ext.dart';
import 'package:minesweeper_game/src/modules/auth/widgets/guest_login_comp.dart';
import 'package:minesweeper_game/src/modules/auth/widgets/social_login_comp.dart';
import 'package:minesweeper_game/src/utils/icon_palette.dart';
import 'package:minesweeper_game/src/utils/widgets/shimmer_text.dart';

import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ac = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Stack(
          children: [
            Positioned.fill(
              child: FadeTransition(
                opacity: ac.animation.value!,
                child: Column(
                  children: [
                    50.height,
                    ShimmerText(
                      data: "Welcome To",
                      size: 30.sp,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ],
                ),
              ),
            ),
            AnimatedBuilder(
              animation: ac.animation.value!,
              builder: (context, child) {
                double topPosition = 80 + (1 - ac.animation.value!.value) * 300;
                return Positioned(
                  top: topPosition,
                  child: Hero(
                    tag: 'splashLogo',
                    child: Image.asset(
                      AppIcons.appIcon,
                      height: 300.h,
                      width: 300.h,
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
                animation: ac.animation.value!,
                builder: (context, child) {
                  return Positioned(
                    top: 370.h + (1 - ac.animation.value!.value) * 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GuestLoginComp(ac: ac),
                        SocialLoginComp(ac: ac),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.to(() => const BaseClass());
      //   },
      //   backgroundColor: AppColor.porsche,
      // ),
    );
  }
}
