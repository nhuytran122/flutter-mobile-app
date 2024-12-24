import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/user.dart';
import 'package:shopping_app/utils/user_provider.dart';

class MyProfileScreen extends StatefulWidget {
  static String routeName = "my_profile";

  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late User? userData;

  @override
  void initState() {
    super.initState();
    // userData = Provider.of<UserProvider>(context).userData;
    userData = Provider.of<UserProvider>(context, listen: false).userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myProfileBody(),
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
              userData?.image ?? 'assets/images/default-avatar.jpg',
            ),
            backgroundColor: Colors.grey[200],
          ),
          SizedBox(height: 16),
          Text(
            '${userData?.firstName ?? ''} ${userData?.lastName ?? ''}'
                    .trim()
                    .isEmpty
                ? 'Guest'
                : '${userData?.firstName ?? ''} ${userData?.lastName ?? ''}'
                    .trim(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            userData?.username ?? 'Guest',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 20),
          if (userData != null) ...[
            buildInforUser(
                "Email", userData?.email.toString() ?? '', Icons.mail),
            buildInforUser(
                "Age", userData?.age.toString() ?? '', Icons.numbers),
            buildInforUser("Gender", userData?.gender ?? "", Icons.person),
            buildInforUser(
                "Phone", userData?.phone.toString() ?? '', Icons.phone),
            buildInforUser("Birth Date", userData?.birthDate.toString() ?? '',
                Icons.calendar_today),
            buildInforUser(
              "Address",
              "${userData?.address.address}, ${userData?.address.city}, ${userData?.address.state}",
              Icons.location_on,
            ),
          ] else ...[
            buildInforUser("Email", 'Not available', Icons.mail),
            buildInforUser("Age", 'Not available', Icons.numbers),
            buildInforUser("Gender", 'Not available', Icons.person),
            buildInforUser("Phone", 'Not available', Icons.phone),
            buildInforUser("Birth Date", 'Not available', Icons.calendar_today),
            buildInforUser("Address", 'Not available', Icons.location_on),
          ],
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
