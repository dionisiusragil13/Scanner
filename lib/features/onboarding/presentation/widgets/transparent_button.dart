import 'package:flutter/material.dart';


class TransparentButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TransparentButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style:TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}