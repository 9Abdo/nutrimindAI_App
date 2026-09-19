import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind/core/constant/app_color.dart';

import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/core/helper/showsnackbar.dart';
import 'package:nutrimind/core/route/const_route.dart';
import 'package:nutrimind/core/widgets/custom_button.dart';
import 'package:nutrimind/feature/Auth/cubit/auth_cubit.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool isChecking = false;
  bool isSending = false;

  Future<void> checkVerification() async {
    setState(() {
      isChecking = true;
    });

    final verified = await context.read<AuthCubit>().checkEmailVerified();

    if (!mounted) return;

    setState(() {
      isChecking = false;
    });

    if (verified) {
      showSankBar(
        context,
        text: "auth.email_verified".tr(),
        color: AppColor.greenColor,
      );

      context.pushReplacementNamed(RoutName.mainhomeName);
    } else {
      showSankBar(
        context,
        text: "auth.email_not_verified".tr(),
        color:AppColor.accentColor,
      );
    }
  }

  Future<void> resendEmail() async {
    setState(() {
      isSending = true;
    });

    try {
      await context.read<AuthCubit>().resendVerificationEmail();

      if (!mounted) return;

      showSankBar(
        context,
        text: "auth.verification_email_sent".tr(),
        color: AppColor.greenColor,
      );
    } catch (e) {
      if (!mounted) return;

      showSankBar(
        context,
        text: "auth.verification_email_failed".tr(),
        color: AppColor.greenColor,
      );
    }

    if (!mounted) return;

    setState(() {
      isSending = false;
    });
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    context.pushReplacementNamed(RoutName.logiName);
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.mark_email_unread_outlined,
                  size: 90.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),

                SizedBox(height: 25.h),

                Text(
                  "auth.verify_email_title".tr(),
                  textAlign: TextAlign.center,
                  style: AppStyle.titleApp,
                ),

                SizedBox(height: 12.h),

                Text(
                  "auth.verify_email_description".tr(
                    namedArgs: {"email": user?.email ?? ""},
                  ),
                  textAlign: TextAlign.center,
                  style: AppStyle.grey16,
                ),

                SizedBox(height: 30.h),

                Custombutton(
                  buttonName: isChecking
                      ? "auth.checking".tr()
                      : "auth.check_verification".tr(),
                  onPressed: () {
                    if (isChecking) return;
                    checkVerification();
                  },
                  height: 45.h,
                ),

                SizedBox(height: 12.h),

                TextButton(
                  onPressed: isSending ? null : resendEmail,
                  child: Text(
                    isSending
                        ? "auth.sending".tr()
                        : "auth.resend_verification".tr(),
                  ),
                ),

                SizedBox(height: 10.h),

                TextButton(onPressed: logout, child: Text("auth.logout".tr())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
