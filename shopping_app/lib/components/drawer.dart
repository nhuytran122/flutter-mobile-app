import 'package:flutter/material.dart';
import 'package:shopping_app/entity/appColor.dart';
import 'package:shopping_app/entity/user.dart';

class MyDrawer extends StatelessWidget {
  final User? userData;
  final ValueChanged<int> onIndexSelected;

  const MyDrawer({
    Key? key,
    required this.userData,
    required this.onIndexSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 2 / 3,
      decoration: const BoxDecoration(color: Colors.white),
      child: ListView(
        children: [
          DrawerHeader(
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
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home_outlined,
            label: 'Home',
            onTap: () {
              onIndexSelected(0);
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person_outline,
            label: 'My Profile',
            onTap: () {
              onIndexSelected(2);
              Navigator.pop(context);
            },
          ),
          const Divider(),
          _buildDrawerItem(context,
              icon: Icons.contact_emergency, label: 'Contact'),
          _buildDrawerItem(context,
              icon: Icons.settings_outlined, label: 'Setting'),
          _buildDrawerItem(context, icon: Icons.help_outline, label: 'Help'),
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
