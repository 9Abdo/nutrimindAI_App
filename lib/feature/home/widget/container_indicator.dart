import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/feature/home/widget/nutrition_progress.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ContainerIndicator extends StatelessWidget {
  const ContainerIndicator({
    super.key,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.meals,
    required this.targetCalories,
    required this.targetProtein,
    required this.targetCarbs,
    required this.targetFat,
  });

  final int calories;
  final int protein;
  final int carbs;
  final int fat;
  final int meals;
  final int targetCalories;
  final int targetProtein;
  final int targetCarbs;
  final int targetFat;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color:
            Theme.of(context).cardTheme.color ??
            Theme.of(context).colorScheme.surface,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "home.daily_calories".tr(),
              style: AppStyle.black17w600,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularPercentIndicator(
                  radius: 55.r,
                  lineWidth: 8,
                  percent: (calories / targetCalories).clamp(0.0, 1.0),
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$calories",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("/$targetCalories ${"home.kcal".tr()}"),
                    ],
                  ),
                  progressColor: AppColor.greenColor,
                  backgroundColor: Colors.grey.shade300,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NutritionProgress(
                          title: "home.protein".tr(),
                          value: protein,
                          goal: targetProtein,
                          color: AppColor.greenColor,
                        ),

                        NutritionProgress(
                          title: "home.carbs".tr(),
                          value: carbs,
                          goal: targetCarbs,
                          color: AppColor.blueColor,
                        ),

                        NutritionProgress(
                          title: "home.fat".tr(),
                          value: fat,
                          goal: targetFat,
                          color: AppColor.accentColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
