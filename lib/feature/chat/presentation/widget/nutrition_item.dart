import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';

class NutritionItem extends StatelessWidget {
  const NutritionItem({
    super.key,

    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, color: AppColor.primaryColor, size: 22.sp),
          SizedBox(width: 10.w),
          Text(title, style: AppStyle.font15w600),
          const Spacer(),
          Text(value, style: AppStyle.font15bold),
        ],
      ),
    );
  }
}
