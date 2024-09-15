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
      child: TextButton.icon(
        onPressed: () {
          print('Click text button');
        },
        //onPressed: null,
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.pink,
          // minimumSize: Size(120, 60),
          padding: EdgeInsets.all(30),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 20,
          shadowColor: Colors.blue.withOpacity(0.5),
          side: BorderSide(width: 2, color: Colors.orange),
          // disabledBackgroundColor: Colors.grey,
          // disabledForegroundColor: Colors.white,
        ),
        label: Text(
          'Text Button',
          style: TextStyle(fontSize: 36.0),
        ),
        icon: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
