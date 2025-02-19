import 'package:demo_app/screens/detail_screen.dart';
import 'package:demo_app/screens/discover_screen.dart';
import 'package:demo_app/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  void onDestinationChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        DetailScreen(),
        DiscoverScreen(),
        ProfileScreen(),
      ][selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        backgroundColor: Colors.white,
        elevation: 0,
        shape: CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.only(top: 11.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.building_2_fill,
                size: 30,
              ),
              Text('Discover')
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        indicatorColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        onDestinationSelected: onDestinationChanged,
        destinations: [
          NavigationDestination(
              selectedIcon: Icon(Icons.notification_important_sharp, size: 35),
              icon: Icon(
                Icons.notifications_outlined,
                size: 35,
              ),
              label: 'Notifications'),
          NavigationDestination(icon: SizedBox(), label: ''),
          NavigationDestination(
              selectedIcon: Icon(Icons.person_2_sharp, size: 35),
              icon: Icon(
                CupertinoIcons.person,
                size: 35,
              ),
              label: 'Me')
        ],
      ),
    );
  }
}
