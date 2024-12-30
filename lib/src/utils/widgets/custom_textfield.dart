import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomTextfieldComp extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final void Function(String)? onChanged;
  final Color? fillColor;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final Widget? suffixIcon;

  const CustomTextfieldComp({
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.keyboardType,
    this.onChanged,
    this.fillColor,
    this.inputFormatters,
    this.focusNode,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width - 40.w,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
        focusNode: focusNode,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          hintStyle: TextStyle(
            color:
                Theme.of(context).textTheme.bodyMedium!.color?.withOpacity(0.4),
            fontSize: 13.sp,
          ),
          labelStyle:
              TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
                color: Theme.of(context).textTheme.bodyMedium!.color!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
                color: Theme.of(context).textTheme.bodyMedium!.color!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
                color: Theme.of(context).textTheme.bodyMedium!.color!),
          ),
          suffixIcon: suffixIcon,
        ),
        
      ),
    );
  }
}
