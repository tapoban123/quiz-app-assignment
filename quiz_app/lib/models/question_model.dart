// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuestionModel {
  final int questionNumber;
  final String description;
  final String detailedSolution;
  final List<Map<String, dynamic>> options;

  QuestionModel({
    required this.questionNumber,
    required this.description,
    required this.detailedSolution,
    required this.options,
  });

  QuestionModel copyWith({
    int? questionNumber,
    String? description,
    String? detailedSolution,
    List<Map<String, dynamic>>? options,
  }) {
    return QuestionModel(
      questionNumber: questionNumber ?? this.questionNumber,
      description: description ?? this.description,
      detailedSolution: detailedSolution ?? this.detailedSolution,
      options: options ?? this.options,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questionNumber': questionNumber,
      'description': description,
      'detailedSolution': detailedSolution,
      'options': options,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      questionNumber: map['questionNumber'] as int,
      description: map['description'] as String,
      detailedSolution: map['detailedSolution'] as String,
      options: List<Map<String, dynamic>>.from(
        (map['options'] as List<Map<String, dynamic>>)
            .map<Map<String, dynamic>>(
          (x) => x,
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuestionModel(questionNumber: $questionNumber, description: $description, detailedSolution: $detailedSolution, options: $options)';
  }

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;

    return other.questionNumber == questionNumber &&
        other.description == description &&
        other.detailedSolution == detailedSolution &&
        listEquals(other.options, options);
  }

  @override
  int get hashCode {
    return questionNumber.hashCode ^
        description.hashCode ^
        detailedSolution.hashCode ^
        options.hashCode;
  }
}
