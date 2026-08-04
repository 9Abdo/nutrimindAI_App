import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  });

  final int calories;
  final int protein;
  final int carbs;
  final int fat;
  final int meals;

  static const int targetCalories = 2200;
  static const int targetProtein = 95;
  static const int targetCarbs = 300;
  static const int targetFat = 70;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        boxShadow: [
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
            child: Text("Daily Calories", style: AppStyle.black17w600),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 12),
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
                      Text("/$targetCalories kcal"),
                    ],
                  ),
                  progressColor: Colors.green,
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
                          title: "Protein",
                          value: protein,
                          goal: 95,
                          color: Colors.green,
                        ),

                        NutritionProgress(
                          title: "Carbs",
                          value: carbs,
                          goal: 300,
                          color: Colors.blue,
                        ),

                        NutritionProgress(
                          title: "Fat",
                          value: fat,
                          goal: 70,
                          color: Colors.orange,
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
