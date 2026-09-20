import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';
import 'package:nutrimind/core/route/const_route.dart';
import 'package:nutrimind/core/theme/theme_cubit.dart';
import 'package:nutrimind/feature/chat/cubit/chat_bot_cubit.dart';
import 'package:nutrimind/feature/home/cubit/home_cubit.dart';
import 'package:nutrimind/feature/profile/widget/awesome_dialog.dart';
import 'package:nutrimind/feature/profile/widget/dialog_language.dart';
import 'package:nutrimind/feature/profile/widget/info_personal_stack.dart';
import 'package:nutrimind/feature/profile/widget/list_tile_profile.dart';
import 'package:nutrimind/feature/profile/widget/show_dialog_profile.dart';

import 'package:nutrimind/feature/user/cubit/user_cubit.dart';
import 'package:nutrimind/feature/user/cubit/user_state.dart';

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({super.key});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController carbsController = TextEditingController();
  final TextEditingController fatController = TextEditingController();

  @override
  void initState() {
    context.read<UserCubit>().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: Stack(
            children: [
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is UserSuccess) {
                    final name = state.user.fullname;
                    final email = state.user.email;
                    final profileImage = state.user.profileImage;
                    return InfoPersonalStack(
                      email: email,
                      fullname: name,
                      profileImageUrl: profileImage,
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              Positioned(
                top: 250,
                left: 0,
                right: 0,
                child: Material(
                  color:
                      Theme.of(context).cardTheme.color ??
                      Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20.r),
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  child: Column(
                    children: [
                      ProfileTile(
                        icon: Icons.person_outline,
                        title: "profile.personal_info".tr(),
                        onTap: () {
                          context.pushNamed(RoutName.editProfileName);
                        },
                      ),

                      Divider(height: 1.h),

                      ProfileTile(
                        icon: Icons.flag_outlined,
                        title: "profile.daily_goal".tr(),
                        onTap: () {
                          final cubit = context.read<HomeCubit>();

                          caloriesController.text = cubit.targetCalories
                              .toString();

                          proteinController.text = cubit.targetProtein
                              .toString();

                          carbsController.text = cubit.targetCarbs.toString();

                          fatController.text = cubit.targetFat.toString();

                          showDialgoProfile(
                            context,
                            caloriesController: caloriesController,
                            proteinController: proteinController,
                            carbsController: carbsController,
                            fatController: fatController,
                          );
                        },
                      ),

                      Divider(height: 1.h),

                      ProfileTile(
                        icon: Icons.history,
                        title: "profile.analysis_history".tr(),
                        onTap: () {
                          context.pushNamed(RoutName.historyName);
                        },
                      ),

                      Divider(height: 1.h),

                      ProfileTile(
                        icon: Icons.language,
                        title: "profile.language".tr(),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.locale.languageCode == "ar"
                                  ? "العربية"
                                  : "English",
                              style: AppStyle.grey13,
                            ),
                            SizedBox(width: 8.w),
                            const Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                        onTap: () async {
                          final chatBotCubit = context.read<ChatBotCubit>();

                          final selectedLanguage = await showDialog<String>(
                            context: context,
                            builder: (dialogContext) {
                              String selected = context.locale.languageCode;

                              return dialogLanguage(selected, dialogContext);
                            },
                          );

                          if (selectedLanguage == null) return;
                          if (!context.mounted) return;
                          await context.setLocale(Locale(selectedLanguage));

                          if (!mounted) return;

                          chatBotCubit.refreshWelcomeMessage();
                        },
                      ),

                      Divider(height: 1.h),

                      BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, state) {
                          final isDark = state.themeMode == ThemeMode.dark;

                          return SwitchListTile(
                            value: isDark,
                            onChanged: (value) {
                              context.read<ThemeCubit>().setThemeMode(
                                value ? ThemeMode.dark : ThemeMode.light,
                              );
                            },
                            title: Text(
                              "profile.dark_mode".tr(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            secondary: Icon(
                              Icons.dark_mode,
                              color: AppColor.primaryColor,
                            ),
                          );
                        },
                      ),

                      const Divider(height: 1),

                      ProfileTile(
                        icon: Icons.logout,
                        title: "profile.logout".tr(),
                        color: AppColor.redColor,
                        onTap: () {
                          awesomDialog(
                            context,
                            btnOkOnPress: () async {
                              await FirebaseAuth.instance.signOut();

                              if (!context.mounted) return;

                              context.goNamed(RoutName.logiName);
                            },
                          ).show();
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
