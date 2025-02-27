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

  final List<Widget> _screens = [
    const DetailScreen(),
    const DiscoverScreen(),
    const ProfileScreen(),
  ];

  void onDestinationChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: _screens[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildDiscoverButton(context, showFab),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget _buildDiscoverButton(context, showFab) {
    return Visibility(
      visible: !showFab,
      child: FloatingActionButton.large(
        onPressed: () => onDestinationChanged(1),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const CircleBorder(),
        child: const Column(
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
    );
  }

  Widget _buildNavigationBar() {
    final destinations = [
      const NavigationDestination(
        selectedIcon: Icon(Icons.notification_important_sharp, size: 35),
        icon: Icon(Icons.notifications_outlined, size: 35),
        label: 'Notifications',
      ),
      const NavigationDestination(icon: SizedBox(), label: ''),
      const NavigationDestination(
        selectedIcon: Icon(Icons.person_2_sharp, size: 35),
        icon: Icon(CupertinoIcons.person, size: 35),
        label: 'Me',
      ),
    ];

    return NavigationBar(
      selectedIndex: selectedIndex,
      indicatorColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      onDestinationSelected: onDestinationChanged,
      destinations: destinations,
    );
  }
}
