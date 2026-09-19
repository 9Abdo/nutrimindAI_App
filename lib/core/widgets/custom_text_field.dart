import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
  });

  final String hint;
  final bool obscureText;
  final IconButton? icon;
  final Widget? prefixicon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
      cursorColor: AppColor.primaryColor,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: AppStyle.green16w500,
      decoration: InputDecoration(
        suffixIcon: icon,
        prefixIcon: prefixicon,
        fillColor:
            Theme.of(context).cardTheme.color ??
            Theme.of(context).colorScheme.surface,
        filled: true,
        suffixIconColor: AppColor.greyColor,
        hintText: hint,
        hintStyle: AppStyle.grey16,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: AppColor.primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColor.redColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColor.redColor, width: 2),
        ),
      ),
    );
  }
}
