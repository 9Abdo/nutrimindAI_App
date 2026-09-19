import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/core/route/const_route.dart';
import 'package:nutrimind/feature/home/cubit/home_cubit.dart';
import 'package:nutrimind/feature/home/cubit/home_state.dart';

import 'package:nutrimind/core/widgets/card_meal.dart';

class HistoryPageView extends StatefulWidget {
  const HistoryPageView({super.key});

  @override
  State<HistoryPageView> createState() => _HistoryPageViewState();
}

class _HistoryPageViewState extends State<HistoryPageView> {
  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>().loadMeals(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("history.title".tr(), style: AppStyle.appBarStyle),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
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
                    Icon(Icons.history, size: 80.sp, color: AppColor.greyColor),
                    SizedBox(height: 15.h),
                    Text(
                      "history.no_history_title".tr(),
                      style: AppStyle.black17w600,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "history.no_history_desc".tr(),
                      textAlign: TextAlign.center,
                      style: AppStyle.grey16,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(12.sp),
              itemCount: state.history.length,
              itemBuilder: (context, index) {
                final meal = state.history[index];

                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () {
                      context.pushNamed(RoutName.mealDatailName, extra: meal);
                    },

                    child: CardMeal(homeModel: meal),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
