import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/src/modules/base/controllers/base_controller.dart';
import 'package:minesweeper_game/src/utils/sound_palette.dart';
import 'package:minesweeper_game/src/utils/widgets/custom_dialog_box.dart';

class GameBoardController extends GetxController {
  late final bmc = Get.find<BaseController>();
  @override
  void onClose() {
    bombTimer.value?.cancel();
    super.onClose();
  }

  final gridSize = 10.obs;
  final totalBombs = 15.obs;
  final bombGrid = <List<bool>>[].obs;
  final pieceGrid = <List<bool>>[].obs;
  final explodedGrid = <List<bool>>[].obs;
  final discoveredBombGrid = <List<bool>>[].obs;
  final discoveredBombs = 0.obs;
  final remainingBombs = 0.obs;
  final bombTimer = Rxn<Timer>();
  final showBombTime = 10.obs;

  initializeGame() {
    bombGrid.value = List.generate(
        gridSize.value, (_) => List.generate(gridSize.value, (_) => false));
    pieceGrid.value = List.generate(
        gridSize.value, (_) => List.generate(gridSize.value, (_) => false));
    explodedGrid.value = List.generate(
        gridSize.value, (_) => List.generate(gridSize.value, (_) => false));
    discoveredBombGrid.value = List.generate(
        gridSize.value, (_) => List.generate(gridSize.value, (_) => false));
    final random = Random();
    int bombsPlaced = 0;
    while (bombsPlaced < totalBombs.value) {
      int row = random.nextInt(gridSize.value);
      int col = random.nextInt(gridSize.value);
      if (!bombGrid[row][col]) {
        bombGrid[row][col] = true;
        bombGrid.refresh();
        bombsPlaced++;
      }
    }
  }

  startBombTimer() {
    bombTimer.value = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (showBombTime.value == 0) {
          explodeRandomBomb();
          bombTimer.value?.cancel();
          if (remainingBombs.value != 0) {
            showBombTime.value = 10;
            startBombTimer();
          }
        } else {
          showBombTime.value--;
        }
      },
    );
  }

  explodeRandomBomb() async {
    final bombLocations = <List<int>>[];
    for (int row = 0; row < gridSize.value; row++) {
      for (int col = 0; col < gridSize.value; col++) {
        if (bombGrid[row][col] && !explodedGrid[row][col] && !discoveredBombGrid[row][col]) {
          bombLocations.add([row, col]);
        }
      }
    }

    if (bombLocations.isNotEmpty) {
      Random random = Random();
      List<int> location = bombLocations[random.nextInt(bombLocations.length)];
      explodedGrid[location[0]][location[1]] = true;
      explodedGrid.refresh();
      remainingBombs.value--;
      await bmc.sc.playSoundEffects(AppSounds.bombExplosion);
      if (remainingBombs.value == 0) {
        checkGameOver();
      }
    }
  }

  handleDrop(int row, int col) async {
    if (bombGrid[row][col] && !explodedGrid[row][col] && !discoveredBombGrid[row][col]) {
      discoveredBombGrid[row][col] = true;
      discoveredBombGrid.refresh();
      discoveredBombs.value++;
      remainingBombs.value--;
    }
    pieceGrid[row][col] = true;

    if (remainingBombs.value == 0) {
      checkGameOver();
    }
    if (bombGrid[row][col]) {
      await bmc.sc.playSoundEffects(AppSounds.bombExplosion);
    } else {
      await bmc.sc.playSoundEffects(AppSounds.bombFound);
    }
  }

  checkGameOver() async {
    bombTimer.value?.cancel();
    if (discoveredBombs == totalBombs) {
      // Player wins
      await bmc.sc.playSoundEffects(AppSounds.gameWin);
      customDialogBox(
        title: "You Won!",
        content: Column(
          children: [
            Text('A bomb exploded! Game over!'),
            Text('Congratulations! You found all the bombs!'),
          ],
        ),
        isOkBtn: true,
        okBtnName: "New Game",
        onOkTap: () {
          Get.back();
          restartGame();
        },
        onCancelTap: () {
          Get.back();
          Get.back();
        },
      );
    } else {
      // Game over
      await bmc.sc.playSoundEffects(AppSounds.gameLost);
      customDialogBox(
        title: "Game Over",
        content: Column(
          children: [
            Text('A bomb exploded! Game over!'),
            Text('You discovered $discoveredBombs bombs!'),
          ],
        ),
        isOkBtn: true,
        okBtnName: "Restart",
        onOkTap: () {
          Get.back();
          restartGame();
        },
        onCancelTap: () {
          Get.back();
          Get.back();
        },
      );
    }
  }

  restartGame() {
    showBombTime.value = 10;
    discoveredBombs.value = 0;
    remainingBombs.value = totalBombs.value;
    initializeGame();
    startBombTimer();
  }
}
