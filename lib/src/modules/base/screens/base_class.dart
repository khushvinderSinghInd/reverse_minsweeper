import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/src/modules/base/controllers/base_controller.dart';
import 'package:minesweeper_game/src/modules/base/widgets/base_nav_bar.dart';
import 'package:minesweeper_game/src/modules/base/widgets/base_page_view.dart';

class BaseClass extends StatelessWidget {
  const BaseClass({super.key});

  @override
  Widget build(BuildContext context) {
    final bmc = Get.put(BaseController());
    return Scaffold(
      
      body: BasePageViewComp(bmc: bmc),
      bottomNavigationBar: BaseNavBar(bmc: bmc),
    );
  }
}
