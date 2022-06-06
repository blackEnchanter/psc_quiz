import 'dart:math';
import 'dart:async';

import 'result_screen.dart';
import 'package:flutter/material.dart';
import 'package:psc_quiz/src/models/question.dart';
import 'package:psc_quiz/src/constant/constant.dart';
import 'package:psc_quiz/src/constant/sized_box.dart';
import 'package:psc_quiz/src/widget/app_background_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    Key? key,
    required this.totalTime,
    required this.questions,
  }) : super(key: key);

  final int totalTime;
  final List<Question> questions;

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  late int _currentTime;
  late Timer _timer;
  int _currentIndex = 0;
  String _selectedAnswer = '';
  int _score = 0;
  List<Question> _shuffeledQuestions = [];

  @override
  void initState() {
    super.initState();
    _currentTime = widget.totalTime;

    _shuffeledQuestions = _shuffle(widget.questions) as List<Question>;

    _shuffeledQuestions = _shuffeledQuestions.map((e) {
      return e.copyWith(
        answers: _shuffle(e.answers) as List<String>,
      );
    }).toList();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime -= 1;
      });

      if (_currentTime == 0) {
        _timer.cancel();
        pushResultScreen(context);
      }
    });
  }

  List _shuffle(List items) {
    var random = Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _shuffeledQuestions[_currentIndex];
    return Scaffold(
      body: AppBackgroundWidget(
        child: Padding(
          padding: AppEdge.edgeInsetsA16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizedBox.sizedBoxH50,
              // Progress section
              QuizProgressWidget(currentTime: _currentTime, widget: widget),
              AppSizedBox.sizedBoxH40,

              Text('question'.tr,
                  style: AppFontFamily.rubik.copyWith(
                    fontSize: AppFontSize.f20,
                  )),
              AppSizedBox.sizedBoxH10,

              Text(currentQuestion.question,
                  style:
                      AppFontFamily.rubik.copyWith(fontSize: AppFontSize.f24)),
              SizedBox(
                height: AppSize.screenHeight * 0.23,
              ),
              Expanded(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final answer = currentQuestion.answers[index];
                    return AnswerTile(
                      isSelected: answer == _selectedAnswer,
                      answer: answer,
                      correctAnswer: currentQuestion.correctAnswer,
                      onTap: () {
                        setState(() {
                          _selectedAnswer = answer;
                        });

                        if (answer == currentQuestion.correctAnswer) {
                          _score++;
                        }

                        Future.delayed(const Duration(milliseconds: 200), () {
                          if (_currentIndex == _shuffeledQuestions.length - 1) {
                            pushResultScreen(context);
                            return;
                          }
                          setState(() {
                            _currentIndex++;
                            _selectedAnswer = '';
                          });
                        });
                      },
                    );
                  },
                  itemCount: currentQuestion.answers.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pushResultScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          questions: _shuffeledQuestions,
          totalTime: widget.totalTime,
          score: _score,
        ),
      ),
    );
  }
}

class QuizProgressWidget extends StatelessWidget {
  const QuizProgressWidget({
    Key? key,
    required int currentTime,
    required this.widget,
  })  : _currentTime = currentTime,
        super(key: key);

  final int _currentTime;
  final QuizScreen widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.h40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.r10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            LinearProgressIndicator(
              value: _currentTime / widget.totalTime,
              color: AppColor.progressGreen,
            ),
            Center(
              child: Text(
                _currentTime.toString(),
                style: AppFontFamily.rubik.copyWith(
                    fontWeight: FontWeight.bold, fontSize: AppFontSize.f20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnswerTile extends StatelessWidget {
  const AnswerTile({
    Key? key,
    required this.isSelected,
    required this.answer,
    required this.correctAnswer,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final String answer;
  final String correctAnswer;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppEdge.edgeInsetsB5,
      decoration: BoxDecoration(
          color: cardColor,
          border: Border.all(color: AppColor.white),
          borderRadius: BorderRadius.circular(AppRadius.r08)),
      child: ListTile(
        onTap: () => onTap(),
        title: Text(
          answer,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: isSelected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  Color get cardColor {
    if (!isSelected) return Colors.transparent;

    if (answer == correctAnswer) {
      return Colors.white;
    }

    return Colors.redAccent;
  }
}
