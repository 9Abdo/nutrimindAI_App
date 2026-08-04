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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          showSankBar(context, text: state.error, color: Colors.red);
        }

        if (state is SignUpSuccess) {
          showSankBar(
            context,
            text: "Account created successfully",
            color: Colors.green,
          );

          context.pushReplacementNamed(RoutName.mainhomeName);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignUpLoading,
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
                          Image.asset(
                            "assets/images/register.png",
                            width: MediaQuery.of(context).size.width * .9,
                            height: 200.h,
                            fit: BoxFit.fill,
                          ),
                          Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Start Your Health lifeStyle with NutriMind",
                            style: AppStyle.grey16,
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            hint: "FullName",
                            prefixicon: Icon(Icons.person),
                            controller: fullNamecontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Full Name is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8.h),
                          CustomTextField(
                            controller: emailcontroller,
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
                            hint: "PassWord",
                            controller: passwordcontroller,
                            prefixicon: Icon(Icons.lock),
                            obscureText: obscuretext1,
                            icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscuretext1 = !obscuretext1;
                                });
                              },
                              icon: obscuretext1
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
                          SizedBox(height: 8.h),
                          CustomTextField(
                            hint: "Confirm PassWord",
                            prefixicon: Icon(Icons.lock),
                            obscureText: obscuretext2,
                            icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscuretext2 = !obscuretext2;
                                });
                              },
                              icon: obscuretext2
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Confirm Password is required";
                              }
                              if (value != passwordcontroller.text) {
                                return "Password does not match";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8.h),
                          Custombutton(
                            buttonName: "Sign UP",
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                context.read<AuthCubit>().signUp(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text,
                                  fullname: fullNamecontroller.text,
                                );
                              }
                            },
                            height: 40.h,
                          ),
                          SizedBox(height: 8.h),

                          RowAuth(
                            beforetext: "Already have an account? ",
                            button: "Log in",
                            onTap: () {
                              context.pushReplacementNamed(RoutName.logiName);
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
