import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psc_quiz/src/constant/constant.dart';
import 'package:psc_quiz/src/models/question.dart';
import 'package:psc_quiz/src/providers/quiz_provider.dart';
import 'package:psc_quiz/src/widget/app_background_widget.dart';
import 'package:psc_quiz/src/widget/custom_button_widget.dart';

import 'quiz_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    Key? key,
    required this.score,
    required this.questions,
    required this.totalTime,
  }) : super(key: key);

  final int score;
  final List<Question> questions;
  final int totalTime;

  @override
  ResultScreenState createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: AppBackgroundWidget(
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Image.asset(
                APPImage.resultBackground,
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  SizedBox(
                    height: AppSize.screenHeight * 0.2,
                  ),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Transform.scale(
                      scale: 0.8,
                      child: ClipOval(
                        child: Image.network(AppString.avatarUrl),
                      ),
                    ),
                  ),
                  Text(
                    'Result: ${widget.score} / ${widget.questions.length}',
                    style: AppFontFamily.rubik.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSize.f35,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: AppEdge.edgeInsetsH40V40,
                  child: CustomButtonWidget(
                      isPrimary: false,
                      title: 'Play Again',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(
                              totalTime: widget.totalTime,
                              questions: widget.questions,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final provider = context.read<QuizProvider>();
    provider.updateHighScore(widget.score);
  }
}
