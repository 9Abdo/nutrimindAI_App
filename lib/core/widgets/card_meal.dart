import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind/core/constant/app_color.dart';

import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/core/helper/dateintil.dart';
import 'package:nutrimind/core/route/const_route.dart';
import 'package:nutrimind/core/widgets/image_widget.dart';
import 'package:nutrimind/feature/home/cubit/home_cubit.dart';
import 'package:nutrimind/feature/model/home_model.dart';

class CardMeal extends StatelessWidget {
  const CardMeal({super.key, required this.homeModel});

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: InkWell(
          onTap: () {
            context.pushNamed(RoutName.mealDatailName, extra: homeModel);
          },
          child: Row(
            children: [
              Imagewidget(width: 60.w, height: 60.h, image: homeModel.image!),

              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      homeModel.foodName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.black17w600,
                    ),

                    Text(
                      '${homeModel.calories} ${"home.kcal".tr()}',
                      style: AppStyle.green16w500,
                    ),

                    Text(
                      DateFormatHelper.formatAnalysisDate(
                        homeModel.date,
                        locale: context.locale.languageCode,
                      ),
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

                    title: "home.delete_meal".tr(),

                    desc: "home.delete_meal_confirm".tr(),

                    btnCancelText: "home.cancel".tr(),
                    btnCancelColor: AppColor.greyColor,
                    btnCancelOnPress: () {},

                    btnOkText: "home.delete".tr(),
                    btnOkColor:AppColor.redColor,

                    btnOkOnPress: () async {
                      await context.read<HomeCubit>().deleteMeal(
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        mealId: homeModel.id!,
                      );

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "home.meal_deleted_successfully".tr(),
                            ),
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
