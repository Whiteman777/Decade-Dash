import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function()? initialize;
  const StartButton({
    super.key,
    this.initialize,
    required this.icon,
    required this.label,
  });

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
      icon: icon,
      label: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'Plus Jakarta Sans', 
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
