import 'package:flutter/material.dart';
import 'package:minesweeper_game/src/utils/color_palette.dart';

class AppTheme {
  static final baseTheme = ThemeData(
    useMaterial3: true,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    canvasColor: Colors.transparent,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColor.rhino),
      bodySmall: TextStyle(color: AppColor.rhino),
      labelSmall: TextStyle(color: AppColor.rhino),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.porsche,
        iconTheme: IconThemeData(color: AppColor.rhino)),
    scaffoldBackgroundColor: AppColor.porsche,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.rhino,
      selectedItemColor: AppColor.porsche,
      unselectedItemColor: AppColor.porsche,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    canvasColor: Colors.transparent,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColor.porsche),
      bodySmall: TextStyle(color: AppColor.porsche),
      labelSmall: TextStyle(color: AppColor.porsche),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.rhino,
      iconTheme: IconThemeData(color: AppColor.porsche),
    ),
    scaffoldBackgroundColor: AppColor.rhino,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.porsche,
      selectedItemColor: AppColor.rhino,
      unselectedItemColor: AppColor.rhino,
    ),
  );
}
