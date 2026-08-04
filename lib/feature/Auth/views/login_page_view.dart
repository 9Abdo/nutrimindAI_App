import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nutrimind/core/constant/app_style.dart';
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
          showSankBar(context, text: state.error, color: Colors.red);
        }
        if (state is LoginSuccess) {
          showSankBar(context, text: "Login SuccessFul", color: Colors.green);
          context.pushReplacementNamed(RoutName.mainhomeName);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginLoading,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xffFAFCF4),
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Form(
                    key: formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          Text(
                            "NutriMind",
                            style: AppStyle.appBarStyle.copyWith(
                              fontSize: 48.sp,
                            ),
                          ),
                          Text("Smart Analysis , Healthier You."),
                          SizedBox(height: 16.h),
                          Image.asset(
                            "assets/images/vigatble.png",
                            width: MediaQuery.of(context).size.width * .75,
                            height: 140.h,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            "Welcome Back!",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Login to Continue your healthy journey",
                            style: AppStyle.grey16,
                          ),
                          SizedBox(height: 12.h),
                          CustomTextField(
                            controller: emailcontoller,
                            hint: "Email",
                            prefixicon: Icon(Icons.email),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is required";
                              }
                              if (!value.endsWith("@gmail.com")) {
                                return "Email must end with @gmail.com";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8.h),
                          CustomTextField(
                            controller: passwordcontoller,
                            hint: "PassWord",
                            prefixicon: Icon(Icons.lock),
                            obscureText: obscuretext,
                            icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscuretext = !obscuretext;
                                });
                              },
                              icon: obscuretext
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password is required";
                              }
                              if (value.length < 8) {
                                return "Password must be at least 8 characters";
                              }
                              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                return "Password must contain an uppercase letter";
                              }
                              if (!RegExp(r'[a-z]').hasMatch(value)) {
                                return "Password must contain a lowercase letter";
                              }
                              return null;
                            },
                          ),

                          Align(
                            alignment: AlignmentGeometry.topRight,
                            child: Text(
                              "Forget Password?",
                              style: AppStyle.green16w500,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Custombutton(
                            buttonName: "Log in",
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
                          SizedBox(height: 70.h),
                          RowAuth(
                            beforetext: "Don't have an account? ",
                            button: "Sign up",
                            onTap: () {
                              context.pushReplacementNamed(
                                RoutName.registerName,
                              );
                            },
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
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
