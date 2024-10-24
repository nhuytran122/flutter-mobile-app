import 'package:flutter/material.dart';

class MyClassroom2 extends StatelessWidget {
  const MyClassroom2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: myAppBar(),
      bottomNavigationBar: myBottomNavigationBar(),
      body: Column(
        children: [
          Padding(
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
          ),
          // Nội dung PageView hoặc các widget khác có thể thêm ở đây
          Expanded(
            child: Center(
              child: Text('Nội dung chính ở đây'),
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
