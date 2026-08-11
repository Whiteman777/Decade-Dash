import 'dart:ui';

import 'package:decadedash/data/questions.dart';
import 'package:decadedash/enums/difficulty.dart';
import 'package:decadedash/models/question.dart';
import 'package:decadedash/widgets/buttons/answer_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../enums/duration.dart';

class QuestionScreen extends StatefulWidget {
  final Function() switchScreen;
  final Function(String answer) onSelectedAnswer;
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

  late final List<Question> _quiz =
      questions.where((q) => q.difficulty == widget.difficulty).toList()
        ..shuffle();

  void _loadNextAnswers() {
    setState(() {
      _answers = _quiz[currentIndex].shuffledAnswers;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNextAnswers();
  }

  void nextQuestion(String answer) {
    setState(() {
      currentIndex++;
    });
    widget.onSelectedAnswer(answer);
    _loadNextAnswers();
  }

  void endQuiz() {
    if (currentIndex == _quiz.length - 1) {
      setState(() {
        currentIndex = 0;
        widget.switchScreen();
      });
    }
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Progress".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              textAlign: TextAlign.start,
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
                            color: Colors.green,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "20s",
                            style: TextStyle(
                              color: Colors.amber,
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
            SizedBox(
              height: 20,
            ),
            ..._answers.map(
              (answer) => AnswerButton(
                answer: answer,
                onTap: () {
                  endQuiz();
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
