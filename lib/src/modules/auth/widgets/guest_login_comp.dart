import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:minesweeper_game/src/extensions/space_ext.dart';
import 'package:minesweeper_game/src/modules/auth/controllers/auth_controller.dart';
import 'package:minesweeper_game/src/utils/widgets/custom_textfield.dart';

class GuestLoginComp extends StatelessWidget {
  final AuthController ac;
  const GuestLoginComp({required this.ac, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Play as a guest",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium!.color,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
        10.height,
        CustomTextfieldComp(
          controller: ac.userNameController.value,
          hintText: "Enter a user name",
          labelText: "User name",
          keyboardType: TextInputType.text,
          onChanged: (v) {
            ac.showIcon.value = v.trim().isNotEmpty;
          },
          suffixIcon: Obx(() {
            return AnimatedOpacity(
              opacity: ac.showIcon.value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                offset: ac.showIcon.value ? const Offset(0, 0) : const Offset(1, 0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                  onPressed: ac.showIcon.value ? ac.guestPlay : null,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
