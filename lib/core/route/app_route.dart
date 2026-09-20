import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind/core/route/const_route.dart';
import 'package:nutrimind/feature/Auth/cubit/auth_cubit.dart';
import 'package:nutrimind/feature/Auth/views/email_verification_page.dart';
import 'package:nutrimind/feature/Auth/views/login_page_view.dart';
import 'package:nutrimind/feature/Auth/views/register_page_view.dart';
import 'package:nutrimind/feature/chat/views/chat_bot_view.dart';
import 'package:nutrimind/feature/details_meal/views/meal_details_view.dart';
import 'package:nutrimind/feature/history/views/history_page_view.dart';
import 'package:nutrimind/feature/home/views/main_home_view.dart';
import 'package:nutrimind/feature/model/home_model.dart';
import 'package:nutrimind/feature/splash/splash_screen_view.dart';
import 'package:nutrimind/feature/user/views/edit_profile_page.dart';

GoRouter goRouter = GoRouter(
  initialLocation: RoutePath.splashPath,
  routes: [
    GoRoute(
      path: RoutePath.mainHomePath,
      name: RoutName.mainhomeName,
      builder: (context, state) => const MainHomeView(),
    ),
    GoRoute(
      path: RoutePath.loginPath,
      name: RoutName.logiName,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(),
        child: LoginPageView(),
      ),
    ),
    GoRoute(
      path: RoutePath.registerPath,
      name: RoutName.registerName,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(),
        child: RegisterPageView(),
      ),
    ),
    GoRoute(
      path: RoutePath.emailVerification,
      name: RoutName.emailVerification,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => AuthCubit(),
          child: EmailVerificationPage(),
        );
      },
    ),
    GoRoute(
      path: RoutePath.chatBotPath,
      name: RoutName.chatBotName,
      builder: (context, state) => const ChatBotView(),
    ),
    GoRoute(
      path: RoutePath.splashPath,
      name: RoutName.splashName,
      builder: (context, state) => const SplashPageView(),
    ),
    GoRoute(
      path: RoutePath.mealDatailPath,
      name: RoutName.mealDatailName,
      builder: (context, state) {
        final meal = state.extra as HomeModel;
        return MealDetailsView(meal: meal);
      },
    ),
    GoRoute(
      path: RoutePath.historyPath,
      name: RoutName.historyName,
      builder: (context, state) {
        return HistoryPageView();
      },
    ),
    GoRoute(
      path: RoutePath.editProfilePath,
      name: RoutName.editProfileName,
      builder: (context, state) {
        return EditProfilePage();
      },
    ),
  ],
);
