import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_g8/entity/classroom.dart';

class MyClassroom extends StatelessWidget {
  MyClassroom({super.key});
  String urlImage =
      "https://plus.unsplash.com/premium_photo-1669748157617-a3a83cc8ea23?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          card(listClassroom[0]),
          card(listClassroom[1]),
          card(listClassroom[2]),
          card(listClassroom[3]),
          card(listClassroom[4]),
        ],
      ),
    );
  }

  Color getRandomColor() {
    Random r = new Random();
    return Color.fromARGB(
      255,
      r.nextInt(255),
      r.nextInt(255),
      r.nextInt(255),
    );
  }

  Widget card(Classroom room) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          opacity: 0.7,
          image: NetworkImage(room.bgUrl),
        ),
        color: getRandomColor(),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "[${room.semester}] ${room.subject}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                Text(
                  " ${room.id}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "${room.totalStudent} học viên",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.more_horiz,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
