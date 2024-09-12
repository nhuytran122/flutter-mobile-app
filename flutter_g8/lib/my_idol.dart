import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MyIdol extends StatelessWidget {
  const MyIdol({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Marquee(
          text: 'XIN CHÀO VIỆT NAM!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 50.0,
          ),
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          blankSpace: 20.0,
          velocity: 600.0,
          pauseAfterRound: Duration(seconds: 1),
          startPadding: 10.0,
          accelerationDuration: Duration(seconds: 1),
          accelerationCurve: Curves.linear,
          decelerationDuration: Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
        ),
      ),
    );
  }
}
