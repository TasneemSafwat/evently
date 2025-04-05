import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/create_event_screen.dart';
import 'package:evently/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: kIsWeb
          ? const FirebaseOptions(
              apiKey: "AIzaSyC2vqi-VgqZMsPYaQjpPue3kSgtBpy04p0",
              authDomain: "evently-3a298.firebaseapp.com",
              projectId: "evently-3a298",
              storageBucket: "evently-3a298.firebasestorage.app",
              messagingSenderId: "262182444262",
              appId: "1:262182444262:web:a3f17141975a125283ef27",
              measurementId: "G-3XJ8QG2R6Z",
            )
          : null,
    );
  } catch (e) {
    print("🔥 خطأ أثناء تهيئة Firebase: $e");
  }

  runApp(const EventlyApp());
}

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routename: (_) => LoginScreen(),
        RegisterScreen.routename: (_) => RegisterScreen(),
        HomeScreen.routename: (_) => HomeScreen(),
        CreateEventScreen.routeName: (_) => CreateEventScreen(),
      },
      initialRoute: HomeScreen.routename,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
