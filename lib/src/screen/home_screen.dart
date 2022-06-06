import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psc_quiz/src/screen/quiz_screen.dart';
import 'package:psc_quiz/src/constant/constant.dart';
import 'package:psc_quiz/src/constant/sized_box.dart';
import 'package:psc_quiz/src/providers/quiz_provider.dart';
import 'package:psc_quiz/src/widget/custom_button_widget.dart';
import 'package:psc_quiz/src/widget/app_background_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    return Scaffold(
      body: SizedBox.expand(
        child: AppBackgroundWidget(
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Image.asset(APPImage.backgroundPattern, fit: BoxFit.fitHeight),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSizedBox.sizedBoxH50,
                  // App icon component
                  Image.asset(APPImage.icon,
                      height: AppSize.h70, width: AppSize.h71),
                  Text('appName'.tr,
                      style: AppFontFamily.poppins
                          .copyWith(fontSize: AppFontSize.f35)),
                  AppSizedBox.sizedBoxH20,
                  if (provider.questions.isEmpty || provider.totalTime == 0)
                    const Center(child: CircularProgressIndicator())
                  else
                    Container(
                      margin: AppEdge.edgeInsetsH40,
                      child: CustomButtonWidget(
                          title: 'start'.tr,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => QuizScreen(
                                  totalTime: provider.totalTime,
                                  questions: provider.questions,
                                ),
                              ),
                            );
                          },
                          width: AppSize.screenWidth,
                          height: AppSize.h50,
                          textStyle: AppFontFamily.rubik.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: AppFontSize.f14)),
                    ),
                  AppSizedBox.sizedBoxH20,

                  Text('Total Questions: ${provider.questions.length}',
                      style: AppFontFamily.rubik.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: AppFontSize.f14)),
                  // SizedBox(height: 70),
                  // RankAuthButton()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
