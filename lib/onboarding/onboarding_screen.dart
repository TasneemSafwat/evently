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
      backgroundColor: isDark ? const Color(0xFF0E1C2F) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/onboarding1.png',
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
                  color: isDark ? Colors.white : const Color(0xFF0E1C2F),
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
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _goToLogin(context),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isDark ? Colors.white : const Color(0xFF0E1C2F),
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
                  color: isDark ? const Color(0xFF0E1C2F) : Colors.white,
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
