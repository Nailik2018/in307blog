import 'package:flutter/material.dart';

void main() {
  runApp(MyListsApp());
}

class MyListsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Listen-Widgets Beispiel'),
        ),
        body: ListView(
          children:  [
            ListTile(
              title: Text('Listenelement 1'),
            ),
            ListTile(
              title: Text('Listenelement 2'),
            ),
            ExpansionTile(
              title: Text('Erweiterbares Listenelement'),
              children: [
                ListTile(
                  title: Text('Unterelement 1'),
                ),
                ListTile(
                  title: Text('Unterelement 2'),
                ),
              ],
            ),
            GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Card(
                  child: Center(
                    child: Text('Gitterelement $index'),
                  ),
                );
              },
              itemCount: 4,
            ),
            // Weitere Listen-Widgets hier...
          ],
        ),
      ),
    );
  }
}