import 'dart:ui';

import 'package:decadedash/models/question.dart';
import 'package:decadedash/models/quiz_result.dart';
import 'package:decadedash/widgets/answer_card.dart';
import 'package:decadedash/widgets/brand_app_bar.dart';
import 'package:decadedash/widgets/buttons/start_button.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final List<QuizResult> results;
  final VoidCallback onRestart;
  final List<Question> totalQuestions;
  const ResultScreen({
    super.key,
    required this.results,
    required this.totalQuestions,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    var total = totalQuestions.length;
    int correctCount = 0;
    for (var answer in results) {
      if (answer.givenAnswer == answer.question.answer.first) correctCount++;
    }
    var completion = correctCount / total * 100;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const BrandAppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 16,
                    sigmaY: 16,
                  ),
                  child: Container(
                    width: 155,
                    height: 155,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF9D50BB,
                          ).withValues(alpha: 0.3),
                          blurRadius: 36,
                        ),
                      ],
                      color: Colors.white.withValues(alpha: 0.11),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.5),
                        width: 2.6,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${completion.toInt()}%",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Success",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "You got $correctCount out of $total correct!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "SUMMARY:",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (var i = 0; i < results.length; i++)
                      AnswerCard(
                        question: results[i].question.shortName,
                        answer: results[i].givenAnswer,
                        correctAnswer: results[i].question.answer.first,
                        questionIndex: i + 1,
                        isUsed: results[i].isUsed ?? false,
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              StartButton(
                icon: Icon(
                  Icons.restart_alt_outlined,
                  color: Colors.white,
                  size: 25,
                ),
                label: "Restart",
                initialize: onRestart,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
