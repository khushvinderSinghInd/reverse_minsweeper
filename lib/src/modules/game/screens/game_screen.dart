// ignore_for_file: deprecated_member_use

import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/src/extensions/space_ext.dart';
import 'package:minesweeper_game/src/modules/base/controllers/base_controller.dart';
import 'package:minesweeper_game/src/modules/game/widgets/draggable_item_comp.dart';

import 'package:minesweeper_game/src/modules/game/widgets/score_details_comp.dart';
import 'package:minesweeper_game/src/utils/icon_palette.dart';

class GameBoardScreen extends StatelessWidget {
  final BaseController bmc;
  const GameBoardScreen({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopScope(
        onPopInvokedWithResult: (didPop, result) {
          bmc.gsc.gbc.bombTimer.value?.cancel();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Reverse Minesweeper",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: const [
              // IconButton(
              //   icon: Icon(Icons.settings),
              //   onPressed: _showBoardSizeDialog,
              // ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            child: Column(
              children: [
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ScoreDetailsComp(
                      name: "Discovered Bombs",
                      score: "${bmc.gsc.gbc.discoveredBombs.value}",
                    ),
                    5.height,
                    ScoreDetailsComp(
                      name: "Remaining Bombs",
                      score: "${bmc.gsc.gbc.remainingBombs.value}",
                    ),
                  ],
                ),
                10.height,
                Obx(() {
                  return ScoreDetailsComp(
                    name: "Next bomb triggers in",
                    score: "${bmc.gsc.gbc.showBombTime.value}",
                  );
                }),
                50.height,
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: bmc.gsc.gbc.gridSize.value,
                      crossAxisSpacing: 2.h,
                      mainAxisSpacing: 2.w,
                    ),
                    itemCount:
                        bmc.gsc.gbc.gridSize.value * bmc.gsc.gbc.gridSize.value,
                    itemBuilder: (context, index) {
                      int row = index ~/ bmc.gsc.gbc.gridSize.value;
                      int col = index % bmc.gsc.gbc.gridSize.value;
                      return DragTarget<int>(
                        builder: (context, candidateData, rejectedData) {
                          return ClayContainer(
                            curveType: CurveType.concave,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            parentColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            surfaceColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: bmc.gsc.gbc.explodedGrid[row][col]
                                ? Padding(
                                    padding: EdgeInsets.all(8.r),
                                    child: Image.asset(AppIcons.explodeIcon),
                                  )
                                : bmc.gsc.gbc.discoveredBombGrid[row][col]
                                    ? Padding(
                                        padding: EdgeInsets.all(8.r),
                                        child:
                                            Image.asset(AppIcons.safeFlagIcon),
                                      )
                                    : bmc.gsc.gbc.pieceGrid[row][col]
                                        ? Padding(
                                            padding: EdgeInsets.all(8.r),
                                            child:
                                                Image.asset(AppIcons.flagIcon),
                                          )
                                        : null,
                          );
                        },
                        onWillAccept: (data) {
                          return !bmc.gsc.gbc.pieceGrid[row][col];
                        },
                        onAccept: (data) {
                          bmc.gsc.gbc.handleDrop(row, col);
                        },
                      );
                    },
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [DraggableItemComp()],
                ),
                50.height,
              ],
            ),
          ),
        ),
      );
    });
  }
}
