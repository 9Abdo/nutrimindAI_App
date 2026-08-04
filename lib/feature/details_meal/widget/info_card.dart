import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_color.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    required this.title,
    required this.value,
    required this.unit,
  });

  final String title;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
        ),
        Text(unit),
      ],
    );
  }
}