import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/setting_provider.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  Future<void> _goToLogin(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    Navigator.pushReplacementNamed(context, LoginScreen.routename);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<SettingProvider>(context).isDark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.backgroundZLight,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/boarding1.png',
              width: screenWidth * 0.9,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Plan and host amazing events with ease!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: isDark ? AppTheme.white : AppTheme.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Evently is your go-to app for organizing, sharing,\nand enjoying events like never before.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? AppTheme.white : AppTheme.black,
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _goToLogin(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Let's Start",
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? AppTheme.white : AppTheme.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
