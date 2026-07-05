import 'package:flutter/material.dart';

class BackgroundTheme extends StatelessWidget {
  final Widget screen;

  const BackgroundTheme({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff4B0082),
            Color(0xff008080),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: screen,
    );
  }
}
