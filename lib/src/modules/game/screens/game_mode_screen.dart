import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/src/modules/base/controllers/base_controller.dart';
import 'package:minesweeper_game/src/modules/game/screens/game_screen.dart';
// import 'package:minesweeper_game/src/modules/game/widgets/custom_game_btn_comp.dart';
import 'package:minesweeper_game/src/utils/widgets/custom_list_tile_comp.dart';
import 'package:minesweeper_game/src/utils/widgets/custom_play_btn.dart';

class GameModeScreen extends StatelessWidget {
  const GameModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bmc = Get.find<BaseController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Game Mode",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium!.color,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.h),
        child: Column(
          children: [
            ...List.generate(
              bmc.gsc.gameModeOptions.length,
              (i) {
                final mode = bmc.gsc.gameModeOptions[i];
                return Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: CustomListTileComp(
                    title: "${mode["title"]}",
                    trailing: CustomPlayBtn(
                      name: "PLAY",
                      onTap: () {
                        bmc.gsc.gbc.gridSize.value =
                            int.parse("${mode["size"]}");
                        bmc.gsc.gbc.totalBombs.value =
                            bmc.gsc.gbc.gridSize.value *
                                bmc.gsc.gbc.gridSize.value ~/
                                6;
                        bmc.gsc.gbc.restartGame();
                        Get.to(() => GameBoardScreen(bmc: bmc));
                      },
                    ),
                  ),
                );
              },
            ),
            // const CustomGameBtnComp(),
          ],
        ),
      ),
    );
  }
}
