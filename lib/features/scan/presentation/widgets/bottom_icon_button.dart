import 'package:flutter/material.dart';

class BottomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const BottomIconButton({
    required this.icon,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.white,
        child: Icon(icon, color: const Color(0xFF1A237E)),
      ),
    );
  }
}
