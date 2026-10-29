import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimind/core/route/const_route.dart';
import 'package:nutrimind/feature/Auth/presentation/cubit/auth_cubit.dart';
import 'package:nutrimind/feature/Auth/presentation/views/email_verification_page.dart';
import 'package:nutrimind/feature/Auth/presentation/views/login_page_view.dart';
import 'package:nutrimind/feature/Auth/presentation/views/register_page_view.dart';
import 'package:nutrimind/feature/chat/presentation/views/chat_bot_view.dart';
import 'package:nutrimind/feature/details_meal/views/meal_details_view.dart';
import 'package:nutrimind/feature/history/views/history_page_view.dart';
import 'package:nutrimind/feature/home/views/main_home_view.dart';
import 'package:nutrimind/feature/model/home_model.dart';
import 'package:nutrimind/feature/splash/splash_screen_view.dart';
import 'package:nutrimind/feature/user/views/edit_profile_page.dart';

import '../../feature/Auth/data/datasource/auth_data_source_abstract.dart';
import '../../feature/Auth/data/datasource/remote_auth_data_source.dart';
import '../../feature/Auth/data/repo/auth_repo_implemention.dart';
import '../../feature/Auth/domain/repo/auth_repo_abstract.dart';
import '../../feature/Auth/domain/usecase/login_use_case.dart';
import '../../feature/Auth/domain/usecase/sign_up_use_case.dart';
import '../../feature/services/firestor_services.dart';
final firebaseAuth = FirebaseAuth.instance;

final firestoreServices = FirestoreServices();

final AuthDataSourceAbstract authDataSource =
    RemoteAuthDataSource(
  firebaseAuth: firebaseAuth,
  firestoreServices: firestoreServices,
);

final AuthRepoAbstract authRepo =
    AuthRepoImplemention(
  authDataSourceAbstract: authDataSource,
);

final loginUseCase = LoginUseCase(
  authRepoAbstract: authRepo,
);

final signUpUseCase = SignUpUseCase(
  authRepoAbstract: authRepo,
);

AuthCubit createAuthCubit() {
  return AuthCubit(
    loginUseCase: loginUseCase,
    signUpUseCase: signUpUseCase,
  );
}
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
        create: (context) => createAuthCubit(),
        child: LoginPageView(),
      ),
    ),
    GoRoute(
      path: RoutePath.registerPath,
      name: RoutName.registerName,
      builder: (context, state) => BlocProvider(
        create: (context) =>createAuthCubit(),
        child: RegisterPageView(),
      ),
    ),
    GoRoute(
      path: RoutePath.emailVerification,
      name: RoutName.emailVerification,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => createAuthCubit(),
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
