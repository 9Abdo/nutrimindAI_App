import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/core/helper/dateintil.dart';
import 'package:nutrimind/core/route/const_route.dart';
import 'package:nutrimind/feature/home/cubit/home_cubit.dart';
import 'package:nutrimind/feature/model/home_model.dart';

class CardMeal extends StatelessWidget {
  const CardMeal({super.key, required this.homeModel});

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            context.pushNamed(RoutName.mealDatailName, extra: homeModel);
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: homeModel.image != null
                    ? Image.file(
                        homeModel.image!,
                        width: 60.w,
                        height: 60.h,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 60.w,
                        height: 60.h,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.fastfood),
                      ),
              ),

              SizedBox(width: 10.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      homeModel.foodName.length > 14
                          ? "${homeModel.foodName.substring(0, 14)}..."
                          : homeModel.foodName,
                      style: AppStyle.black17w600,
                    ),

                    Text(
                      "${homeModel.calories} Kcal",
                      style: AppStyle.green16w500,
                    ),

                    Text(
                      formatAnalysisDate(homeModel.date),
                      style: AppStyle.grey16,
                    ),
                  ],
                ),
              ),

              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.scale,
                    title: "Delete Meal",
                    desc: "Are you sure you want to delete this meal?",

                    btnCancelText: "Cancel",
                    btnCancelColor: Colors.grey,
                    btnCancelOnPress: () {},

                    btnOkText: "Delete",
                    btnOkColor: Colors.red,
                    btnOkOnPress: () async {
                      await context.read<HomeCubit>().deleteMeal(
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        mealId: homeModel.id!,
                      );

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Meal deleted successfully"),
                          ),
                        );
                      }
                    },
                  ).show();
                },
              ),

              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
