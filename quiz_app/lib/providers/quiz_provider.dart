import 'package:flutter/material.dart';
import 'package:quiz_app/api/api_service.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/models/user_selection_model.dart';

class QuizProvider extends ChangeNotifier {
  int _currentQuestionNumber = 1;
  int _totalScore = 0;
  List<UserSelectionModel> _userAnswers = [];
  List<QuestionModel> _questions = [];

  int get currentQsNumber => _currentQuestionNumber;
  int get totalScore => _totalScore;
  List<UserSelectionModel> get userAnswers => _userAnswers;
  List<QuestionModel> get questions => _questions;

  void acceptUserChoice(UserSelectionModel userAnswer) {
    if (userAnswer.questionNumber < questions.length) {
      nextQuestion();
    }
    _userAnswers.add(userAnswer);
    notifyListeners();
  }

  void nextQuestion() {
    _currentQuestionNumber += 1;
  }

  void previousQuestion() {
    _currentQuestionNumber -= 1;
  }

  void createQuestionsList(QuestionModel question) {
    _questions.add(question);
    notifyListeners();
  }

  void fetchQuestions() async {
    _questions = await ApiService().fetchQuestions();
    notifyListeners();
  }

  void calculateTotalScore() {
    _totalScore = 0;
    for (final answer in _userAnswers) {
      if (answer.isCorrect) {
        _totalScore += 10;
      }
    }
  }
}
