import 'package:flutter/material.dart';

class AccountDecider extends StatelessWidget {
  final String text;
  final VoidCallback action;
  final String actionText;

  const AccountDecider({super.key, required this.text, required this.action, required this.actionText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Color(0xff898989),
            fontWeight: FontWeight.w300,
            fontSize: 12.0,
          ),
        ),
        TextButton(
          onPressed: action,
          child: Text(
            actionText,
            style: TextStyle(
              color: Color(0xff191970),
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    );
  }
}
