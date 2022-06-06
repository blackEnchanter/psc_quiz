import 'package:flutter/material.dart';
import 'package:psc_quiz/src/constant/constant.dart';

class AppBackgroundWidget extends StatelessWidget {
  const AppBackgroundWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.background1, AppColor.background2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
