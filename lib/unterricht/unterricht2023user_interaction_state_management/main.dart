import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:in307blog/unterricht/unterricht2023user_interaction_state_management/providers/blog_provider.dart';
import 'package:in307blog/unterricht/unterricht2023user_interaction_state_management/screens/main_screen.dart';


void main() {
  runApp(const MainApp());
}

final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.cyanAccent,
    );
    return ChangeNotifierProvider(
      create: (_) => BlogProvider(),
      child: MaterialApp(
        navigatorKey: mainNavigatorKey,
        title: "Interaction and State",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: colorScheme,
          scaffoldBackgroundColor: colorScheme.surfaceVariant,
          appBarTheme: AppBarTheme(
            backgroundColor: colorScheme.surfaceVariant,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
