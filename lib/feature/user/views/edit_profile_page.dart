import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/app_color.dart';

import 'package:nutrimind/core/helper/showsnackbar.dart';
import 'package:nutrimind/core/widgets/custom_button.dart';
import 'package:nutrimind/core/widgets/custom_text_field.dart';
import 'package:nutrimind/feature/user/cubit/user_cubit.dart';
import 'package:nutrimind/feature/user/cubit/user_state.dart';
import 'package:nutrimind/feature/user/widget/loading_button.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController oldpasswordController = TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscuretext1 = true;
  bool obscuretext2 = true;
  bool isNameLoading = false;

  @override
  void initState() {
    super.initState();

    context.read<UserCubit>().getUser();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    oldpasswordController.dispose();
    newpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("profile.edit_profile".tr()),
          centerTitle: true,
        ),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserSuccess) {
              if (fullNameController.text.isEmpty) {
                fullNameController.text = state.user.fullname;
              }
            }
            if (state is UserNameChanged) {
              setState(() {
                isNameLoading = false;
              });
              showSankBar(
                context,
                text: "profile.name_updated_successfully".tr(),
                color: AppColor.greenColor,
              );

              context.read<UserCubit>().getUser();
            }

            if (state is UserPasswordChanged) {
              oldpasswordController.clear();
              newpasswordController.clear();

              showSankBar(
                context,
                text: "profile.password_changed_successfully".tr(),
                color: AppColor.greenColor,
              );
              setState(() {
                obscuretext1 = true;
                obscuretext2 = true;
                formKey = GlobalKey<FormState>();
              });
              context.read<UserCubit>().getUser();
            }

            if (state is UserFailure) {
              setState(() {
                isNameLoading = false;
              });
              showSankBar(context, text: state.error.tr(), color: Colors.red);
            }
          },

          builder: (context, state) {
            final bool isPasswordLoading = state is UserPasswordLoading;

            return Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "profile.personal_information".tr(),
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Text("auth.full_name".tr()),

                    SizedBox(height: 8.h),

                    CustomTextField(
                      hint: "auth.full_name".tr(),
                      controller: fullNameController,
                    ),

                    SizedBox(height: 16.h),
                    SizedBox(height: 8.h),
                    if (isNameLoading)
                      LoadingButton(text: "profile.save".tr(), height: 45)
                    else
                      Custombutton(
                        buttonName: "profile.save".tr(),
                        onPressed: () {
                          final fullname = fullNameController.text.trim();

                          if (fullname.isEmpty) {
                            showSankBar(
                              context,
                              text: "auth.validation.full_name_required".tr(),
                              color: AppColor.redColor,
                            );
                            return;
                          }
                          setState(() {
                            isNameLoading = true;
                          });
                          context.read<UserCubit>().updatefullname(
                            fullName: fullname,
                          );
                        },
                        height: 45.h,
                      ),

                    SizedBox(height: 25.h),

                    Text(
                      "profile.change_pass".tr(),
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Text(
                      "profile.message_change".tr(),
                      style: TextStyle(color: Colors.grey.shade600),
                    ),

                    SizedBox(height: 12.h),

                    Text(
                      "profile.current_pass".tr(),
                      style: TextStyle(fontSize: 18.sp),
                    ),

                    CustomTextField(
                      hint: "auth.password".tr(),
                      controller: oldpasswordController,
                      prefixicon: const Icon(Icons.lock),
                      obscureText: obscuretext1,
                      icon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscuretext1 = !obscuretext1;
                          });
                        },
                        icon: obscuretext1
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "auth.validation.password_required".tr();
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 12.h),

                    Text(
                      "profile.new_pass".tr(),
                      style: TextStyle(fontSize: 18.sp),
                    ),

                    SizedBox(height: 8.h),

                    CustomTextField(
                      hint: "auth.password".tr(),
                      controller: newpasswordController,
                      prefixicon: const Icon(Icons.lock),
                      obscureText: obscuretext2,
                      icon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscuretext2 = !obscuretext2;
                          });
                        },
                        icon: obscuretext2
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "auth.validation.password_required".tr();
                        }

                        if (value.length < 8) {
                          return "auth.validation.password_min_length".tr();
                        }

                        if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return "auth.validation.password_uppercase".tr();
                        }

                        if (!RegExp(r'[a-z]').hasMatch(value)) {
                          return "auth.validation.password_lowercase".tr();
                        }

                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return "auth.validation.password_number".tr();
                        }

                        if (!RegExp(
                          r'[!@#$%^&*(),.?":{}|<>_\-+=/\\[\]~`]',
                        ).hasMatch(value)) {
                          return "auth.validation.password_special_character"
                              .tr();
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 20.h),

                    if (isPasswordLoading)
                      LoadingButton(
                        text: "profile.change_pass".tr(),
                        height: 45,
                      )
                    else
                      Custombutton(
                        buttonName: "profile.change_pass".tr(),
                        onPressed: () async {
                          // Validate
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          final oldPassword = oldpasswordController.text.trim();

                          final newPassword = newpasswordController.text.trim();
                          if (oldPassword == newPassword) {
                            showSankBar(
                              context,
                              text: "profile.password_must_be_different".tr(),
                              color: AppColor.redColor,
                            );
                            return;
                          }

                          // Hide keyboard
                          FocusScope.of(context).unfocus();

                          await context.read<UserCubit>().changePassword(
                            oldPassword: oldPassword,
                            newPassword: newPassword,
                          );
                        },
                        height: 45.h,
                      ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
