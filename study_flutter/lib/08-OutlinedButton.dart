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
      margin: EdgeInsets.all(30),
      child: OutlinedButton.icon(
          onPressed: () {
            print('Click the Outline Button');
          },
          //onPressed: null
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            // minimumSize: Size(300, 50),
            padding: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            elevation: 10,
            shadowColor: Colors.blue.withOpacity(0.5),
            side: BorderSide(
              width: 2,
              color: Colors.orange,
            ),
            // disabledBackgroundColor: Colors.grey,
            // disabledForegroundColor: Colors.white.withOpacity(0.5),
          ),
          icon: Icon(
            Icons.edit,
            size: 30,
          ),
          label: Text(
            'Outline button',
            style: TextStyle(
              fontSize: 28,
            ),
          )),
    );
  }
}
