import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/src/extensions/space_ext.dart';
import 'package:minesweeper_game/src/modules/base/controllers/base_controller.dart';
import 'package:minesweeper_game/src/modules/settings/widgets/user_details_comp.dart';
import 'package:minesweeper_game/src/utils/widgets/custom_list_tile_comp.dart';
import 'package:minesweeper_game/src/utils/widgets/custom_option_list_comp.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bmc = Get.find<BaseController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium!.color,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.h),
          child: Column(
            children: [
              UserDetailsComp(bmc: bmc),
              15.height,
              Obx(
                () {
                  return CustomListTileComp(
                    title: bmc.sc.themeMode.value,
                    trailing: Switch(
                      value: bmc.sc.isDarkTheme.value,
                      onChanged: (v) {
                        bmc.sc.isDarkTheme.value = v;
                        bmc.sc.updateThemeChanges(v);
                      },
                      activeTrackColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      inactiveTrackColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      activeColor:
                          Theme.of(context).textTheme.bodyMedium!.color,
                      inactiveThumbColor:
                          Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  );
                },
              ),
              15.height,
              Obx(
                () {
                  return CustomListTileComp(
                    title: bmc.sc.soundMode.value,
                    trailing: Switch(
                      value: bmc.sc.isSoundOn.value,
                      onChanged: (v) {
                        bmc.sc.isSoundOn.value = v;
                        bmc.sc.updateSoundChanges(v);
                      },
                      activeTrackColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      inactiveTrackColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      activeColor:
                          Theme.of(context).textTheme.bodyMedium!.color,
                      inactiveThumbColor:
                          Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  );
                },
              ),
              15.height,
              CustomOptionListComp(
                listData: bmc.sc.settingOptions,
                leading: true,
              ),
              15.height,
              CustomOptionListComp(
                listData: bmc.sc.userAuthOptions,
                leading: true,
                onTap: bmc.sc.userAuthTapHandle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
