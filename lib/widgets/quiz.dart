import 'package:decadedash/enums/difficulty.dart';
import 'package:decadedash/enums/duration.dart';
import 'package:decadedash/models/question.dart';
import 'package:decadedash/widgets/screens/question_screen.dart';
import 'package:decadedash/widgets/screens/result_screen.dart';
import 'package:decadedash/widgets/screens/setup_screen.dart';
import 'package:decadedash/widgets/screens/start_screen.dart';
import 'package:decadedash/theme/background_theme.dart';
import 'package:flutter/material.dart';

import '../data/questions.dart';
import '../models/quiz_result.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  final List<QuizResult> _results = [];
  late List<Question> quizQuestions;
  DurationTime? _duration;
  Difficulty? _difficulty;
  var activeScreen = "start-screen";

  void switchScreen() {
    setState(() {
      if (activeScreen == "start-screen") {
        activeScreen = "setup-screen";
      } else if (activeScreen == "question-screen") {
        activeScreen = "result-screen";
      } else {
        _results.clear();
        activeScreen = "start-screen";
      }
    });
  }

  void selectAnswer(Question question, String? answer, bool usedHint) {
    _results.add(
      QuizResult(
        question: question,
        givenAnswer: answer,
        isUsed: usedHint,
      ),
    );
  }

  void startQuiz(Difficulty difficulty, DurationTime duration) {
    _difficulty = difficulty;
    _duration = duration;
    quizQuestions = questions.where((q) => q.difficulty == difficulty).toList()
      ..shuffle();

    setState(() {
      activeScreen = "question-screen";
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidget = activeScreen == "start-screen"
        ? StartScreen(onStart: switchScreen)
        : activeScreen == "setup-screen"
        ? SetupScreen(startQuiz)
        : activeScreen == "question-screen"
        ? QuestionScreen(
            switchScreen,
            quizQuestions: quizQuestions,
            duration: _duration,
            difficulty: _difficulty,
            onSelectedAnswer: selectAnswer,
          )
        : ResultScreen(
            results: _results,
            onRestart: switchScreen,
            totalQuestions: quizQuestions,
          );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BackgroundTheme(screen: screenWidget),
      ),
    );
  }
}
