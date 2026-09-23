import 'package:flutter/material.dart';
import 'dart:ui';

class AnswerCard extends StatelessWidget {
  final String question;
  final String? answer;
  final String correctAnswer;
  final int questionIndex;
  final bool isUsed;
  const AnswerCard({
    super.key,
    required this.answer,
    required this.correctAnswer,
    required this.question,
    required this.questionIndex,
    required this.isUsed,
  });

  @override
  Widget build(BuildContext context) {
    var accentColor = answer == correctAnswer
        ? Color(0xff008080)
        : Color(0xFFF87171);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 16,
            sigmaY: 16,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: accentColor,
                ),
              ],
              borderRadius: BorderRadiusGeometry.circular(16),
              border: Border.all(
                width: 3,
                color: accentColor,
              ),
              color: Colors.black.withValues(alpha: 0.7),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: accentColor, width: 2),
                    shape: BoxShape.circle,
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                  child: Text(
                    "$questionIndex",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question,
                        maxLines: 2,
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Wrap(
                        spacing: 7,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            answer ?? "No answer",
                            style: TextStyle(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "VS",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Correct: $correctAnswer",
                            style: TextStyle(
                              color: Color(0xff008080),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isUsed)
                            Icon(
                              Icons.lightbulb_outline_rounded,
                              color: Colors.yellow,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentColor,
                  ),
                  child: answer == correctAnswer
                      ? Icon(Icons.check)
                      : Icon(Icons.close),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
