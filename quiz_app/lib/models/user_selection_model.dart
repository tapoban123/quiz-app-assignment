class UserSelectionModel {
  final int questionNumber;
  final String questionThumbnail;
  final String question;
  final String chosenOption;
  final bool isCorrect;

  UserSelectionModel({
    required this.questionNumber,
    required this.questionThumbnail,
    required this.question,
    required this.chosenOption,
    required this.isCorrect,
  });
}
