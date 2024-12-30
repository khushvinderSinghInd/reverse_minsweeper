import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minesweeper_game/src/extensions/space_ext.dart';
import 'package:minesweeper_game/src/modules/base/controllers/base_controller.dart';
import 'package:minesweeper_game/src/utils/icon_palette.dart';

class UserDetailsComp extends StatelessWidget {
  final BaseController bmc;
  const UserDetailsComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context)
            .bottomNavigationBarTheme
            .backgroundColor!
            .withOpacity(0.2),
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.all(10.r),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundImage: bmc.sc.userData.value!.userImage.isNotEmpty
                ? NetworkImage("${bmc.sc.userData.value?.userImage}")
                : const AssetImage(AppIcons.guestIcon),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          15.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${bmc.sc.userData.value?.userName}",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
              Text(
                "${bmc.sc.userData.value?.userEmail}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
