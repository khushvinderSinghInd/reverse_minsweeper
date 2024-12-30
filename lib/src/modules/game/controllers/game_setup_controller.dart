import 'package:get/get.dart';
import 'package:minesweeper_game/src/modules/game/controllers/game_board_controller.dart';

class GameSetupController extends GetxController {
  final gbc = Get.put(GameBoardController());
  final gameModeOptions = [
    {
      "title": "5x5 Board",
      "size": 5,
    },
    {
      "title": "8x8 Board",
      "size": 8,
    },
    {
      "title": "10x10 Board",
      "size": 10,
    },
  ];
}
