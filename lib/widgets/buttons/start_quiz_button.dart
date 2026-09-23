import 'package:flutter/material.dart';

class StartQuizButton extends StatelessWidget {
  final VoidCallback initialize;
  final bool isEnabled;

  const StartQuizButton(
    this.initialize, {
    super.key,
    this.isEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: isEnabled ? initialize : null,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        side: BorderSide(
          width: 2,
          color: isEnabled ? Colors.white : Colors.white.withValues(alpha: 0.3),
        ),
        minimumSize: Size(225, 75),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
      ),
      iconAlignment: IconAlignment.end,
      icon: Icon(
        Icons.arrow_forward,
        color: isEnabled ? Colors.white : Colors.white.withValues(alpha: 0.3),
      ),
      label: Text(
        "Start Quiz",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
          color: isEnabled ? Colors.white : Colors.white.withValues(alpha: 0.3),
          fontSize: 30,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
