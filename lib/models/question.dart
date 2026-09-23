import 'package:decadedash/enums/difficulty.dart';

class Question {
  String name;
  String shortName;
  List<String> answer;
  Difficulty difficulty;
  String hint;

  Question(
    this.name,
    this.answer,
    this.difficulty,
    this.hint, {
    required this.shortName,
  });

  List<String> get shuffledAnswers {
    final shuffledList = List.of(answer);
    shuffledList.shuffle();
    return shuffledList;
  }
}
