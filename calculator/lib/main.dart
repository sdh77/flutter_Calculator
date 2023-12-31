import 'package:calculator/screen/calculator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color.fromRGBO(89, 89, 89, 1),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 60,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 60,
          ),
        ),
      ),
      home: const calc(),
    );
  }
}
