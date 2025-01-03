import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_g8/entity/classroom.dart';
import 'package:flutter_g8/entity/pageviewinfo.dart';

class MyClassroom2 extends StatefulWidget {
  const MyClassroom2({super.key});

  @override
  State<MyClassroom2> createState() => _MyClassroom2State();
}

class _MyClassroom2State extends State<MyClassroom2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(context),
      appBar: myAppBar(),
      bottomNavigationBar: myBottomNavigationBar(),
      body: Column(
        children: [
          myRowButtons(),
          myPageView(),
          mybuildDotIndicator(),
        ],
      ),
    );
  }

  Widget myDrawer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 2 / 3,
      decoration: BoxDecoration(color: Colors.white),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Google Classroom',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          myOptionalInDrawer(
            Icons.home_outlined,
            'Lớp học',
            () {
              // Xử lý khi nhấn vào "Lớp học"
            },
          ),
          myOptionalInDrawer(
            Icons.calendar_today_outlined,
            'Lịch',
            () {
              // Xử lý khi nhấn vào LLịch"
            },
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              'ĐANG GIẢNG DẠY',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Sử dụng map để tạo các ListTile từ listClassroom
          ...listClassroom.map((e) => myListTileItem(e)).toList(),
          Divider(),
          myOptionalInDrawer(
              Icons.archive_outlined, 'Lớp học đã lưu trữ', () {}),
          myOptionalInDrawer(
              Icons.folder_outlined, 'Thư mục của Lớp học', () {}),
          myOptionalInDrawer(Icons.settings_outlined, 'Cài đặt', () {}),
          myOptionalInDrawer(Icons.help_outline, 'Trợ giúp', () {}),
        ],
      ),
    );
  }

  ListTile myOptionalInDrawer(
      IconData iconData, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(label),
      onTap: onTap,
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

  Widget myListTileItem(Classroom classroom) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: getRandomColor(),
        child: Text(
          classroom.subject.substring(0, 1),
        ),
      ),
      title: Text(classroom.subject),
      subtitle: Text(classroom.id),
      onTap: () {
        // Xử lý khi nhấn vào lớp học
      },
    );
  }

  Widget myPageView() {
    return Expanded(
      child: PageView(
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: listPageViewMeeting.map((e) => myPageViewItem(e)).toList(),
      ),
    );
  }

  Widget myPageViewItem(PageViewInfo p) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(p.avtUrl),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              '${p.title}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${p.content}',
            style: TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  int currentPage = 0;
  Widget mybuildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        listPageViewMeeting.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 1),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: currentPage == index ? Colors.blue : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Padding myRowButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => null,
            child: Text(
              'Cuộc họp mới',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              fixedSize: Size(190, 40),
            ),
          ),
          SizedBox(width: 16),
          OutlinedButton(
            onPressed: () => null,
            child: Text(
              'Tham gia cuộc họp',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.black45),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              fixedSize: Size(190, 40),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar myBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 2,
      selectedItemColor: Colors.red,
      items: [
        myBottomNaviBarItem(Icons.mail, 'Email'),
        myBottomNaviBarItem(Icons.message, 'Message'),
        myBottomNaviBarItem(Icons.video_camera_back, 'Meeting'),
      ],
    );
  }

  BottomNavigationBarItem myBottomNaviBarItem(IconData iconData, String label) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
      ),
      label: label,
    );
  }

  AppBar myAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          'Họp mặt',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: ClipOval(
            child: Image.asset(
              'assets/images/my_avt.jpg',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
