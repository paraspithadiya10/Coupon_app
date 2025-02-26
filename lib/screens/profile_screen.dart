import 'package:demo_app/data/preferences/pref_keys.dart';
import 'package:demo_app/providers/user_provider.dart';
import 'package:demo_app/screens/login_screen.dart';
import 'package:demo_app/widgets/appbar_with_search_and_icon.dart';
import 'package:demo_app/widgets/profile_listtile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, Object?>> currentUser = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    currentUser = await context.read<UserProvider>().getUserByStoredId();
    setState(() {});
  }

  void logoutUser() async {
    var sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(keyLogin, false);

    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;

    List<ProfileMenuItem> profileMenuList = <ProfileMenuItem>[
      ProfileMenuItem(
          icon: Icons.notifications_outlined, label: 'Notifications'),
      ProfileMenuItem(icon: Icons.lock_outline, label: 'Privacy'),
      ProfileMenuItem(icon: Icons.security_outlined, label: 'Security'),
      ProfileMenuItem(icon: CupertinoIcons.person, label: 'My Account'),
      ProfileMenuItem(icon: Icons.error_outline, label: 'Help'),
      ProfileMenuItem(icon: Icons.info_outline_rounded, label: 'Information')
    ];

    return Scaffold(
      backgroundColor: Color(0xffFAF0FF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppbarWithSearchAndIcon(icon: Icons.settings),
            _buildProfileInfo(),
            SizedBox(height: height * 0.03),
            _settingTitleUI(context),
            SizedBox(height: height * 0.02),
            _buildProfileMenuList(profileMenuList),
            SizedBox(height: height * 0.02),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return currentUser.isNotEmpty
        ? ProfileListTile(
            title: '${currentUser[0]['username']}',
            subtitle: '${currentUser[0]['email']}')
        : const ProfileListTile(title: 'No user data', subtitle: '');
  }

  Widget _settingTitleUI(context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Row(
        spacing: 3,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new)),
          Text(
            'SETTINGS',
            style: Theme.of(context).textTheme.headlineSmall,
          )
        ],
      ),
    );
  }

  Widget _buildProfileMenuList(List<ProfileMenuItem> menuItems) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: menuItems.map((menuList) {
          return ListTile(
            leading: Icon(
              menuList.icon,
              size: 25,
            ),
            title: Text(
              menuList.label,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0),
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog.adaptive(
              backgroundColor: Colors.white,
              title: Text('Confirmation'),
              content: Text('Are you sure to logout?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    logoutUser();
                    Navigator.pop(context);
                  },
                  child: Text('Ok'),
                ),
              ],
            ),
          );
        },
        child: Text(
          'Log out',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Color(0xff1773FF)),
        ),
      ),
    );
  }
}

class ProfileMenuItem {
  const ProfileMenuItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}
