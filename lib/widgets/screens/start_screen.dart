import 'package:decadedash/widgets//buttons/start_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  final Function() screen;
  const StartScreen(this.screen, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/startScreen/logo.png",
            width: 150,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "Decade Dash",
            style: GoogleFonts.googleSans(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Opacity(
            opacity: 0.65,
            child: Text(
              "Test your history knowledge!",
              style: GoogleFonts.googleSans(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          StartButton(screen),
        ],
      ),
    );
  }
}
