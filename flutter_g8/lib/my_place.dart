import 'dart:io';

import 'package:flutter/material.dart';

class MyPlace extends StatefulWidget {
  MyPlace({super.key});

  @override
  State<MyPlace> createState() => _MyPlaceState();
}

class _MyPlaceState extends State<MyPlace> {
  String bannerUrl =
      "https://imgcdn.tapchicongthuong.vn/tcct-media/24/4/19/dh-kh-dh-hue_662296164dae2.jpg";

  String content =
      "Được mệnh danh là một trong những bãi biển quyến rũ nhất hành tinh, Mỹ Khê nhanh chóng trở thành điểm đến thu hút đông đảo khách du lịch trong và ngoài nước. Không những vậy, biển Mỹ Khê còn nhận được sự quan tâm đặc biệt của báo chí quốc tế bởi nét đẹp quyến rũ, non nước hữu tình. Bởi vậy, đến Đà Nẵng mà không ghé thăm Mỹ Khê thì thực sự là một sự bỏ lỡ đáng tiếc.";

  bool likeStatus = true;
  int countLike = 41;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          banner(),
          header(),
          listButtons(),
          description(),
        ],
      ),
    );
  }

  Widget banner() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(bannerUrl),
        ),
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Biển Mỹ Khê",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                "Đà Nẵng",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (likeStatus) {
                      countLike -= 1;
                    } else
                      countLike += 1;
                    likeStatus = !likeStatus;
                  });
                },
                child: Icon(
                  Icons.star,
                  color: likeStatus ? Colors.red : Colors.black54,
                ),
              ),
              Text(
                "${countLike}",
              )
            ],
          )
        ],
      ),
    );
  }

  Widget listButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buttonActivity(Icons.call, "CALL"),
        buttonActivity(
          Icons.route,
          "ROUTE",
          color: Colors.red,
        ),
        buttonActivity(Icons.share, "SHARE"),
      ],
    );
  }

  Column buttonActivity(IconData icon, String str,
      {Color color = Colors.blue}) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
        Text(str),
      ],
    );
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(content),
    );
  }
}
