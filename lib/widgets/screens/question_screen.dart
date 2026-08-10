import 'dart:ui';

import 'package:decadedash/data/questions.dart';
import 'package:decadedash/widgets/buttons/answer_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  final Function() switchScreen;
  final Function(String answer) onSelectedAnswer;

  QuestionScreen(
    this.switchScreen, {
    super.key,
    required this.onSelectedAnswer,
  });

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  late final List<String> _answers = questions[currentIndex].shuffledAnswers;
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    //var x = questions[]
    var currentQuestion = questions[currentIndex];
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
                  "Question x of y",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
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
                            "0s",
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
            SizedBox(
              height: 40,
            ),
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
            SizedBox(
              height: 40,
            ),
            ..._answers.map(
              (answer) => AnswerButton(answer: answer, onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
