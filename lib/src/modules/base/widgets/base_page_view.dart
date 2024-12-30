import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/base_controller.dart';


class BasePageViewComp extends StatelessWidget {
  final BaseController bmc;
  const BasePageViewComp({required this.bmc, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: bmc.pageController.value,
        onPageChanged: bmc.onPageChanged,
        children: bmc.pages,
      );
    });
  }
}
