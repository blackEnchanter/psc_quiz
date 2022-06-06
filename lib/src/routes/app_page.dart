import 'package:get/get.dart';
import 'package:psc_quiz/src/screen/home_screen.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
    ),
  ];
}
