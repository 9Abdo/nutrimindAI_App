import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_color.dart';

class InfoPersonalStack extends StatelessWidget {
  const InfoPersonalStack({super.key, required this.email, required this.fullname});
  final String email;
  final String fullname;


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 250.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
        ),

        Column(
          children: [
            SizedBox(height: 45.h),

            Stack(
              children: [
                CircleAvatar(
                  radius: 50.r,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 60.sp,
                    color: AppColor.primaryColor,
                  ),
                ),

                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(5.sp),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.edit,
                      size: 18.sp,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 15.h),

            Text(
             fullname,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
              ),
            ),

            SizedBox(height: 5.h),

            Text(
            email,
              style: TextStyle(color: Colors.white70, fontSize: 15.sp),
            ),
          ],
        ),
      ],
    );
  }
}
