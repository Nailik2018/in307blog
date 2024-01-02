import 'package:flutter/material.dart';

void main() {
  runApp(MyTextApp());
}

class MyTextApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Text-Widgets Beispiel'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Einfacher Text'),
              RichText(
                text: TextSpan(
                  text: 'Rich',
                  style: TextStyle(color: Colors.blue),
                  children: [
                    TextSpan(
                      text: 'Text',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Benutzereingabe'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Formulareingabe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}