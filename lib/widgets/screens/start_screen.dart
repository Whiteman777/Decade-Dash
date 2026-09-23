import 'package:decadedash/widgets/buttons/start_button.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final VoidCallback onStart;
  const StartScreen({super.key, required this.onStart});

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
            style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
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
              style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          StartButton(
            initialize: onStart,
            icon: Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
            ),
            label: "Start",
          ),
        ],
      ),
    );
  }
}
