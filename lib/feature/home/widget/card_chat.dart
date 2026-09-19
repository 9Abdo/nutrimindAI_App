import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/core/route/const_route.dart';

class CardChat extends StatelessWidget {
  const CardChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.primaryColor,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Row(
          children: [
            Icon(Icons.smart_toy, color: AppColor.whitColor, size: 28.sp),

            SizedBox(width: 10.w),

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "home.ask_ai_title".tr(),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.white16.copyWith(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 2.h),

                  Text(
                    "home.ask_ai_subtitle".tr(),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.white16.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
            ),

            SizedBox(width: 10.w),

            GestureDetector(
              onTap: () {
                context.pushNamed(RoutName.chatBotName);
              },
              child: Container(
                width: 82.w,
                height: 44.h,
                decoration: BoxDecoration(
                  color: AppColor.whitColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    "home.start_chat".tr(),
                    textAlign: TextAlign.center,
                    style: AppStyle.black16.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.darkSurface,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
