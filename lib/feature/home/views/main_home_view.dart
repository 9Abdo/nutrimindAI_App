import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/feature/chat/views/chat_bot_view.dart';
import 'package:nutrimind/feature/history/views/history_page_view.dart';
import 'package:nutrimind/feature/home/cubit/home_cubit.dart';
import 'package:nutrimind/feature/home/views/home_page_views.dart';
import 'package:nutrimind/feature/profile/views/profile_page_view.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key});

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && mounted) {
        context.read<HomeCubit>().loadMeals(user.uid);
        context.read<HomeCubit>().loadTarget(user.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePageViews(),
      const ChatBotView(),
      const HistoryPageView(),
      const ProfilePageView(),
    ];

    return Scaffold(
      body: pages[_currentIndex],

      bottomNavigationBar: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColor.bottomnav,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: SafeArea(
            child: GNav(
              key: ValueKey(context.locale.languageCode),
              rippleColor: Colors.grey.shade300,
              hoverColor: Colors.grey.shade100,
              gap: 8,
              activeColor: AppColor.whitColor,
              iconSize: 24.sp,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
              duration: const Duration(milliseconds: 200),
              tabBackgroundColor: AppColor.primaryColor,
              color: AppColor.greyColor,
              selectedIndex: _currentIndex,

              tabs: [
                GButton(icon: LineIcons.home, text: 'nav.home'.tr()),
                GButton(icon: LineIcons.robot, text: 'nav.chat'.tr()),
                GButton(icon: LineIcons.history, text: 'nav.history'.tr()),
                GButton(icon: LineIcons.user, text: 'nav.profile'.tr()),
              ],

              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
