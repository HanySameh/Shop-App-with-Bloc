import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'bloc_cubit_observer.dart';
import 'firebase_options.dart';
import 'presentation/utilities/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = BlocCubitObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Platform.isAndroid
        ? ColorConstant.kWhiteColor
        : ColorConstant.kBlackColor,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: ColorConstant.kTransparentColor,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}
