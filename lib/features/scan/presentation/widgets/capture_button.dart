import 'package:flutter/material.dart';

class CaptureButton extends StatelessWidget {
  final VoidCallback onTap;

  const CaptureButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
        ),
        child: const Center(
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
