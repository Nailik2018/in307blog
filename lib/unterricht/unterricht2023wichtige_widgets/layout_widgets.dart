import 'package:flutter/material.dart';

void main() {
  runApp(MyLayoutApp());
}

class MyLayoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout-Widgets Beispiel'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.purple,
                height: 100.0,
                width: double.infinity,
                child: Center(child: Text('Container')),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Padding'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Row 1'),
                  Text('Row 2'),
                ],
              ),
              Column(
                children: [
                  Text('Column 1'),
                  Text('Column 2'),
                ],
              ),
              Stack(
                children: [
                  Container(
                    height: 200.0,
                    width: 200.0,
                    color: Colors.yellow,
                  ),
                  Positioned(
                    top: 50.0,
                    left: 50.0,
                    child: Text('Stacked Text'),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: Center(child: Text('Expanded')),
                ),
              ),
              // Weitere Layout-Widgets hier...
            ],
          ),
        ),
      ),
    );
  }
}