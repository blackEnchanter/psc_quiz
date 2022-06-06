import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:psc_quiz/src/env/language.dart';
import 'package:psc_quiz/src/routes/routes.dart';
import 'package:psc_quiz/src/constant/string.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: AppString.appName,
            translations: Language(),
            locale: const Locale('en', 'US'),
            navigatorKey: navKey,
            getPages: AppPages.routes,
            navigatorObservers: <NavigatorObserver>[GetObserver()],
            defaultTransition: Transition.downToUp,
            initialRoute: Routes.home,
            debugShowCheckedModeBanner: false,
            enableLog: true,
          );
        });
  }
}
