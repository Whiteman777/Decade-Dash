import 'package:decadedash/models/question.dart';

class QuizResult {
  final Question question;
  final String? givenAnswer;
  bool? isUsed = false;

  QuizResult({
    required this.question,
    required this.givenAnswer,
    this.isUsed,
  });
}
