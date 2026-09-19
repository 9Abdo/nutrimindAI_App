import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nutrimind/core/constant/app_color.dart';

import 'package:nutrimind/core/helper/showsnackbar.dart';
import 'package:nutrimind/core/widgets/custom_button.dart';
import 'package:nutrimind/core/widgets/custom_text_field.dart';
import 'package:nutrimind/feature/home/cubit/home_cubit.dart';
import 'package:nutrimind/feature/model/change_target.dart';

void showDialgoProfile(
  BuildContext context, {
  required TextEditingController caloriesController,
  required TextEditingController proteinController,
  required TextEditingController carbsController,
  required TextEditingController fatController,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      bool isLoading = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 24.h,
              ),
              title: Text("profile.setting_daily".tr()),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(dialogContext).size.height * 0.65,
                ),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("details.calories".tr()),
                      SizedBox(height: 8.h),

                      CustomTextField(
                        hint: "details.calories".tr(),
                        controller: caloriesController,
                      ),

                      SizedBox(height: 8.h),

                      Text("details.protein".tr()),
                      SizedBox(height: 8.h),

                      CustomTextField(
                        hint: "details.protein".tr(),
                        controller: proteinController,
                      ),

                      SizedBox(height: 8.h),

                      Text("details.carbs".tr()),
                      SizedBox(height: 8.h),

                      CustomTextField(
                        hint: "details.carbs".tr(),
                        controller: carbsController,
                      ),

                      SizedBox(height: 8.h),

                      Text("details.fat".tr()),
                      SizedBox(height: 8.h),

                      CustomTextField(
                        hint: "details.fat".tr(),
                        controller: fatController,
                      ),

                      SizedBox(height: 15.h),

                      Custombutton(
                        buttonName: "profile.save".tr(),
                        onPressed: isLoading
                            ? () {}
                            : () async {
                                final calories = int.tryParse(
                                  caloriesController.text.trim(),
                                );

                                final protein = int.tryParse(
                                  proteinController.text.trim(),
                                );

                                final carbs = int.tryParse(
                                  carbsController.text.trim(),
                                );

                                final fat = int.tryParse(
                                  fatController.text.trim(),
                                );

                                setState(() {
                                  isLoading = true;
                                });

                                try {
                                  await context
                                      .read<HomeCubit>()
                                      .updateDailyGoal(
                                        ChangeTarget(
                                          calories: calories ?? 2200,
                                          protein: protein ?? 95,
                                          carbs: carbs ?? 300,
                                          fat: fat ?? 70,
                                        ),
                                      );

                                  if (!dialogContext.mounted) return;

                                  Navigator.pop(dialogContext);

                                  showSankBar(
                                    context,
                                    text: "profile.update_successful".tr(),
                                    color: AppColor.greenColor,
                                  );
                                } catch (e) {
                                  if (!dialogContext.mounted) return;

                                  setState(() {
                                    isLoading = false;
                                  });

                                  showSankBar(
                                    context,
                                    text: e.toString(),
                                    color: AppColor.redColor,
                                  );
                                }
                              },
                        height: 40.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
