import 'dart:ui';
import 'dart:async';

import 'package:decadedash/enums/difficulty.dart';
import 'package:decadedash/models/question.dart';
import 'package:decadedash/widgets/brand_app_bar.dart';
import 'package:decadedash/widgets/buttons/answer_button.dart';
import 'package:flutter/material.dart';

import '../../enums/duration.dart';

class QuestionScreen extends StatefulWidget {
  final Function() switchScreen;
  final Function(Question question, String? answer, bool usedHint)?
      onSelectedAnswer;
  final DurationTime? duration;
  final Difficulty? difficulty;
  final List<Question> quizQuestions;

  const QuestionScreen(
    this.switchScreen, {
    super.key,
    required this.quizQuestions,
    required this.difficulty,
    required this.duration,
    this.onSelectedAnswer,
  });

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  late List<String> _answers;
  var currentIndex = 0;
  var hintCounter = false;
  Timer? _timer;
  int _secondsLeft = 0;

  Color get durationColor {
    final s = _secondsLeft;
    return switch (widget.duration) {
      DurationTime.twenty =>
        s <= 5
            ? Colors.red.shade400
            : s <= 10
            ? Colors.amber
            : Colors.green,
      DurationTime.fifteen =>
        s <= 3
            ? Colors.red.shade400
            : s <= 7
            ? Colors.amber
            : Colors.green,
      DurationTime.ten =>
        s <= 3
            ? Colors.red.shade400
            : s <= 5
            ? Colors.amber
            : Colors.green,
      null => Colors.green,
    };
  }

  void _loadNextAnswers() {
    setState(() {
      _answers = widget.quizQuestions[currentIndex].shuffledAnswers;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNextAnswers();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void handleAnswer(String? answer) {
    final question = widget.quizQuestions[currentIndex];
    widget.onSelectedAnswer?.call(question, answer, hintCounter);

    if (currentIndex >= widget.quizQuestions.length - 1) {
      setState(() {
        currentIndex = 0;
      });
      widget.switchScreen();
    } else {
      setState(() {
        currentIndex++;
        hintCounter = false;
      });
      _startTimer();
      _loadNextAnswers();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsLeft = widget.duration!.seconds;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() {
          _secondsLeft = 0;
          handleAnswer(null);
        });
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void showHintDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss Hint',
      barrierColor: Colors.black.withValues(alpha: 0.70),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 16,
                    sigmaY: 16,
                  ),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 360),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 32,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadiusGeometry.circular(16),
                      border: Border.all(
                        color: Color(0xff008080),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff008080),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.yellow,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                            color: Colors.black.withValues(alpha: 0.5),
                          ),
                          child: const Icon(
                            Icons.lightbulb_outline_rounded,
                            color: Colors.yellow,
                            size: 36,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Need a hint?",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.quizQuestions[currentIndex].hint,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Lato', 
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 15,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              setState(() {
                                hintCounter = true;
                              });
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.black
                                  .withValues(alpha: 0.5),
                              side: BorderSide(
                                width: 2,
                                color: Color(0xff008080),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            iconAlignment: IconAlignment.end,
                            label: Text(
                              "Got it!",
                              style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          ),
        );
      },
    );
  }

  Color get hintIconColor {
    var color = Colors.white.withValues(alpha: 0.95);
    if (hintCounter) {
      color = Colors.yellow;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    var x = currentIndex + 1;
    var y = widget.quizQuestions.length;
    var currentQuestion = widget.quizQuestions[currentIndex];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: BrandAppBar(),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Progress".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Question $x of $y",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff008080).withValues(alpha: 0.3),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            color: durationColor,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "${_secondsLeft}s",
                            style: TextStyle(
                              color: durationColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: x / y,
              minHeight: 8,
              borderRadius: BorderRadius.circular(100),
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF008080),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            currentQuestion.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: showHintDialog,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                margin: EdgeInsets.symmetric(horizontal: 135),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      color: hintIconColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ..._answers.map(
              (answer) => AnswerButton(
                answer: answer,
                onTap: () {
                  handleAnswer(answer);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
