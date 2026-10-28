import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_color.dart';

class ImageBeforeSend extends StatelessWidget {
  const ImageBeforeSend({super.key, required this.file, this.onPressed});
  final File file;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.file(
            file,
            height: 120.h,
            width: 120.w,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: CircleAvatar(
            radius: 14.r,
            backgroundColor: AppColor.redColor,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.close, color: AppColor.whitColor, size: 16),
              onPressed: onPressed,
            ),
          ),
        ),
      ],
    );
  }
}
