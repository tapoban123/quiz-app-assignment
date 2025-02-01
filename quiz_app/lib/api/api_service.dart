import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/option_model.dart';
import 'package:quiz_app/models/question_model.dart';

class ApiService {
  Future<List<QuestionModel>> fetchQuestions() async {
    List<QuestionModel> allQuestions = [];

    try {
      final response =
          await http.get(Uri.parse("https://api.jsonserve.com/Uw5CrX"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["questions"] as List;

        for (final question in data) {
          final options = question["options"] as List<dynamic>;

          final newQuestion =
              QuestionModel.fromMap(question as Map<String, dynamic>).copyWith(
            questionNumber: data.indexOf(question) + 1,
            options: options
                .map(
                  (e) => OptionModel.fromMap(e)
                      .copyWith(optionNumber: options.indexOf(e) + 1),
                )
                .toList(),
          );
          allQuestions.add(newQuestion);
        }
      } else {
        throw const HttpException("Failed to fetch data.");
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return allQuestions;
  }
}
