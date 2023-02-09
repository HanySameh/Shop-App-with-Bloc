import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logics/bloc/sign_in/sign_in_bloc.dart';
import '../../business_logics/cubit/splash_cubit/splash_cubit.dart';
import '../screens/home_screen.dart';
import '../screens/sign_in_screen.dart';
import '../screens/splash_screen.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.kInitialRoute:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<SplashCubit>(
              create: (context) => SplashCubit(),
              child: const SplashScreen(),
            );
          },
        );
      case RouteNames.kSignInScreenRoute:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(),
              child: const SignInScreen(),
            );
          },
        );
      case RouteNames.kHomeScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      default:
        return null;
    }
  }
}
