import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartButton extends StatelessWidget {
  final Function() initialize;
  const StartButton(this.initialize, {super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: initialize,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        side: BorderSide(
          width: 2,
          color: Colors.white,
        ),
        minimumSize: Size(225, 75),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
      ),
      iconAlignment: IconAlignment.end,
      icon: Icon(
        Icons.arrow_forward_rounded,
        color: Colors.white,
      ),
      label: Text(
        "Start",
        textAlign: TextAlign.center,
        style: GoogleFonts.googleSans(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
