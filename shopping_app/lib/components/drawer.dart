import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/login_page.dart';
import 'package:shopping_app/utils/user_provider.dart';

class MyDrawer extends StatefulWidget {
  final ValueChanged<int> onIndexSelected;

  const MyDrawer({
    Key? key,
    required this.onIndexSelected,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final isLoggedIn = userProvider.userData != null;

    return Container(
      width: MediaQuery.of(context).size.width * 2 / 3,
      decoration: const BoxDecoration(color: Colors.white),
      child: ListView(
        children: [
          _buildDrawerHeader(),
          _buildDrawerItem(
            context,
            icon: Icons.home_outlined,
            label: 'Home',
            onTap: () {
              widget.onIndexSelected(0);
              Navigator.pop(context);
            },
          ),
          if (isLoggedIn)
            _buildDrawerItem(
              context,
              icon: Icons.person_outline,
              label: 'My Profile',
              onTap: () {
                widget.onIndexSelected(2);
                Navigator.pop(context);
              },
            ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.contact_emergency,
            label: 'Contact',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.settings_outlined,
            label: 'Setting',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.help_outline,
            label: 'Help',
          ),
          Divider(),
          if (isLoggedIn)
            _buildDrawerItem(
              context,
              icon: Icons.logout_outlined,
              label: 'Logout',
              onTap: () {
                _logout(context);
              },
            ),
          if (!isLoggedIn)
            _buildDrawerItem(
              context,
              icon: Icons.login_outlined,
              label: 'Login',
              onTap: () {
                Navigator.pushNamed(context, LoginPage.routeName);
              },
            ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    Provider.of<UserProvider>(context, listen: false).setUserData(null);
    Navigator.pop(context);
  }

  DrawerHeader _buildDrawerHeader() {
    final userData = Provider.of<UserProvider>(context, listen: false).userData;
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              userData?.image ?? 'assets/images/default-avatar.jpg',
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${userData?.firstName ?? ''} ${userData?.lastName ?? ''}'
                          .trim()
                          .isEmpty
                      ? 'Guest'
                      : '${userData?.firstName ?? ''} ${userData?.lastName ?? ''}'
                          .trim(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  userData?.email ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(BuildContext context,
      {required IconData icon, required String label, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }
}
