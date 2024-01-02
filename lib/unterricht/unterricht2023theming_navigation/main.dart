import 'package:flutter/material.dart';
import 'package:in307blog/unterricht/unterricht2023theming_navigation/screens/main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Theming/Navigation",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyanAccent,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyanAccent,
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
