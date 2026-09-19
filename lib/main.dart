import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/const_api.dart';
import 'package:nutrimind/core/route/app_route.dart';
import 'package:nutrimind/core/theme/app_theme.dart';
import 'package:nutrimind/core/theme/theme_cubit.dart';
import 'package:nutrimind/feature/chat/cubit/chat_bot_cubit.dart';
import 'package:nutrimind/feature/home/cubit/home_cubit.dart';
import 'package:nutrimind/feature/services/chat_bot_services.dart';
import 'package:nutrimind/feature/user/cubit/user_cubit.dart';
import 'package:nutrimind/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await EasyLocalization.ensureInitialized();
  await Supabase.initialize(
    url: ConstApi.urlsupbase,
    publishableKey: ConstApi.publishKey,
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/language',
      fallbackLocale: const Locale('ar'),
      startLocale: Locale("ar"),
      useOnlyLangCode: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<UserCubit>(create: (_) => UserCubit()),

        BlocProvider<HomeCubit>(create: (_) => HomeCubit()),

        BlocProvider<ChatBotCubit>(
          create: (context) => ChatBotCubit(
            ChatBotServices(dio: Dio()),
            context.read<HomeCubit>(),
          ),
        ),
      ],

      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),

            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,

              // Localization
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,

              // Theme
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state.themeMode,

              routerConfig: goRouter,
            ),
          );
        },
      ),
    );
  }
}
