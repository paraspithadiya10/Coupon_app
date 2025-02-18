import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                onPressed: (){
                  Navigator.pop(context);
                },
                  child: Text('Log out', style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Color(0xff1773FF)))
              ),
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
          Icon(Icons.arrow_back_ios_new),
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
