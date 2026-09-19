import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/core/constant/const_image.dart';
import 'package:nutrimind/core/route/const_route.dart';

class SplashPageView extends StatefulWidget {
  const SplashPageView({super.key});

  @override
  State<SplashPageView> createState() => _SplashPageViewState();
}

class _SplashPageViewState extends State<SplashPageView> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        context.goNamed(RoutName.logiName);
      } else {
        final doc = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

        if (!doc.exists) {
          await FirebaseAuth.instance.signOut();
          if (!mounted) return;
          context.goNamed(RoutName.logiName);
        } else {
          if (!mounted) return;
          context.goNamed(RoutName.mainhomeName);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "NutriMind AI",
              style: AppStyle.appBarStyle.copyWith(fontSize: 45.sp),
            ),

            Lottie.asset(ConstImage.splashImage),
          ],
        ),
      ),
    );
  }
}
