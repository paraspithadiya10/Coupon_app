import 'package:demo_app/data/local/db_helper.dart';
import 'package:demo_app/data/preferences/pref_keys.dart';
import 'package:demo_app/screens/login_screen.dart';
import 'package:demo_app/widgets/appbar_with_search_and_icon.dart';
import 'package:demo_app/widgets/profile_listtile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DbHelper? dbRef;
  List<Map<String, Object?>> currentUser = [];

  @override
  void initState() {
    super.initState();
    dbRef = DbHelper.getInstance;
    getCurrentUser();
  }

  Future<List<Map<String, Object?>>> getCurrentUser() async {
    currentUser = await dbRef!.getUserByStoredId();
    setState(() {});
    return currentUser;
  }

  void deleteAccount() async {
    var sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool(keyLogin, false);

    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;

    List<ProfileMenuList> profileMenuList = <ProfileMenuList>[
      ProfileMenuList(
          icon: Icons.notifications_outlined, label: 'Notifications'),
      ProfileMenuList(icon: Icons.lock_outline, label: 'Privacy'),
      ProfileMenuList(icon: Icons.security_outlined, label: 'Security'),
      ProfileMenuList(icon: CupertinoIcons.person, label: 'My Account'),
      ProfileMenuList(icon: Icons.error_outline, label: 'Help'),
      ProfileMenuList(icon: Icons.info_outline_rounded, label: 'Information')
    ];

    return Scaffold(
      backgroundColor: Color(0xffFAF0FF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppbarWithSearchAndIcon(icon: Icons.settings),
            if (currentUser.isNotEmpty)
              ProfileListTile(
                  title: '${currentUser.first['username']}',
                  subtitle: '${currentUser.first['email']}')
            else
              ProfileListTile(title: 'No user data', subtitle: ''),
            SizedBox(
              height: height * 0.03,
            ),
            _settingTitleUI(context),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                  children: profileMenuList.map((menuList) {
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
              }).toList()),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
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
                                    child: Text('Cancel')),
                                TextButton(
                                    onPressed: () {
                                      deleteAccount();
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ok'))
                              ],
                            ));
                  },
                  child: Text('Log out',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Color(0xff1773FF)))),
            )
          ],
        ),
      ),
    );
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
}

class ProfileMenuList {
  const ProfileMenuList({required this.icon, required this.label});

  final IconData icon;
  final String label;
}
