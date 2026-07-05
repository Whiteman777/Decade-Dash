import 'package:decadedash/setup_screen.dart';
import 'package:decadedash/start_screen.dart';
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
  var activeScreen = "start-screen";

  void switchScreen() {
    setState(() {
      if (activeScreen == "start-screen") {
        {
          activeScreen = "setup-screen";
        }
      } else if (activeScreen == "setup-screen") {
        activeScreen = "start-screen";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidget = activeScreen == "start-screen"
        ? StartScreen(switchScreen)
        : activeScreen == "setup-screen"
        ? SetupScreen(switchScreen)
        : StartScreen(switchScreen);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BackgroundTheme(screen: screenWidget),
      ),
    );
  }
}
