import 'package:flutter/material.dart';
import 'package:flutter_g8/entity/shoppingcart2.dart';

class MyProfilePage extends StatefulWidget {
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: myProfileBody(),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context, true);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 30,
        ),
      ),
      title: Text(
        "My Profile",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/shoppingcart2").then((value) {
                  if (value == true) {
                    setState(() {}); // Cập nhật khi quay về
                  }
                });
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
            shoppingCart2.items.isEmpty ? SizedBox.shrink() : myIconCart(),
          ],
        ),
      ],
    );
  }

  Widget myProfileBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/my_avt.jpg'),
            backgroundColor: Colors.grey[200],
          ),
          SizedBox(height: 16),
          Text(
            "Nhu Y",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          // Email
          Text(
            "21t1020105@husc.edu.vn",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone, color: Colors.blue),
            title: Text("Phone"),
            subtitle: Text("+84 123 456 789"),
          ),
          ListTile(
            leading: Icon(Icons.location_on, color: Colors.red),
            title: Text("Address"),
            subtitle: Text("Hue"),
          ),
        ],
      ),
    );
  }

  Positioned myIconCart() {
    return Positioned(
      right: 5,
      top: 5,
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${shoppingCart2.items.length}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
