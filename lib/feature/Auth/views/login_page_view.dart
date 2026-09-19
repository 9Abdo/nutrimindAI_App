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

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  TextEditingController emailcontoller = TextEditingController();
  TextEditingController passwordcontoller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool obscuretext = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showSankBar(
            context,
            text: state.error.tr(),
            color: AppColor.redColor,
          );
        }
        if (state is LoginSuccess) {
          showSankBar(
            context,
            text: "auth.login_successful".tr(),
            color: AppColor.greenColor,
          );
          context.pushReplacementNamed(RoutName.mainhomeName);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoading,
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
                                  SizedBox(height: 20.h),
                                  Text(
                                    "app_name".tr(),
                                    style: AppStyle.appBarStyle.copyWith(
                                      fontSize: 48.sp,
                                    ),
                                  ),
                                  Text("app_tagline".tr()),
                                  SizedBox(height: 16.h),
                                  Image.asset(
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? ConstImage.darkLogin
                                        : ConstImage.lightLogin,
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    height: 140.h,
                                    fit: BoxFit.fill,
                                  ),
                                  Text(
                                    "auth.welcome_back".tr(),
                                    style: AppStyle.font24w700
                                  ),
                                  Text(
                                    "auth.login_subtitle".tr(),
                                    style: AppStyle.grey16,
                                  ),
                                  SizedBox(height: 12.h),
                                  CustomTextField(
                                    controller: emailcontoller,
                                    hint: "auth.email".tr(),
                                    prefixicon: const Icon(Icons.email),
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
                                    controller: passwordcontoller,
                                    hint: "auth.password".tr(),
                                    prefixicon: const Icon(Icons.lock),
                                    obscureText: obscuretext,
                                    icon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obscuretext = !obscuretext;
                                        });
                                      },
                                      icon: obscuretext
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

                                  Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: Text(
                                      "auth.forgot_password".tr(),
                                      style: AppStyle.green16w500,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Custombutton(
                                    buttonName: "auth.login".tr(),
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        context.read<AuthCubit>().login(
                                          email: emailcontoller.text,
                                          password: passwordcontoller.text,
                                        );
                                      }
                                    },
                                    height: 40.h,
                                  ),
                                  Spacer(),
                                  RowAuth(
                                    beforetext: "auth.dont_have_account".tr(),
                                    button: "auth.sign_up".tr(),
                                    onTap: () {
                                      context.pushReplacementNamed(
                                        RoutName.registerName,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 20.h),
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
