// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:quiz_app/models/option_model.dart';

class QuestionModel {
  final int? questionNumber;
  final String description;
  final String detailed_solution;
  final List<OptionModel> options;

  QuestionModel({
    this.questionNumber,
    required this.description,
    required this.detailed_solution,
    required this.options,
  });

  QuestionModel copyWith({
    int? questionNumber,
    String? description,
    String? detailed_solution,
    List<OptionModel>? options,
  }) {
    return QuestionModel(
      questionNumber: questionNumber ?? this.questionNumber,
      description: description ?? this.description,
      detailed_solution: detailed_solution ?? this.detailed_solution,
      options: options ?? this.options,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questionNumber': questionNumber,
      'description': description,
      'detailed_solution': detailed_solution,
      'options': options.map((x) => x.toMap()).toList(),
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      // questionNumber:
      //     map['questionNumber'] != null ? map['questionNumber'] as int : null,
      description: map['description'] as String,
      detailed_solution: map['detailed_solution'] as String,
      options: List<OptionModel>.from(
        (map['options'] as List<dynamic>).map<OptionModel>(
          (x) => OptionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuestionModel(questionNumber: $questionNumber, description: $description, detailed_solution: $detailed_solution, options: $options)';
  }

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;

    return other.questionNumber == questionNumber &&
        other.description == description &&
        other.detailed_solution == detailed_solution &&
        listEquals(other.options, options);
  }

  @override
  int get hashCode {
    return questionNumber.hashCode ^
        description.hashCode ^
        detailed_solution.hashCode ^
        options.hashCode;
  }
}
