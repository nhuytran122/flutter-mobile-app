import 'package:flutter/material.dart';

class MyClassroom2 extends StatefulWidget {
  const MyClassroom2({super.key});

  @override
  State<MyClassroom2> createState() => _MyClassroom2State();
}

class _MyClassroom2State extends State<MyClassroom2> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: myAppBar(),
      bottomNavigationBar: myBottomNavigationBar(),
      body: Column(
        children: [
          myTwoButtons(),
          myPageView(),
          mybuildDotIndicator(),
        ],
      ),
    );
  }

  Padding mybuildDotIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(2, (index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index ? Colors.blue : Colors.grey,
            ),
          );
        }),
      ),
    );
  }

  Expanded myPageView() {
    return Expanded(
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.link, size: 100, color: Colors.blueAccent),
                  SizedBox(height: 16),
                  Text(
                    'Nhận đường liên kết bạn có thể chia sẻ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Nhấn vào Cuộc họp mới để nhận một đường liên kết mà bạn có thể gửi cho những người mình muốn họp cùng',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 100, color: Colors.blueAccent),
                  SizedBox(height: 16),
                  Text(
                    'Cuộc họp luôn an toàn',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Không ai bên ngoài tổ chức của bạn có thể tham gia cuộc họp trừ phi người tổ chức mời hoặc cho phép',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding myTwoButtons() {
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
      items: [
        myBottomNaviBarItem(Icons.mail),
        myBottomNaviBarItem(Icons.message),
        myBottomNaviBarItem(Icons.video_camera_back, color: Colors.red),
      ],
    );
  }

  BottomNavigationBarItem myBottomNaviBarItem(IconData iconData,
      {Color? color}) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        color: color ?? Colors.black,
      ),
      label: '',
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
