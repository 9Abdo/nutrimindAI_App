import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Imagewidget extends StatelessWidget {
  const Imagewidget({
    super.key,
    required this.width,
    required this.height,
    required this.image,
  });

  final double width;
  final double height;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),

      child: CachedNetworkImage(
        useOldImageOnUrlChange: false,
        width: width.w,
        height: height.h,
        imageUrl: image,

        fit: BoxFit.cover,

        placeholder: (context, url) {
          return const Center(child: CircularProgressIndicator());
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
