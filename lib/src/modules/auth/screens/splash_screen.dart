import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/src/modules/auth/screens/login_screen.dart';
import 'package:minesweeper_game/src/modules/base/screens/base_class.dart';
import 'package:minesweeper_game/src/utils/icon_palette.dart';

class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;
  const SplashScreen({required this.isLoggedIn, super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 2500),
      () {
        Get.off(
          () => widget.isLoggedIn ? const BaseClass() :  const LoginScreen(),
          transition: Transition.fade,
          duration: const Duration(seconds: 1),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'splashLogo',
          child: Image.asset(
            AppIcons.appIcon,
            width: 200.h,
            height: 200.h,
          ),
        ),
      ),
    );
  }
}
