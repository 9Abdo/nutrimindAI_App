import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:nutrimind/core/constant/app_style.dart';

class NutritionProgress extends StatelessWidget {
  const NutritionProgress({
    super.key,
    required this.title,
    required this.value,
    required this.goal,
    required this.color,
  });

  final String title;
  final int value;
  final int goal;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final int current = value > goal ? goal : value;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: AppStyle.font15w600),
              const Spacer(),
              Text(
                "$value ${"home.g".tr()} / $goal ${"home.g".tr()}",
                style: AppStyle.grey13,
              ),
            ],
          ),

          SizedBox(height: 6.h),

          SizedBox(
            width: double.infinity,
            child: LinearProgressBar(
              maxSteps: goal,
              currentStep: current,
              progressType: ProgressType.linear,
              minHeight: 8.h,
              progressColor: color,
              backgroundColor: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ],
      ),
    );
  }
}
