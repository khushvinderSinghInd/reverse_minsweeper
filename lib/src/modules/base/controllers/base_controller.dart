import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/src/modules/game/controllers/game_setup_controller.dart';
import 'package:minesweeper_game/src/modules/game/screens/game_mode_screen.dart';
import 'package:minesweeper_game/src/modules/home/screens/home_screen.dart';
import 'package:minesweeper_game/src/modules/settings/controllers/settings_controller.dart';
import 'package:minesweeper_game/src/modules/settings/screens/settings_screen.dart';

class BaseController extends GetxController {
  final sc = Get.put(SettingsController());
  final gsc = Get.put(GameSetupController());

  final pages = const [
    HomeScreen(),
    GameModeScreen(),
    SettingsScreen(),
  ];
  final onTapChangePageIndex = 0.obs;
  final pageController = PageController(initialPage: 1).obs;
  final controller = NotchBottomBarController(index: 1).obs;

  void onPageChanged(int index) {
    onTapChangePageIndex.value = index;
  }

  void onItemTap(int selectedItem) {
    pageController.value.animateToPage(
      selectedItem,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
    onTapChangePageIndex.value = selectedItem;
  }
}
