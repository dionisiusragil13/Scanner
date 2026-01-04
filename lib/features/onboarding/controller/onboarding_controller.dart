// Contoh jika menggunakan GetX atau Logic Class sederhana
import 'package:flutter/material.dart';

class OnboardingController {
  void navigateToNext(PageController controller) {
    controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
  
  void skipToLast(PageController controller) {
    controller.jumpToPage(2);
  }
}