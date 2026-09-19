import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_style.dart';

void showSankBar(
  BuildContext context, {
  required String text,
  required Color color,
}) {
  AnimatedSnackBar(
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    duration: Duration(milliseconds: 2000),
    builder: (context) {
      return Container(
        width: double.infinity,
        height: 70.h,
        padding: const EdgeInsets.all(8),

        color: color,
        child: Center(child: Text(text, style: AppStyle.showSnackBar)),
      );
    },
  ).show(context);
}
