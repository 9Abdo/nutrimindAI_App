import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind/core/route/const_route.dart';
import 'package:nutrimind/feature/profile/cubit/user_cubit.dart';
import 'package:nutrimind/feature/profile/cubit/user_state.dart';
import 'package:nutrimind/feature/profile/widget/info_personal_stack.dart';
import 'package:nutrimind/feature/profile/widget/list_tile_profile.dart';

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF8F8F8),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileFailure) {
              return Center(child: Text(state.error));
            }

            if (state is ProfileSuccess) {
              final user = state.user;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    InfoPersonalStack(
                      email: user.email,
                      fullname: user.fullname,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 10),
                        ],
                      ),
                      child: Column(
                        children: [
                          ProfileTile(
                            icon: Icons.person_outline,
                            title: "Personal Information",
                            onTap: () {},
                          ),

                          const Divider(height: 1),

                          ProfileTile(
                            icon: Icons.flag_outlined,
                            title: "Daily Goal",
                            onTap: () {},
                          ),

                          const Divider(height: 1),

                          ProfileTile(
                            icon: Icons.history,
                            title: "Analysis History",
                            onTap: () {},
                          ),

                          const Divider(height: 1),

                          ProfileTile(
                            icon: Icons.settings,
                            title: "Settings",
                            onTap: () {},
                          ),

                          const Divider(height: 1),

                          ProfileTile(
                            icon: Icons.logout,
                            title: "Logout",
                            color: Colors.red,
                            onTap: () async {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.scale,
                                title: "Log out",
                                desc: "Are you sure you want to log out?",
                                btnCancelText: "Cancel",
                                btnCancelColor: Colors.grey,
                                btnCancelOnPress: () {},
                                btnOkText: "Log out",
                                btnOkColor: Colors.red,

                                btnOkOnPress: () async {
                                  await FirebaseAuth.instance.signOut();
                                  context.goNamed(RoutName.logiName);
                                },
                              ).show();
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
