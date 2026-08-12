import 'package:decadedash/enums/difficulty.dart';

class Question {
  String name;
  List<String> answer;
  Difficulty difficulty;
  String hint;

  Question(
    this.name,
    this.answer,
    this.difficulty,
    this.hint,
  );

  List<String> get shuffledAnswers {
    final shuffledList = List.of(answer);
    shuffledList.shuffle();
    return shuffledList;
  }
}
