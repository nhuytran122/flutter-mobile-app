import 'package:flutter/material.dart';
import 'package:shopping_app/entity/appColor.dart';

class MyProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const MyProfilePage({Key? key, required this.userData}) : super(key: key);

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
      backgroundColor: AppColors.primary,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
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
            backgroundImage: NetworkImage(
              widget.userData['image'] ?? 'https://via.placeholder.com/150',
            ),
            backgroundColor: Colors.grey[200],
          ),
          SizedBox(height: 16),
          Text(
            '${widget.userData["firstName"]} ${widget.userData["lastName"]}'
                    .trim()
                    .isEmpty
                ? 'Guest'
                : '${widget.userData["firstName"]} ${widget.userData["lastName"]}'
                    .trim(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          // Email
          Text(
            widget.userData['username'] ?? '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 20),
          buildInforUser(
              "Email", widget.userData['email']?.toString() ?? '', Icons.mail),
          buildInforUser(
              "Age", widget.userData['age']?.toString() ?? '', Icons.numbers),
          buildInforUser(
              "Phone", widget.userData['phone']?.toString() ?? '', Icons.phone),
        ],
      ),
    );
  }

  Widget buildInforUser(String title, String inf, IconData iconData) {
    return Column(
      children: [
        SizedBox(height: 8),
        ListTile(
          leading: Icon(iconData, color: AppColors.primary),
          title: Text(title),
          subtitle: Text(inf),
        ),
      ],
    );
  }
}
