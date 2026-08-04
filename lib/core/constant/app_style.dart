import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_color.dart';

class AppStyle {
  static TextStyle appBarStyle = TextStyle(
    color: AppColor.primaryColor,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle green16w500 = TextStyle(
    color: AppColor.primaryColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle black24bold = TextStyle(
    color: AppColor.blackColor,
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle black16 = TextStyle(
    color: AppColor.blackColor,
    fontSize: 12.sp,
  );
  static TextStyle black17w600 = TextStyle(
    color: AppColor.blackColor,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle white16 = TextStyle(
    color: AppColor.whitColor,
    fontSize: 16.sp,
  );
  static TextStyle grey16 = TextStyle(
    color: AppColor.greyColor,
    fontSize: 16.sp,
  );
  static TextStyle buttonStyle = TextStyle(
    color: AppColor.whitColor,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );
}
