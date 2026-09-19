import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrimind/core/constant/app_color.dart';

class AppStyle {
  static TextStyle appBarStyle = GoogleFonts.cairo(
    color: AppColor.primaryColor,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle green16w500 = GoogleFonts.cairo(
    color: AppColor.primaryColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle black24bold = GoogleFonts.cairo(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle black17w600 = GoogleFonts.cairo(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle black16 = GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle white16 = GoogleFonts.cairo(
    color: AppColor.whitColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle grey16 = GoogleFonts.cairo(
    color: AppColor.greyColor,
    fontSize: 15.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle buttonStyle = GoogleFonts.cairo(
    color: AppColor.whitColor,
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle showSnackBar = GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle titleApp = GoogleFonts.cairo(
    fontSize: 25.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font24w700 = GoogleFonts.cairo(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle font18bold = GoogleFonts.cairo(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font15bold = GoogleFonts.cairo(
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle font15w600 = GoogleFonts.cairo(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle grey11 = GoogleFonts.cairo(
    fontSize: 11.sp,
    color: AppColor.greyColor,
  );
   static TextStyle grey13 = GoogleFonts.cairo(
    fontSize: 13.sp,
    color: AppColor.greyColor,
  );
  static TextStyle font16w500 = GoogleFonts.cairo(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
}
