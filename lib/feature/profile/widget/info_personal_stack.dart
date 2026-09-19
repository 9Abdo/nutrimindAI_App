import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/feature/services/firestor_services.dart';
import 'package:nutrimind/feature/services/supbase_services.dart';

class InfoPersonalStack extends StatefulWidget {
  const InfoPersonalStack({
    super.key,
    required this.email,
    required this.fullname,
    this.profileImageUrl,
  });
  final String email;
  final String fullname;
  final String? profileImageUrl;

  @override
  State<InfoPersonalStack> createState() => _InfoPersonalStackState();
}

class _InfoPersonalStackState extends State<InfoPersonalStack> {
  File? profileImage;

  final ImagePicker picker = ImagePicker();
  final SupabaseStorageService supabaseStorageService =
      SupabaseStorageService();

  final FirestoreServices firestoreServices = FirestoreServices();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);

    if (image == null) return;

    setState(() {
      profileImage = File(image.path);
    });
    await uploadProfileImage(profileImage!);
  }

  Future<void> uploadProfileImage(File image) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return;

      final String imageUrl = await supabaseStorageService.uploadProfileImage(
        image: image,
        uid: user.uid,
      );

      await firestoreServices.updateProfileImage(
        uid: user.uid,
        imageUrl: imageUrl,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to upload profile image")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColor.primaryDark
            : AppColor.primaryLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 55.r,
                backgroundImage: profileImage != null
                    ? FileImage(profileImage!)
                    : widget.profileImageUrl != null &&
                          widget.profileImageUrl!.isNotEmpty
                    ? NetworkImage(widget.profileImageUrl!)
                    : const AssetImage("assets/images/avater.png"),
              ),

              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.camera_alt_outlined, size: 24.sp),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (bottomSheetContext) {
                            return SizedBox(
                              height: 120.h,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.photo_library,
                                      color: AppColor.primaryColor,
                                    ),
                                    title: Text("chat.gallery".tr()),
                                    onTap: () async {
                                      Navigator.pop(bottomSheetContext);

                                      await pickImage(ImageSource.gallery);
                                    },
                                  ),

                                  ListTile(
                                    leading: Icon(
                                      Icons.camera_alt,
                                      color: AppColor.primaryColor,
                                    ),
                                    title: Text("chat.camera".tr()),
                                    onTap: () async {
                                      Navigator.pop(bottomSheetContext);

                                      await pickImage(ImageSource.camera);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          Text(
            widget.fullname,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
          ),

          SizedBox(height: 5.h),

          Text(
            widget.email,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
          ),
        ],
      ),
    );
  }
}
