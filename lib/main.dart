import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimind/core/route/app_route.dart';
import 'package:nutrimind/feature/chat/cubit/chat_bot_cubit.dart';
import 'package:nutrimind/feature/home/cubit/home_cubit.dart';
import 'package:nutrimind/feature/profile/cubit/user_cubit.dart';
import 'package:nutrimind/feature/services/chat_bot_services.dart';
import 'package:nutrimind/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(create: (_) => HomeCubit()),

          BlocProvider<ChatBotCubit>(
            create: (context) => ChatBotCubit(
              ChatBotServices(dio: Dio()),
              context.read<HomeCubit>(),
            ),
          ),
          BlocProvider(create: (_) => ProfileCubit()..getUserData()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
        ),
      ),
    );
  }
}
