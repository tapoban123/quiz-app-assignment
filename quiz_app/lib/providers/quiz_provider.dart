import 'package:flutter/material.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/models/user_selection_model.dart';

class QuizProvider extends ChangeNotifier {
  int _currentQuestionNumber = 1;
  int _totalScore = 0;
  final List<UserSelectionModel> _userAnswers = [];
  final List<QuestionModel> _questions = [];

  int get currentQsNumber => _currentQuestionNumber;
  int get totalScore => _totalScore;
  List<UserSelectionModel> get userAnswers => _userAnswers;
  List<QuestionModel> get questions => _questions;

  void acceptUserChoice(UserSelectionModel userAnswer) {
    _currentQuestionNumber += 1;
    _userAnswers.add(userAnswer);
    notifyListeners();
  }

  void createQuestionsList(QuestionModel question) {
    _questions.add(question);
    notifyListeners();
  }

  void calculateTotalScore() {
    for (final answer in _userAnswers) {
      if (answer.isCorrect) {
        _totalScore += 10;
      }
    }
  }
}
