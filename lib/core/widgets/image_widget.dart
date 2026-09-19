import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_color.dart';


class Imagewidget extends StatelessWidget {
  const Imagewidget({
    super.key,
    required this.width,
    required this.height,
    required this.image,
    this.radius = 8,
    this.fit = BoxFit.cover,
  });

  final double width;
  final double height;
  final String image;
  final double radius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius.r),

      child: CachedNetworkImage(
        useOldImageOnUrlChange: false,
        width: width.w,
        height: height.h,
        imageUrl: image,

        fit: fit,

        placeholder: (context, url) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.primaryColor),
          );
        },

        errorWidget: (context, url, error) {
          return Container(
            color: Colors.grey.shade300,
            child: const Icon(Icons.error),
          );
        },
      ),
    );
  }
}
