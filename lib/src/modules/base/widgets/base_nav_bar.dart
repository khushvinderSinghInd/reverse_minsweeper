import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/src/modules/base/controllers/base_controller.dart';
import 'package:minesweeper_game/src/utils/icon_palette.dart';

class BaseNavBar extends StatelessWidget {
  final BaseController bmc;
  const BaseNavBar({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // return CustomNavigationBar(
      //   items: [
      //     CustomNavigationBarItem(icon: const Icon(Icons.home_rounded)),
      //     CustomNavigationBarItem(icon: const Icon(Icons.settings_rounded)),
      //   ],
      //   currentIndex: bmc.onTapChangePageIndex.value,
      //   onTap: bmc.onItemTap,
      //   isFloating: true,
      //   selectedColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      //   strokeColor: Theme.of(context).textTheme.labelSmall!.color!,
      //   backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
      //   borderRadius: Radius.circular(15.r),
      //   iconSize: 26.sp,
      // );
      return AnimatedNotchBottomBar(
        notchBottomBarController: bmc.controller.value,
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        kBottomRadius: 32.r,
        itemLabelStyle: TextStyle(
          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        ),
        notchColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
        removeMargins: false,
        showShadow: true,
        durationInMilliSeconds: 300,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home_rounded,
              color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            ),
            activeItem: Icon(
              Icons.home_rounded,
              color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            ),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Image.asset(AppIcons.gameIcon),
            activeItem: Image.asset(AppIcons.gameIcon),
            itemLabel: 'Mode',
          ),
          BottomBarItem(
            inActiveItem:  Icon(Icons.settings_rounded,
              color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            ),
            activeItem: Icon(
              Icons.settings_rounded,
              color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            ),
            itemLabel: 'Settings',
          ),
        ],
        onTap: bmc.onItemTap,
        kIconSize: 24.sp,
      );
    });
  }
}
