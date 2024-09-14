import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: MyWidget(),
    ),
  ));
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: TextButton(
        onPressed: () {
          print('Click text button');
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.pink,
          // minimumSize: Size(120, 60),
          padding: EdgeInsets.all(30),
        ),
        child: Text(
          'Text Button',
          style: TextStyle(fontSize: 36.0),
        ),
      ),
    );
  }
}
