import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/core/helper/dateintil.dart';
import 'package:nutrimind/feature/details_meal/widget/info_card.dart';
import 'package:nutrimind/feature/details_meal/widget/nutrition_row.dart';
import 'package:nutrimind/feature/model/home_model.dart';

class MealDetailsView extends StatelessWidget {
  const MealDetailsView({super.key, required this.meal});

  final HomeModel meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meal Details")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: meal.image != null
                  ? Image.file(
                      meal.image!,
                      width: double.infinity,
                      height: 220.h,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 220.h,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.fastfood,
                        size: 90.sp,
                        color: Colors.grey,
                      ),
                    ),
            ),

            SizedBox(height: 20.h),

            Text(meal.foodName, style: AppStyle.black24bold),

            SizedBox(height: 5.h),

            Text(formatAnalysisDate(meal.date), style: AppStyle.grey16),

            SizedBox(height: 20.h),

            Card(
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InfoCard(
                      title: "Calories",
                      value: "${meal.calories}",
                      unit: "Kcal",
                    ),
                    InfoCard(
                      title: "Health",
                      value: "${meal.healthScore}",
                      unit: "/10",
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),

            Text("Nutrition", style: AppStyle.black17w600),

            SizedBox(height: 10.h),

            NutritionRow("Protein", "${meal.protein} g"),
            NutritionRow("Carbs", "${meal.carbs} g"),
            NutritionRow("Fat", "${meal.fat} g"),

            SizedBox(height: 25.h),

            Text("Recommendation", style: AppStyle.black17w600),

            SizedBox(height: 10.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withOpacity(.08),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Text(meal.recommendation, style: AppStyle.black16),
            ),
          ],
        ),
      ),
    );
  }
}


