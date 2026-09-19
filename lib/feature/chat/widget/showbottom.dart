import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showBottomSheetimage(
  BuildContext context, {
  required VoidCallback onTapCamera,
  required VoidCallback onTapGallery,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text("chat.camera".tr()),
              onTap: onTapCamera,
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text("chat.gallery".tr()),
              onTap: onTapGallery,
            ),
          ],
        ),
      );
    },
  );
}
