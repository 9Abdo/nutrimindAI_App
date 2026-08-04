import 'package:flutter/material.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.obscureText = false,
    this.icon,
    this.validator,
    this.controller,
    this.prefixicon,
  });
  final String hint;
  final bool obscureText;
  final IconButton? icon;
  final Widget? prefixicon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      cursorColor: AppColor.primaryColor,
      style: AppStyle.green16w500,
      decoration: InputDecoration(
        suffixIcon: icon,
        prefixIcon: prefixicon,
        fillColor: Colors.white,
        filled: true,

        suffixIconColor: Colors.grey,

        hint: Text(hint, style: AppStyle.grey16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColor.greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColor.greyColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
