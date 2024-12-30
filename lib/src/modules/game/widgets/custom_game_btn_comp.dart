import 'package:flutter/material.dart';
import 'package:minesweeper_game/src/utils/widgets/custom_list_tile_comp.dart';

class CustomGameBtnComp extends StatelessWidget {
  const CustomGameBtnComp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomListTileComp(
      title: "Create a custom board",
      isCenter: true,
      
    );
  }
}
