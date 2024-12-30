import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/src/models/user_details_model.dart';
import 'package:minesweeper_game/src/modules/auth/controllers/auth_controller.dart';
import 'package:minesweeper_game/src/services/local_db.dart';
import 'package:minesweeper_game/src/services/shared_prefs.dart';
import 'package:minesweeper_game/src/utils/icon_palette.dart';
import 'package:minesweeper_game/src/utils/widgets/custom_dialog_box.dart';

class SettingsController extends GetxController {
  final ac = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());

  @override
  void onInit() async {
    await getThemeMode();
    await getSoundMode();
    await getUserDetails();
    await getGuestMode();
    super.onInit();
  }

  final themeMode = "Light Theme".obs;
  final isDarkTheme = false.obs;
  getThemeMode() async {
    isDarkTheme.value = await SharedPrefs.getBool(key: "isDarkTheme") ?? false;
    themeMode.value = isDarkTheme.value ? "Dark Theme" : "Light Theme";
  }

  updateThemeChanges(v) async {
    if (v) {
      Get.changeThemeMode(ThemeMode.dark);
      await SharedPrefs.setBool(key: "isDarkTheme", value: v);
      themeMode.value = "Dark Theme";
    } else {
      Get.changeThemeMode(ThemeMode.light);
      await SharedPrefs.setBool(key: "isDarkTheme", value: v);
      themeMode.value = "Light Theme";
    }
  }

  final soundMode = "Sounds On".obs;
  final isSoundOn = true.obs;
  getSoundMode() async {
    isSoundOn.value = await SharedPrefs.getBool(key: "isSoundOn") ?? false;
    soundMode.value = isSoundOn.value ? "Sounds On" : "Sounds Off";
  }

  Future<bool> getGuestMode() async {
   return await SharedPrefs.getBool(key: "isGuestPlay") ?? false;
  }



  updateSoundChanges(v) async {
    if (v) {
      await SharedPrefs.setBool(key: "isSoundOn", value: v);
      soundMode.value = "Sounds On";
    } else {
      await SharedPrefs.setBool(key: "isSoundOn", value: v);
      soundMode.value = "Sounds Off";
    }
  }

  playSoundEffects(sound) async {
    if (isSoundOn.value) {
      final audioPlayer = AudioPlayer();
      await audioPlayer.play(AssetSource(sound));
    }
  }

  final userData = Rxn<UserDetailsModel>();

  getUserDetails() async {
    final res = await SqlDBService.sqlDBServiceinstance.getUserDetails();
    log("$res");
    for (var i = 0; i < res.length; i++) {
      var e = res[i];
      userData.value = UserDetailsModel(
        uid: e["uid"],
        userName: e["user_full_name"],
        userEmail: e["user_email"],
        userImage: e["user_image"],
      );
    }
    userData.refresh();
  }

  final settingOptions = [
    {
      "title": "How To Play",
      "icon": AppIcons.howToIcon,
    },
    {
      "title": "Rules",
      "icon": AppIcons.rulesIcon,
    },
    {
      "title": "Help",
      "icon": AppIcons.helpIcon,
    },
    {
      "title": "About Game",
      "icon": AppIcons.aboutIcon,
    },
  ];

  final userAuthOptions = [
    {
      "title": "Log Out",
      "icon": AppIcons.logOutIcon,
    },
    {
      "title": "Delete Account",
      "icon": AppIcons.deleteAccIcon,
    },
  ];

  userAuthTapHandle(i) {
    switch (i) {
      case 0:
        {
          customDialogBox(
            title: "Log out",
            content: const Column(
              children: [Text("Are you sure you want to log out?")],
            ),
            isOkBtn: true,
            okBtnName: "Yes",
            onOkTap: () async {
              await ac.signOut(userData.value?.uid);
            },
            onCancelTap: () {
              Get.back();
            },
          );
        }
      case 1:
        {}
      default:
    }
  }
}
