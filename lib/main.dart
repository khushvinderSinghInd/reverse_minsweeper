import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/firebase_options.dart';
import 'package:minesweeper_game/src/modules/auth/screens/splash_screen.dart';

import 'package:minesweeper_game/src/services/app_theme.dart';
import 'package:minesweeper_game/src/services/local_db.dart';
import 'package:minesweeper_game/src/services/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {});
  await SqlDBService.sqlDBServiceinstance.database;
  final bool isDark = await SharedPrefs.getBool(key: "isDarkTheme") ?? false;
  final bool isLoggedIn = await SharedPrefs.getBool(key: "isLoggedIn") ?? false;
  Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  runApp(
    MainApp(isLoggedIn: isLoggedIn),
  );
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  const MainApp({required this.isLoggedIn, super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(isLoggedIn: isLoggedIn),
          theme: AppTheme.baseTheme,
          darkTheme: AppTheme.darkTheme,
        );
      },
    );
  }
}