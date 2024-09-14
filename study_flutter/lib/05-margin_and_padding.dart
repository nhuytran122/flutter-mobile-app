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
    return Center(
      child: Card(
        color: Colors.blue,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 100),
          // padding: EdgeInsets.only(left: 60, top: 30),
          // padding: EdgeInsets.only(left: 60),
          // padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
          // padding: EdgeInsets.all(30.0),
          child: Text(
            'Nhu Y',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
