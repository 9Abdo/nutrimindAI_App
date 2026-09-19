import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/core/constant/const_image.dart';
import 'package:nutrimind/core/helper/showsnackbar.dart';
import 'package:nutrimind/core/route/const_route.dart';
import 'package:nutrimind/core/widgets/custom_button.dart';
import 'package:nutrimind/core/widgets/custom_text_field.dart';
import 'package:nutrimind/feature/Auth/cubit/auth_cubit.dart';
import 'package:nutrimind/feature/Auth/cubit/auth_state.dart';
import 'package:nutrimind/feature/Auth/widget/row_auth.dart';

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({super.key});

  @override
  State<RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  bool obscuretext1 = true;
  bool obscuretext2 = true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController fullNamecontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final fullNameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          showSankBar(
            context,
            text: state.error.tr(),
            color: AppColor.redColor,
          );
        }

        if (state is SignUpSuccess) {
          showSankBar(
            context,
            text: "auth.account_created_successfully".tr(),
            color: AppColor.greenColor,
          );

          context.pushReplacementNamed(RoutName.emailVerification);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignUpLoading,
          child: SafeArea(
            child: Scaffold(
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Form(
                    key: formkey,
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                children: [
                                  Image.asset(
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? ConstImage.darkRegister
                                        : ConstImage.lightRegister,
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    height: 200.h,
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    "auth.create_account".tr(),
                                    style: AppStyle.font24w700,
                                  ),
                                  Text(
                                    "auth.signup_subtitle".tr(),
                                    style: AppStyle.grey16,
                                  ),
                                  SizedBox(height: 16.h),
                                  CustomTextField(
                                    hint: "auth.full_name".tr(),
                                    prefixicon: const Icon(Icons.person),
                                    controller: fullNamecontroller,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(
                                        context,
                                      ).requestFocus(fullNameFocus);
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "auth.validation.name_required"
                                            .tr();
                                      }

                                      if (value.trim().length < 3) {
                                        return "auth.validation.name_min_length"
                                            .tr();
                                      }

                                      if (RegExp(r'[0-9]').hasMatch(value)) {
                                        return "auth.validation.name_no_numbers"
                                            .tr();
                                      }

                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 8.h),
                                  CustomTextField(
                                    controller: emailcontroller,
                                    hint: "auth.email".tr(),
                                    prefixicon: const Icon(Icons.email),
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(
                                        context,
                                      ).requestFocus(emailFocus);
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "auth.validation.email_required"
                                            .tr();
                                      }

                                      final emailRegex = RegExp(
                                        r'^[\w\.-]+@[\w\.-]+\.\w+$',
                                      );

                                      if (!emailRegex.hasMatch(value.trim())) {
                                        return "auth.validation.email_invalid"
                                            .tr();
                                      }

                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 8.h),
                                  CustomTextField(
                                    hint: "auth.password".tr(),
                                    controller: passwordcontroller,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(
                                        context,
                                      ).requestFocus(passwordFocus);
                                    },
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
                                        return "auth.validation.password_required"
                                            .tr();
                                      }

                                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                        return "auth.validation.password_uppercase"
                                            .tr();
                                      }

                                      if (!RegExp(r'[a-z]').hasMatch(value)) {
                                        return "auth.validation.password_lowercase"
                                            .tr();
                                      }

                                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                                        return "auth.validation.password_number"
                                            .tr();
                                      }

                                      if (value.length < 8) {
                                        return "auth.validation.password_min_length"
                                            .tr();
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
                                  SizedBox(height: 8.h),
                                  CustomTextField(
                                    hint: "auth.confirm_password".tr(),
                                    prefixicon: const Icon(Icons.lock),
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(
                                        context,
                                      ).requestFocus(confirmPasswordFocus);
                                    },
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
                                        return "auth.validation.confirm_password_required"
                                            .tr();
                                      }

                                      if (value != passwordcontroller.text) {
                                        return "auth.validation.passwords_do_not_match"
                                            .tr();
                                      }

                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 8.h),
                                  Custombutton(
                                    buttonName: "auth.sign_up".tr(),
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        FocusScope.of(context).unfocus();
                                        context.read<AuthCubit>().signUp(
                                          email: emailcontroller.text,
                                          password: passwordcontroller.text,
                                          fullname: fullNamecontroller.text,
                                        );
                                      }
                                    },
                                    height: 40.h,
                                  ),

                                  Spacer(),
                                  RowAuth(
                                    beforetext:
                                        '${"auth.already_have_account".tr()} ',
                                    button: "auth.login".tr(),
                                    onTap: () {
                                      context.pushReplacementNamed(
                                        RoutName.logiName,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 10.h),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
