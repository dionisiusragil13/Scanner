import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scanner/core/local/app_preferences.dart';
import 'package:scanner/features/auth/presentation/pages/auth_page.dart';
import 'package:scanner/features/navigation/presentation/pages/main_page.dart';
import 'package:scanner/features/onboarding/presentation/pages/onboarding_page.dart';

class PageDecider extends StatelessWidget {
  const PageDecider({super.key});

  @override
  Widget build(BuildContext context) {
    final appPrefs = AppPreferences();

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return AuthPage();
        }

        return FutureBuilder<bool>(
          future: appPrefs.isOnboardingDone(),
          builder: (context, onboardingSnapshot) {
            if (!onboardingSnapshot.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (!onboardingSnapshot.data!) {
              return const OnboardingPage();
            }

            return const MainPage();
          },
        );
      },
    );
  }
}
