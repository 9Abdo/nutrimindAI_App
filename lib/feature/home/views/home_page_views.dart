import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/core/widgets/card_meal.dart';

import 'package:nutrimind/feature/home/cubit/home_cubit.dart';
import 'package:nutrimind/feature/home/cubit/home_state.dart';
import 'package:nutrimind/feature/home/widget/card_chat.dart';
import 'package:nutrimind/feature/home/widget/container_indicator.dart';

import 'package:nutrimind/feature/user/cubit/user_cubit.dart';
import 'package:nutrimind/feature/user/cubit/user_state.dart';

class HomePageViews extends StatefulWidget {
  const HomePageViews({super.key});

  @override
  State<HomePageViews> createState() => _HomePageViewsState();
}

class _HomePageViewsState extends State<HomePageViews> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    context.read<UserCubit>().getUser();

    final homeCubit = context.read<HomeCubit>();

    homeCubit.loadMeals(uid);
    homeCubit.loadTarget(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: AppColor.primaryColor, size: 30.sp),
        title: Text("app_name".tr(), style: AppStyle.appBarStyle),
        centerTitle: true,
        actions: [
          Icon(Icons.notifications, color: AppColor.primaryColor, size: 30.sp),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return CircularProgressIndicator();
                  }
                  if (state is UserSuccess) {
                    final name = state.user.fullname;
                    return Text(
                      name.isNotEmpty
                          ? "${"home.hello".tr()}, $name"
                          : "home.hello".tr(),
                      style: AppStyle.black24bold,
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              Text("home.subtitle".tr(), style: AppStyle.black16),
              SizedBox(height: 10.h),

              /// Daily Statistics
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final cubit = context.read<HomeCubit>();

                  return ContainerIndicator(
                    calories: cubit.todayCalories,
                    protein: cubit.todayProtein,
                    carbs: cubit.todayCarbs,
                    fat: cubit.todayFat,
                    meals: cubit.todayMeals,
                    targetCalories: cubit.targetCalories,
                    targetProtein: cubit.targetProtein,
                    targetCarbs: cubit.targetCarbs,
                    targetFat: cubit.targetFat,
                  );
                },
              ),

              SizedBox(height: 10.h),

              const CardChat(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "home.recent_analysis".tr(),
                    style: AppStyle.black17w600,
                  ),
                  Text("home.see_all".tr(), style: AppStyle.green16w500),
                ],
              ),

              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is HomeLoaded) {
                    if (state.history.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history,
                              size: 70.sp,
                              color: AppColor.greyColor,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "home.no_analysis_title".tr(),
                              style: AppStyle.black17w600,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "home.no_analysis_desc".tr(),
                              textAlign: TextAlign.center,
                              style: AppStyle.grey16,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.history.length,
                      itemBuilder: (context, index) {
                        return CardMeal(homeModel: state.history[index]);
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
