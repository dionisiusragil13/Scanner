import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const WhiteButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Color(0xff191970), fontSize: 18), 
        ),
      ),
    );
  }
}