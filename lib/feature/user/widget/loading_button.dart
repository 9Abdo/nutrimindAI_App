import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key, required this.text, this.height = 60});

  final String text;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height.h,
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          disabledBackgroundColor: AppColor.primaryColor,
          disabledForegroundColor: AppColor.whitColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 22.w,
              height: 22.h,
              child: const CircularProgressIndicator(
                color: AppColor.whitColor,
                strokeWidth: 2.5,
              ),
            ),
            SizedBox(width: 10.w),
            Text(text, style: AppStyle.buttonStyle),
          ],
        ),
      ),
    );
  }
}
