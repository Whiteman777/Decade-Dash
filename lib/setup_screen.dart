import 'dart:ui';

import 'package:decadedash/buttons/difficulty_button.dart';
import 'package:decadedash/buttons/duration_button.dart';
import 'package:decadedash/buttons/start_quiz_button.dart';
import 'package:decadedash/enums/duration.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'enums/difficulty.dart';

class SetupScreen extends StatefulWidget {
  final Function() start;
  const SetupScreen(
    this.start, {
    super.key,
  });

  @override
  State<SetupScreen> createState() {
    return _SetupScreenState();
  }
}

class _SetupScreenState extends State<SetupScreen> {
  Difficulty? _selectedDifficulty;
  DurationTime? _selectedDuration;

  void _selectDifficulty(Difficulty difficulty) {
    setState(() {
      _selectedDifficulty = difficulty;
    });
  }

  void _selectDuration(DurationTime duration) {
    setState(() {
      _selectedDuration = duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    double resp(double size) => size * MediaQuery.of(context).size.width / 375;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              "Setup your quiz",
              textAlign: TextAlign.center,
              style: GoogleFonts.googleSans(
                color: Colors.white,
                fontSize: resp(30),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Opacity(
                opacity: 0.5,
                child: Text(
                  "Configure your quiz before starting your journey.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.googleSans(
                    color: Colors.white,
                    fontSize: resp(16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.route_sharp,
                          color: Colors.white,
                          size: resp(18),
                        ),
                      ),
                      Text(
                        "Choose Difficulty",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.googleSans(
                          color: Colors.white,
                          fontSize: resp(18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: DifficultyButtons(
                                icon: Icons.sentiment_satisfied,
                                text: "Easy",
                                onTap: () => _selectDifficulty(Difficulty.easy),
                                isSelected:
                                    _selectedDifficulty == Difficulty.easy,
                                accentColor: Color(0xFF00C853),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: DifficultyButtons(
                                icon: Icons.psychology,
                                text: "Medium",
                                onTap: () =>
                                    _selectDifficulty(Difficulty.medium),
                                isSelected:
                                    _selectedDifficulty == Difficulty.medium,
                                accentColor: Color(0xFFFF9800),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: DifficultyButtons(
                                icon: Icons.bolt,
                                text: "Hard",
                                onTap: () => _selectDifficulty(Difficulty.hard),
                                isSelected:
                                    _selectedDifficulty == Difficulty.hard,
                                accentColor: Color(0xFFE53935),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.timer_outlined,
                          color: Colors.white,
                          size: resp(18),
                        ),
                      ),
                      Text(
                        "Question Duration",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.googleSans(
                          color: Colors.white,
                          fontSize: resp(18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: DurationButton(
                                text: "10s",
                                onTap: () => _selectDuration(DurationTime.ten),
                                isSelected:
                                    _selectedDuration == DurationTime.ten,
                                accentColor: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: DurationButton(
                                text: "15s",
                                onTap: () =>
                                    _selectDuration(DurationTime.fifteen),
                                isSelected:
                                    _selectedDuration == DurationTime.fifteen,
                                accentColor: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: DurationButton(
                                text: "20s",
                                onTap: () =>
                                    _selectDuration(DurationTime.twenty),
                                isSelected:
                                    _selectedDuration == DurationTime.twenty,
                                accentColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
              child: StartQuizButton(
                widget.start,
                isEnabled:
                    _selectedDifficulty != null && _selectedDuration != null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
