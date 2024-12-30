import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:minesweeper_game/src/modules/auth/screens/splash_screen.dart';
import 'package:minesweeper_game/src/modules/base/screens/base_class.dart';
import 'package:minesweeper_game/src/services/local_db.dart';
import 'package:minesweeper_game/src/services/shared_prefs.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final controller = Rxn<AnimationController>();
  final animation = Rxn<Animation<double>>();

  @override
  void onInit() {
    controller.value = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation.value = CurvedAnimation(
      parent: controller.value!,
      curve: Curves.easeInOut,
    );
    controller.value!.forward();
    super.onInit();
  }

  @override
  void onClose() {
    controller.value!.dispose();
    super.onClose();
  }

  final userNameController = TextEditingController().obs;
  final showIcon = false.obs;
  final firebaseAuth = FirebaseAuth.instance;
  final isGoogleLoading = false.obs;

  guestPlay() async {
    await SqlDBService.sqlDBServiceinstance.insertUser(
      uid: "guest123",
      userFullName: userNameController.value.text.trim(),
      userImage: "",
      userEmail: "Guest",
    );
    Get.offAll(() => const BaseClass());
    await SharedPrefs.setBool(key: "isLoggedIn", value: true);
    await SharedPrefs.setBool(key: "isGuestPlay", value: true);
  }

  loginWithGoogle() async {
    try {
      isGoogleLoading.value = true;
      final res = await GoogleSignIn().signIn();
      final gAuth = await res?.authentication;
      final gCred = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken,
        idToken: gAuth?.idToken,
      );

      return await firebaseAuth.signInWithCredential(gCred);
    } catch (e) {
      log("$e");
    } finally {
      isGoogleLoading.value = false;
    }
  }

  handleLoginSession(res) async {
    await SqlDBService.sqlDBServiceinstance.insertUser(
      uid: res.user.uid,
      userFullName: res.user.displayName,
      userImage: res.user.photoURL,
      userEmail: res.user.email,
    );
    Get.offAll(() => const BaseClass());
    await SharedPrefs.setBool(key: "isLoggedIn", value: true);
  }

  signOut(uid) async {
    await firebaseAuth.signOut().then(
      (value) async {
        Get.offAll(() => const SplashScreen(isLoggedIn: false));
        Get.deleteAll();
        await SqlDBService.sqlDBServiceinstance.deleteUserDetails(uid);
        await SharedPrefs.setBool(key: "isLoggedIn", value: false);
        await SharedPrefs.setBool(key: "isGuestPlay", value: false);
      },
    );
  }
}
