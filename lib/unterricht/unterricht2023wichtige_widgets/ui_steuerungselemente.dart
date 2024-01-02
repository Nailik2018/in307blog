import 'package:flutter/material.dart';

void main() {
  runApp(MyUIControlsApp());
}

class MyUIControlsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('UI-Steuerungselemente Beispiel'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Aktion bei Drücken des ElevatedButtons
                },
                child: Text('Elevated Button'),
              ),
              TextButton(
                onPressed: () {
                  // Aktion bei Drücken des TextButtons
                },
                child: Text('Text Button'),
              ),
              OutlinedButton(
                onPressed: () {
                  // Aktion bei Drücken des OutlinedButtons
                },
                child: Text('Outlined Button'),
              ),
              Switch(
                value: true,
                onChanged: (value) {
                  // Aktion bei Änderung des Switch-Status
                },
              ),
              Checkbox(
                value: true,
                onChanged: (value) {
                  // Aktion bei Änderung des Checkbox-Status
                },
              ),
              Radio(
                value: 1,
                groupValue: 1,
                onChanged: (value) {
                  // Aktion bei Auswahl des Radio-Buttons
                },
              ),
              // Weitere UI-Steuerungselemente hier...
            ],
          ),
        ),
      ),
    );
  }
}