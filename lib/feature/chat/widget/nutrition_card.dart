import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/feature/chat/widget/nutrition_item.dart';
import 'package:nutrimind/feature/model/chat_bot_model.dart';

class NutritionCard extends StatelessWidget {
  const NutritionCard({super.key, required this.model});

  final ChatBotModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color:
            Theme.of(context).cardTheme.color ??
            Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColor.primaryColor.withValues(alpha: .25)),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.restaurant_menu, color: AppColor.primaryColor),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(model.foodName ?? "", style: AppStyle.font18bold),
              ),
            ],
          ),

          SizedBox(height: 15.h),

          NutritionItem(
            icon: Icons.local_fire_department,
            title: "chat.calories".tr(),
            value: "${model.calories} ${"home.kcal".tr()}",
          ),

          NutritionItem(
            icon: Icons.fitness_center,
            title: "chat.protein".tr(),
            value: "${model.protein} ${"home.g".tr()}",
          ),

          NutritionItem(
            icon: Icons.rice_bowl,
            title: "chat.carbs".tr(),
            value: "${model.carbs} ${"home.g".tr()}",
          ),

          NutritionItem(
            icon: Icons.opacity,
            title: "chat.fat".tr(),
            value: "${model.fat} ${"home.g".tr()}",
          ),

          SizedBox(height: 12.h),

          Text("chat.health_score".tr(), style: AppStyle.font15bold),

          SizedBox(height: 6.h),

          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: (model.healthScore ?? 0) / 10,
              minHeight: 8.h,
              color: AppColor.primaryColor,
              backgroundColor: Colors.grey.shade300,
            ),
          ),

          SizedBox(height: 6.h),

          Text(
            "${model.healthScore}/10",
            style: TextStyle(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),

          Divider(height: 25.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.tips_and_updates, color: Colors.amber, size: 22.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  model.recommendation ?? "",
                  style: TextStyle(fontSize: 14.sp, height: 1.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
