import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minesweeper_game/src/utils/icon_palette.dart';

class DraggableItemComp extends StatelessWidget {
  const DraggableItemComp({super.key});

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: 1,
      feedback: SizedBox(
        width: 40.h,
        height: 40.h,
        child: Image.asset(AppIcons.flagIcon),
      ),
      childWhenDragging: SizedBox(
        width: 40.h,
        height: 40.h,
        child: Image.asset(AppIcons.flagIcon, color: Colors.grey),
      ),
      child: SizedBox(
        width: 40.h,
        height: 40.h,
        child: Image.asset(AppIcons.flagIcon),
      ),
    );
  }
}
