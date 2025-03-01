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

    if (_userAnswers.any(
      (element) => element.question == userAnswer.question,
    )) {
      _userAnswers[_userAnswers.indexWhere(
        (element) => element.question == userAnswer.question,
      )] = userAnswer;
    } else {
      _userAnswers.add(userAnswer);
    }
    notifyListeners();
  }

  bool hasUnansweredQuestion() {
    for (final answer in _userAnswers) {
      if (answer.chosenOption == null) {
        return true;
      }
    }
    return false;
  }

  void resetProvider() {
    _currentQuestionNumber = 1;
    _userAnswers.clear();
    _totalScore = 0;
    notifyListeners();
  }

  void nextQuestion() {
    _currentQuestionNumber += 1;
    notifyListeners();
  }

  void setQsNumber(qsNum) {
    _currentQuestionNumber = qsNum;
    notifyListeners();
  }

  void previousQuestion() {
    _currentQuestionNumber -= 1;
    notifyListeners();
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
