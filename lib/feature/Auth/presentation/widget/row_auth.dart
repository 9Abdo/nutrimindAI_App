import 'package:flutter/material.dart';
import 'package:nutrimind/core/constant/app_style.dart';

class RowAuth extends StatelessWidget {
  const RowAuth({super.key, required this.beforetext, required this.button, this.onTap});
  final String beforetext;
  final String button;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(beforetext),

        GestureDetector(
          onTap:onTap ,
          child: Text(button, style: AppStyle.green16w500)),
      ],
    );
  }
}
