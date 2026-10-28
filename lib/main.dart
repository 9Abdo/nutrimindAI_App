import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/constant/const_api.dart';
import 'core/route/app_route.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'feature/chat/data/datasource/remote_chat_data_source.dart';
import 'feature/chat/data/repo/chat_repo_implemention.dart';
import 'feature/chat/domain/usecase/send_text_use_case.dart';
import 'feature/chat/domain/usecase/sent_image_usecase.dart';
import 'feature/chat/presentation/cubit/chat_bot_cubit.dart';
import 'feature/home/cubit/home_cubit.dart';

import 'feature/user/cubit/user_cubit.dart';
import 'firebase_options.dart';
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
            context.read<HomeCubit>(),
            sendTextUseCase: SendTextUseCase(
              chatMessageRepoAbstract: ChatRepoImplemention(
                chatDataSourceAbstract: RemoteChatDataSource(dio: Dio()),
              ),
            ),
            sentImageUsecase: SentImageUsecase(
              chatMessageRepoAbstract: ChatRepoImplemention(
                chatDataSourceAbstract: RemoteChatDataSource(dio: Dio()),
              ),
            ),
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
