import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/option_model.dart';
import 'package:quiz_app/models/question_model.dart';

class ApiService {
  Future<void> fetchQuestions() async {
    List<QuestionModel> allQuestions = [];

    try {
      final response =
          await http.get(Uri.parse("https://api.jsonserve.com/Uw5CrX"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["questions"];

        for (final question in data) {
          print(question["detailedSolution"]);
          final newQuestion =
              QuestionModel.fromMap(question as Map<String, dynamic>).copyWith(
            questionNumber: 1,
            options: jsonDecode(question["options"]).map((element) => OptionModel.fromJson(element)).toList(),
          );
          allQuestions.add(newQuestion);
        }
        print(allQuestions);
      }

      throw const HttpException("Failed to fetch data.");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
