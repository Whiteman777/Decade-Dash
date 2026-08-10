import 'package:decadedash/enums/difficulty.dart';

class Question {
  String name;
  List<String> answer;
  Difficulty difficulty;

  Question(
    this.name,
    this.answer,
    this.difficulty,
  );

  List<String> get shuffledAnswers {
    final shuffledList = List.of(answer);
    shuffledList.shuffle();
    return shuffledList;
  }
}
