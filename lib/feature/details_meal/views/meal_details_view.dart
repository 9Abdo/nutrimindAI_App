import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/core/helper/dateintil.dart';
import 'package:nutrimind/core/widgets/image_widget.dart';
import 'package:nutrimind/feature/details_meal/widget/info_card.dart';
import 'package:nutrimind/feature/details_meal/widget/nutrition_row.dart';
import 'package:nutrimind/feature/model/home_model.dart';

class MealDetailsView extends StatelessWidget {
  const MealDetailsView({super.key, required this.meal});

  final HomeModel meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("details.title".tr())),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Imagewidget(
              width: double.infinity,
              height: 220.h,
              image: meal.image!,
              fit: BoxFit.fill,
            ),

            SizedBox(height: 20.h),

            Text(meal.foodName, style: AppStyle.black24bold),

            SizedBox(height: 5.h),

            Text(
              DateFormatHelper.formatAnalysisDate(
                meal.date,
                locale: context.locale.languageCode,
              ),
              style: AppStyle.grey16,
            ),

            SizedBox(height: 20.h),

            Card(
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InfoCard(
                      title: "details.calories".tr(),
                      value: "${meal.calories}",
                      unit: "home.kcal".tr(),
                    ),
                    InfoCard(
                      title: "details.health".tr(),
                      value: "${meal.healthScore}",
                      unit: "/10",
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),

            Text("details.nutrition".tr(), style: AppStyle.black17w600),

            SizedBox(height: 10.h),

            NutritionRow(
              "details.protein".tr(),
              "${meal.protein} ${"home.g".tr()}",
            ),
            NutritionRow(
              "details.carbs".tr(),
              "${meal.carbs} ${"home.g".tr()}",
            ),
            NutritionRow("details.fat".tr(), "${meal.fat} ${"home.g".tr()}"),

            SizedBox(height: 25.h),

            Text("details.recommendation".tr(), style: AppStyle.black17w600),

            SizedBox(height: 10.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Text(
                meal.recommendation,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 15.sp,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
