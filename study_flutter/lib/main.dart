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
      color: Colors.green,
      width: 200,
      height: 200,
      // alignment: Alignment.center,
      alignment: Alignment(1.0, 1.0),
      child: Text(
        'TinCoder',
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }
}
