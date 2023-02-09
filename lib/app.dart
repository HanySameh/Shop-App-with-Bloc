import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'business_logics/cubit/color_option_cubit/color_selector_cubit.dart';
import 'presentation/route_management/router.dart';
import 'presentation/utilities/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ColorSelectorCubit>(
              create: (context) => ColorSelectorCubit(),
            ),
          ],
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            ),
            child: child!,
          ),
        );
      },
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primaryColor: ColorConstant.kPrimaryColor,
        textTheme: GoogleFonts.audiowideTextTheme(),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
