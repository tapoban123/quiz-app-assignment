// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OptionModel {
  final int? optionNumber;
  final String description;
  final bool is_correct;
  OptionModel({
    this.optionNumber,
    required this.description,
    required this.is_correct,
  });

  

  OptionModel copyWith({
    int? optionNumber,
    String? description,
    bool? is_correct,
  }) {
    return OptionModel(
      optionNumber: optionNumber ?? this.optionNumber,
      description: description ?? this.description,
      is_correct: is_correct ?? this.is_correct,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'optionNumber': optionNumber,
      'description': description,
      'is_correct': is_correct,
    };
  }

  factory OptionModel.fromMap(Map<String, dynamic> map) {
    return OptionModel(
      optionNumber: map['optionNumber'] != null ? map['optionNumber'] as int : null,
      description: map['description'] as String,
      is_correct: map['is_correct'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OptionModel.fromJson(String source) => OptionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OptionModel(optionNumber: $optionNumber, description: $description, is_correct: $is_correct)';

  @override
  bool operator ==(covariant OptionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.optionNumber == optionNumber &&
      other.description == description &&
      other.is_correct == is_correct;
  }

  @override
  int get hashCode => optionNumber.hashCode ^ description.hashCode ^ is_correct.hashCode;
}
