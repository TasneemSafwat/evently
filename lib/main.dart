import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(eventlyApp());
}

class eventlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routename: (_) => LoginScreen(),
        RegisterScreen.routename: (_) => RegisterScreen(),
        HomeScreen.routename: (_) => HomeScreen(),
      },
      initialRoute: HomeScreen.routename,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
