import 'package:flutter/material.dart';

class MyHomepage extends StatelessWidget {
  MyHomepage({super.key});
  String urlImage =
      "https://imgcdn.tapchicongthuong.vn/tcct-media/24/4/19/dh-kh-dh-hue_662296164dae2.jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          flagVietNam(),
          flashCard(urlImage),
          SizedBox(
            height: 20,
          ),
          greedy(Colors.red, Colors.yellow, "Hello Việt Nam"),
          SizedBox(
            height: 20,
          ),
          greedy(const Color.fromARGB(255, 2, 83, 117), Colors.white,
              "Hello HUSC"),
          SizedBox(
            height: 20,
          ),
          greedy(
              const Color.fromARGB(255, 2, 83, 117), Colors.white, "Hello K45"),
          flagVietNam(),
        ],
      ),
    );
  }

  Widget flashCard(String bgUrl) {
    return Container(
      child: Center(
          child: Text(
        "Xin chào Đại học Khoa học",
        style: TextStyle(
          shadows: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2, 2),
            )
          ],
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      )),
      height: 300,
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        image: DecorationImage(
          opacity: 0.3,
          fit: BoxFit.cover,
          image: NetworkImage(bgUrl),
        ),
        color: Colors.amber,
      ),
    );
  }

  Widget greedy(Color bgColor, Color fgColor, String str) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.black,
            offset: Offset(2, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        color: bgColor,
      ),
      child: Center(
        child: Text(
          str,
          style: TextStyle(
            color: fgColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container flagVietNam() {
    return Container(
      margin: EdgeInsets.all(20),
      height: 400,
      decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 7, 7)),
      child: Center(
          child: Icon(
        Icons.star,
        color: Colors.yellow,
        size: 200,
      )),
    );
  }
}
