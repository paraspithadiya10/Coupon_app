import 'package:demo_app/data/local/db_helper.dart';
import 'package:demo_app/screens/login_screen.dart';
import 'package:demo_app/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DbHelper? dbRef;
  var userData = [];

  final userEmail = LoginScreenState.currentUser.isNotEmpty
      ? LoginScreenState.currentUser.first['email'] ??
          LoginScreenState.currentUser.first['email']
      : 'No email';

  @override
  void initState() {
    dbRef = DbHelper.getInstance;
    super.initState();
    getUserData();
  }

  Future<dynamic> getUserData() async {
    userData = await dbRef!.getUserByEmail(userEmail);
    setState(() {});
    return userData;
  }

  void deleteAccount() async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(SplashScreenState.KEYLOGIN, false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;

    List<ProfileList> profileMenuList = <ProfileList>[
      ProfileList(icon: Icons.notifications_outlined, label: 'Notifications'),
      ProfileList(icon: Icons.lock_outline, label: 'Privacy'),
      ProfileList(icon: Icons.security_outlined, label: 'Security'),
      ProfileList(icon: CupertinoIcons.person, label: 'My Account'),
      ProfileList(icon: Icons.error_outline, label: 'Help'),
      ProfileList(icon: Icons.info_outline_rounded, label: 'Information')
    ];

    return Scaffold(
      backgroundColor: Color(0xffFAF0FF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customAppBarUI(height, width),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Card(
                color: Color(0xffFAF0FF),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      CupertinoIcons.person_fill,
                      size: 40,
                    ),
                  ),
                  title: Text(
                    userData.isNotEmpty
                        ? userData.first['username'] ?? 'No username'
                        : 'Loading...',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(userEmail),
                  trailing: Icon(
                    Icons.navigate_next,
                    size: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            _settingTitleUI(context),
            SizedBox(
              height: height * 0.03,
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

  Widget _customAppBarUI(height, width) {
    return Stack(
      children: [
        Container(
          height: height * 0.1,
          width: width * 1.0,
          color: Color(0xffFAF0FF),
        ),
        SvgPicture.asset(
          'assets/images/home_background_1st_layer.svg',
          fit: BoxFit.fill,
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Card(
            elevation: 4,
            child: SizedBox(
              height: height * 0.04,
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Search',
                    labelStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none)),
              ),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.settings,
                  size: 35,
                )),
          ],
        )
      ],
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

class ProfileList {
  const ProfileList({required this.icon, required this.label});

  final IconData icon;
  final String label;
}
