import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingBubble extends StatelessWidget {
  const LoadingBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8.w, top: 6.h),
          child: CircleAvatar(
            radius: 18.r,
            backgroundColor: Colors.transparent,
            backgroundImage: const AssetImage(
              "assets/images/image.png",
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 6.h),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                "assets/images/loading.json",
                width: 50.w,
                height: 50.h,
              ),
              SizedBox(width: 10.w),
              Text(
                "Analyzing your Meal...",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}