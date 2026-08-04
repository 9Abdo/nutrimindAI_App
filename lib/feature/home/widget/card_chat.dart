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
      child: ListTile(
        leading: Icon(Icons.smart_toy, color: AppColor.whitColor, size: 28.sp),
        title: Text("Ask NutriMind AI", style: AppStyle.white16),
        subtitle: Text("What's in my lunch?", style: AppStyle.white16),
        trailing: GestureDetector(
          onTap: () {
            context.pushNamed(RoutName.chatBotName);
          },
          child: Container(
            width: 90.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColor.whitColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(child: Text("Start Chat", style: AppStyle.black16)),
          ),
        ),
      ),
    );
  }
}
