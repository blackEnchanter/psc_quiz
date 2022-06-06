import 'dart:io';

import 'src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'src/connection/connection.dart';
import 'src/providers/quiz_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:psc_quiz/src/constant/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Specifies the set of orientations the application interface can be displayed in.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Specifies the style to use for the system overlays that are visible
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColor.navigationColor,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness:
        Platform.isAndroid ? Brightness.dark : Brightness.light,
    systemNavigationBarColor: AppColor.navigationColor,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  // Application internet connectivity check.
  Connection.configureConnectivityStream();

  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: const MyApp(),
    ),
  );
}
