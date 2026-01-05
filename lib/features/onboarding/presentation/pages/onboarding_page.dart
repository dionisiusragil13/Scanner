import 'package:flutter/material.dart';
import 'package:scanner/features/auth/presentation/pages/auth_page.dart';
import 'package:scanner/features/auth/presentation/pages/login_page.dart';

import 'package:scanner/features/onboarding/controller/onboarding_model.dart';
import 'package:scanner/core/widgets/transparent_button.dart';
import 'package:scanner/core/widgets/white_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPage();
}

class _OnboardingPage extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      width: _currentIndex == index ? 25 : 10,
      decoration: BoxDecoration(
        color: _currentIndex == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff191970),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemCount: onboardingContents.length,
              itemBuilder: (context, index) {
                final data = onboardingContents[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(data.image, height: 250),
                      const SizedBox(height: 40),
                      Text(
                        data.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingContents.length,
                    (index) => buildDot(index),
                  ),
                ),
                const SizedBox(height: 40),
                WhiteButton(
                  text: "Get Started",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AuthPage()),
                    );
                  },
                ),
                SizedBox(height: 20.0),
                TransparentButton(
                  text: "Login",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
                SizedBox(height: 60.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
