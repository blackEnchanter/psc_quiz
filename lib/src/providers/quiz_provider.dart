import 'package:flutter/material.dart';
import 'package:psc_quiz/src/models/question.dart';
import 'package:psc_quiz/src/models/quiz_user.dart';
import 'package:psc_quiz/src/services/quiz_service.dart';

class QuizProvider extends ChangeNotifier {
  int totalTime = 0;
  List<Question> questions = [];
  List<QuizUser> users = [];

  QuizProvider() {
    QuizService.getAllQuestions().then((value) {
      questions = value;
      notifyListeners();
    });

    QuizService.getTotalTime().then((value) {
      totalTime = value;
      notifyListeners();
    });
  }

  Future<void> getAllUsers() async {
    users = await QuizService.getAllUsers();
    notifyListeners();
  }

  Future<void> updateHighScore(int currentScore) async {
    await QuizService.updateHighScore(currentScore);
  }
}
