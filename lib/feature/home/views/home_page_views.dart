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

class HomePageViews extends StatefulWidget {
  const HomePageViews({super.key});

  @override
  State<HomePageViews> createState() => _HomePageViewsState();
}

class _HomePageViewsState extends State<HomePageViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: AppColor.primaryColor, size: 30.sp),
        title: Text("NutriMind", style: AppStyle.appBarStyle),
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
              Text("Hello, Abdelrhman", style: AppStyle.black24bold),
              Text(
                "Let's make healthier choices today!",
                style: AppStyle.black16,
              ),
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
                  );
                },
              ),

              SizedBox(height: 10.h),

              const CardChat(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recent Analysis", style: AppStyle.black17w600),
                  Text("See All", style: AppStyle.green16w500),
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
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "No Analysis Yet",
                              style: AppStyle.black17w600,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Analyze your first meal\nto see it here.",
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
