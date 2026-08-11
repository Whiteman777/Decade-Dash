import 'package:decadedash/enums/difficulty.dart';
import 'package:decadedash/enums/duration.dart';
import 'package:decadedash/widgets/screens/question_screen.dart';
import 'package:decadedash/widgets/screens/setup_screen.dart';
import 'package:decadedash/widgets/screens/start_screen.dart';
import 'package:decadedash/theme/background_theme.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  final List<String> answers = [];
  DurationTime? _duration;
  Difficulty? _difficulty;
  var activeScreen = "start-screen";

  void switchScreen() {
    setState(() {
      if (activeScreen == "start-screen") {
        {
          activeScreen = "setup-screen";
        }
      } else if (activeScreen == "question-screen") {
        activeScreen = "start-screen";
      }
    });
  }

  void selectAnswer(String answer) {
    answers.add(answer);
  }

  void startQuiz(Difficulty difficulty, DurationTime duration) {
    _difficulty = difficulty;
    _duration = duration;
    setState(() {
      activeScreen = "question-screen";
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidget = activeScreen == "start-screen"
        ? StartScreen(switchScreen)
        : activeScreen == "setup-screen"
        ? SetupScreen(startQuiz)
        : QuestionScreen(
            switchScreen,
            onSelectedAnswer: selectAnswer,
            duration: _duration,
            difficulty: _difficulty,
          );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BackgroundTheme(screen: screenWidget),
      ),
    );
  }
}
