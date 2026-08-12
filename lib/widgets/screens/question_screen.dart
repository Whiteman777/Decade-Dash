import 'dart:ui';
import 'dart:async';

import 'package:decadedash/data/questions.dart';
import 'package:decadedash/enums/difficulty.dart';
import 'package:decadedash/models/question.dart';
import 'package:decadedash/widgets/buttons/answer_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../enums/duration.dart';

class QuestionScreen extends StatefulWidget {
  final Function() switchScreen;
  final Function(String? answer)? onSelectedAnswer;
  final DurationTime? duration;
  final Difficulty? difficulty;

  const QuestionScreen(
    this.switchScreen, {
    super.key,
    required this.onSelectedAnswer,
    required this.difficulty,
    required this.duration,
  });

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  late List<String> _answers;
  var currentIndex = 0;
  Timer? _timer;
  int _secondsLeft = 0;
  var hintCounter = 0;
  late final List<Question> _quiz =
      questions.where((q) => q.difficulty == widget.difficulty).toList()
        ..shuffle();

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
      _answers = _quiz[currentIndex].shuffledAnswers;
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

  void nextQuestion(String? answer) {
    if (!(currentIndex >= _quiz.length - 1)) {
      setState(() {
        currentIndex++;
        hintCounter = 0;
      });
    }
    _startTimer();
    widget.onSelectedAnswer?.call(answer);
    _loadNextAnswers();
  }

  void _endQuiz() {
    if (currentIndex >= _quiz.length - 1) {
      setState(() {
        currentIndex = 0;
        widget.switchScreen();
      });
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
          String? answer;
          _secondsLeft = 0;
          _endQuiz();
          nextQuestion(answer);
        });
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void showHintDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Need a hint?"),
        content: Text(_quiz[currentIndex].hint),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                hintCounter++;
              });
              Navigator.pop(ctx);
            },
            child: Text("Got it!"),
          ),
        ],
      ),
    );
  }

  Color get hintIconColor {
    var color = Colors.white.withValues(alpha: 0.95);
    setState(() {
      if (hintCounter >= 1) {
        color = Colors.yellow;
      }
    });
    return color;
  }

  @override
  Widget build(BuildContext context) {
    var x = currentIndex + 1;
    var y = _quiz.length;
    var currentQuestion = _quiz[currentIndex];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "DecadeDash",
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            color: Color(0xff008080),
          ),
        ),
        actions: [],
      ),
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
                  _endQuiz();
                  nextQuestion(answer);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
